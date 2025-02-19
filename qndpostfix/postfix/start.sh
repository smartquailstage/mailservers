#!/bin/bash

function log {
  echo "$(date) $ME - $@"
}



function serviceStart {
  log "[ Iniciando Postfix... ]"
  # Iniciar Postfix en segundo plano
  /usr/sbin/postfix start-fg &
  # Esperar a que Postfix haya iniciado
  wait $!
  
  log "[ Iniciando OpenDKIM... ]"
  # Iniciar OpenDKIM en segundo plano (ajustar con el comando correcto)
  /usr/sbin/opendkim &
}

serviceStart &>> /proc/1/fd/1
