#!/bin/bash



function log {
  echo "$(date) $ME - $@"
}






function setPermissions {
  # Ensure directories and files have correct permissions
  log "Setting permissions for Postfix directories and files..."

  # Set ownership and permissions for Postfix directories
  chown -R postfix:postfix /var/spool/postfix
  chmod 750 /var/spool/postfix/private
  chmod 750 /var/spool/postfix

  # Set ownership and permissions for Postfix configuration files
  chown -R root:root /etc/postfix
  chmod 640 /etc/postfix/*.cf

  # Set ownership and permissions for mail directories
  chown -R postfix:postfix /var/mail/
  chmod 700 /var/mail/

}

function serviceStart {

  setPermissions
  log "[ Iniciando Postfix... ]"
  /usr/sbin/postfix start-fg
}


serviceStart &>> /proc/1/fd/1
