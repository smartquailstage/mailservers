#!/bin/bash



function log {
  echo "$(date) $ME - $@"
}



function serviceStart {
  log "[ Iniciando Postfix... ]"
  /usr/sbin/postfix start-fg
}



serviceStart &>> /proc/1/fd/1