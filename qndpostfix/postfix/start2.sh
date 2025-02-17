#!/bin/bash

# Start OpenDKIM
/usr/sbin/opendkim -x /etc/opendkim/opendkim.conf &

# Start Postfix
/usr/sbin/postfix start-fg