# Dockerfile for Postfix with OpenDKIM
FROM alpine:3.16

LABEL maintainer="your-email@example.com"

ENV container=docker \
    LC_ALL=C \
    TZ=America/Guayaquil


# Install Postfix, OpenDKIM and necessary dependencies
RUN apk update && apk add --no-cache \
    postfix \
    postfix-pcre \
    postfix-pgsql \
    cyrus-sasl \
    bash \
    curl \
    openssl \
    iproute2 \
    postfix-ldap \
    postgresql-client \
    pcre \
    db \
    gdbm \
    opendkim 




# Expose the necessary ports for SMTP, secure connections and OpenDKIM
EXPOSE 25 465 587 8891

# Define the volume
VOLUME ["/var/mail/"]

# Define entrypoint script to start both OpenDKIM and Postfix
COPY postfix/start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

ENTRYPOINT ["/usr/local/bin/start.sh"]
