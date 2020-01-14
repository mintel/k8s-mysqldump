#!/bin/bash
# This script creates a dump of the tables used by usage

HERE="$(dirname "$(readlink -se "${BASH_SOURCE[0]}")")"

USAGE_TABLES=(
    idp_organizationproperty
    idp_organizationpropertyvalue
    idp_userusergrouppreferences
    idp_customorganizationpropertyvalue
    idp_userprofile
    idp_userorganizationproperty
    idp_organization
    idp_product
    idp_productaccessright
    auth_user
    idp_usergroup
    idp_usergroupproductpreferences
    idp_standardcountry
    idp_marketingdepartment
    idp_defaultmandatorypropertyoverride
    idp_department
    idp_orgmandatorypropertyoverride
    idp_organizationtype
    idp_pointofcontact
    idp_usergroup_points_of_contact
    idp_usergroupsignupfilter
    idp_usergroupsignuprule
    idp_supplementaryproductaccessright
    idp_usergroup_supplementary_product_access_rights
    idp_centralaccess
    idp_centralaccess_user
    idp_centralaccess_usergroup
)

source "$HERE/dump.sh"

dump portal_userdata.sql --add-drop-table --tables "${USAGE_TABLES[@]}"
