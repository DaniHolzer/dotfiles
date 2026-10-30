#!/bin/sh
#------------------------------------------------------------------------------
#----- SSH Askpass from GNOME Keyring
#
# ssh-add calls this (via SSH_ASKPASS) with a prompt like
# "Enter passphrase for /home/user/.ssh/key: " and reads the passphrase from
# stdout. Passphrases are stored once with `sshstore`.
key=$(printf '%s' "$1" | sed -n 's/^Enter passphrase for \(.*\): *$/\1/p')
[ -n "$key" ] && exec secret-tool lookup ssh-key "$key"
exit 1
