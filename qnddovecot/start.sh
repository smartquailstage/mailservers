#!/bin/sh

# Define the user and group
USER="vmail"
GROUP="vmail"

# Define the main directory
MAIL_DIR="/var/mail"

# Start Dovecot in the background
echo "Starting Dovecot..."
dovecot &

# Wait a few seconds to ensure Dovecot starts up correctly
sleep 10

# Create the main mail directory if it doesn't exist
if [ ! -d "$MAIL_DIR" ]; then
    echo "Creating mail directory: $MAIL_DIR"
    mkdir -p "$MAIL_DIR"
fi

# Adjust ownership and permissions for the main mail directory
echo "Setting permissions and ownership for $MAIL_DIR"
chown -R $USER:$GROUP "$MAIL_DIR"
chmod 755 "$MAIL_DIR"

# Recursively adjust ownership and permissions for all directories and files under $MAIL_DIR
echo "Setting permissions and ownership for all directories and files under $MAIL_DIR"
find "$MAIL_DIR" -type d -exec chown $USER:$GROUP {} \; -exec chmod 755 {} \;
find "$MAIL_DIR" -type f -exec chown $USER:$GROUP {} \; -exec chmod 644 {} \;

# Check if /var/mail/info@mail.smartquail.io/tmp exists; create if needed
INFO_DIR="$MAIL_DIR/info@mail.smartquail.io/tmp"
if [ ! -d "$INFO_DIR" ]; then
    echo "Creating directory: $INFO_DIR"
    mkdir -p "$INFO_DIR"
fi

# Adjust ownership and permissions for the specific info directory
echo "Setting permissions and ownership for $INFO_DIR"
chown $USER:$GROUP "$INFO_DIR"
chmod 755 "$INFO_DIR"

# Verify the results
echo "Verification of permissions and ownership:"
ls -ld "$MAIL_DIR"
ls -ld "$MAIL_DIR/info@mail.smartquail.io"
ls -ld "$INFO_DIR"

echo "Permissions and ownership have been set."

# Keep the container running by tailing the log file
# If the log file does not exist, this will fail. So, let's use a different method to keep the container running.
# The default location is /var/log/dovecot.log; ensure the log file exists or change to another file if needed.
tail -f /var/log/dovecot.log || tail -f /dev/null
