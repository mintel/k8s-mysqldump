DB_SCHEMA=portal
DUMP_TEMP_PATH=/data/tmp
DUMP_FINAL_PATH=/data/backup

# Dumps the database into a temporary file and then moves it to DUMP_FINAL_PATH
# Synopsis:
#   dump out_file_basename [options...]
function dump()
{
    dump_basename="$1"
    shift

    if raw_dump "$@" >"$DUMP_TEMP_PATH/$dump_basename"
    then
        mv -f "$DUMP_TEMP_PATH/$dump_basename" "$DUMP_FINAL_PATH"
    else
        echo "Dump of $DB_SCHEMA failed on $HOSTNAME" 1>&2
        return 1
    fi
}

# Dumps the database into a temporary file and then compresses it and
# moves it to DUMP_FINAL_PATH
# Synopsis:
#   dump out_file_basename [options...]
function dump_zipped()
{
    dump_basename="$1"
    shift

    if raw_dump "$@" >"$DUMP_TEMP_PATH/$dump_basename"
    then
        bzip2 -z9 "$DUMP_TEMP_PATH/$dump_basename"
        mv -f "$DUMP_TEMP_PATH/$dump_basename.bz2" "$DUMP_FINAL_PATH"
    else
        echo "Dump of $DB_SCHEMA failed on $HOSTNAME" 1>&2
        return 1
    fi
}

# Dumps the database
# Synopsis:
#   dump [options...]
function raw_dump()
{
    scl enable mariadb10 -- mysqldump -u"$DB_USERNAME" -p"$DB_PASSWORD" "$DB_SCHEMA" "$@"
}