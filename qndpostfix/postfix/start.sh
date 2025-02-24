#!/bin/bash



function log {
  echo "$(date) $ME - $@"
}

function addUserInfo {
  local user_name="support"
  local user_maildir="/var/mail/smartquail.io/${user_name}"

  # Verifica si el usuario ya existe
  if ! id -u "$user_name" &>/dev/null; then
    log "Adding user '${user_name}'"

    # Añade el usuario con un directorio home (el directorio home no será utilizado para el correo)
    adduser --system --home "/home/$user_name" --no-create-home "$user_name"

    # Crea el directorio de Maildir si no existe
    mkdir -p "$user_maildir/{tmp,new,cur}"
    
    # Ajusta los permisos del directorio de Maildir
    chown -R vmail:vmail "$user_maildir"
    chmod -R 700 "$user_maildir"

    log "User '${user_name}' added with maildir '${user_maildir}'"
  else
    log "User '${user_name}' already exists"
  fi
}



function serviceConf {
  if [[ ! $HOSTNAME =~ \. ]]; then
    HOSTNAME="$HOSTNAME.$DOMAIN"
  fi

  for VARIABLE in $(env | cut -f1 -d=); do
    VAR=${VARIABLE//:/_}
    VALUE=${!VAR}
    sed -i "s|{{ $VAR }}|$VALUE|g" /etc/postfix/*.cf
  done

  if [ -f /overrides/postfix.cf ]; then
    while read -r line; do
      [[ -n "$line" && "$line" != [[:blank:]#]* ]] && postconf -e "$line"
    done < /overrides/postfix.cf
    echo "Loaded '/overrides/postfix.cf'"
  else
    echo "No extra postfix settings loaded because optional '/overrides/postfix.cf' not provided."
  fi

  if ls -A /overrides/*.map 1> /dev/null 2>&1; then
    cp /overrides/*.map /etc/postfix/
    postmap /etc/postfix/*.map
    rm /etc/postfix/*.map
    chown root:root /etc/postfix/*.db
    chmod 0600 /etc/postfix/*.db
    echo "Loaded 'map files'"
  else
    echo "No extra map files loaded because optional '/overrides/*.map' not provided."
  fi
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
  addUserInfo
  serviceConf
  setPermissions
  log "[ Iniciando Postfix... ]"
  /usr/sbin/postfix start-fg
}



serviceStart &>> /proc/1/fd/1
