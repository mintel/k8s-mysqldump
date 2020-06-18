FROM alpine:3.11

ARG BUILD_DATE
ARG VCS_REF

RUN echo $BUILD_DATE
RUN echo $VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/mintel/k8s-mysqldump.git" \
      org.label-schema.schema-version="1.0.0-rc1" \
      org.label-schema.name="k8s-mysqldump" \
      org.label-schema.description="An image to perform mysqldumps and push the data to a Google bucket using restic" \
      org.label-schema.vendor="Mintel Group Ltd." \
      maintainer="Bobby Brockway <bbrockway@mintel.com>"

ENV TABLE_FILE /config/tables.txt
ENV DB_HOST \
    DB_NAME \
    DB_PASSWORD \
    DB_USER \
    RESTIC_GOOGLE_APPLICATION_CREDENTIALS \
    RESTIC_GOOGLE_PROJECT_ID \
    RESTIC_PASSWORD \
    RESTIC_REPOSITORY

RUN apk update \
  && apk --no-cache upgrade \
  && apk --no-cache add bash ca-certificates coreutils mysql-client wget \
  && wget -O /usr/local/share/ca-certificates/fakelerootx1.crt https://letsencrypt.org/certs/fakelerootx1.pem \
  && wget -O /usr/local/share/ca-certificates/fakeleintermediatex1.crt https://letsencrypt.org/certs/fakeleintermediatex1.pem \
  && update-ca-certificates \
  && rm -rf /var/cache/apk/*

# Install restic
ENV RESTIC_VERSION="0.9.5" \
    RESTIC_SHA512="c040dfe9c73a0bc8de46ccdf4657c9937b27a3c1bd25941f40c9efd1702994f54e79f077288e626a5841fbf9bbf642b6d821628cf6b955d88b97f07e5916daac"

RUN wget -O /tmp/restic-${RESTIC_VERSION}.bz2 "https://github.com/restic/restic/releases/download/v${RESTIC_VERSION}/restic_${RESTIC_VERSION}_linux_amd64.bz2" \
  && cd /tmp \
  && echo "${RESTIC_SHA512}  restic-${RESTIC_VERSION}.bz2" | sha512sum -c - \
  && bunzip2 -c restic-${RESTIC_VERSION}.bz2 > /usr/local/bin/restic \
  && chmod a+x /usr/local/bin/restic

# Copy in kubelock and vault-env
COPY --from=mintel/satoshi-devtools:1.0.0 /usr/local/bin/* /usr/local/bin/

RUN adduser -D -s /bin/bash -u 1000 mintel
RUN mkdir /data && chmod 777 /data

COPY ./rootfs /

USER 1000
RUN mkdir -p /home/mintel/.config/backup/restic/repos \
  && mkdir -p /home/mintel/.config/backup/restic/sets

ENTRYPOINT ["/usr/local/bin/db-dump"]
