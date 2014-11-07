#!/bin/bash

#	change-passwd.sh
#	version: 0.2
#	created: 30 Oct 2014
#	author: Tobias Morrison
#
#	Changes a password for a user account. 
#	Be aware that this method will break Keychain login sync on the account.

#	add the user shortname and password to the variables.
user="admin"
password="password"

/usr/bin/dscl . -passwd /Users/"$user" "$password"
status=$?

if [ $status == 0 ]; then
echo "Password was changed successfully."
elif [ $status != 0 ]; then
echo "An error was encountered while attempting to change the password. /usr/bin/dscl exited $status."
fi