#!/bin/sh

# Setup permissions for ssh access
chown -R $SSH_USER:$SSH_GROUP /home/$SSH_USER/.ssh
chmod 700 /home/$SSH_USER/.ssh
chmod 600 /home/$SSH_USER/.ssh/authorized_keys

# Run SSH daemon (as non-daemon) and redirect errors to standard output
/usr/sbin/sshd -D -e
