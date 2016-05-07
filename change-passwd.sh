#!/bin/bash

#	change-passwd.sh
#	created: 30 Oct 2014
#	author: Tobias Morrison
#
#	Changes a password for a user account. 
#	Be aware that this method will break Keychain login sync on the account.
#
#	CHANGES:
#	0.5		// 	Make script interactive
#	0.2		//	Change method to dscl

## Make sure script is run by root
if [[ $EUID -ne 0 ]]; then
    echo "Script must be run as root" 1>&2
    exit 1
fi

#### Give the user some instructions
echo "---------------------------------------------------------------------"
echo "|                                                                   |"
echo "|  This script will change a user password. It is a brute-force     |"
echo "|  change for special circumstances. It has the consequence of      |"
echo "|  breaking keychain syncing. If used and the employee does not     |"
echo "|  remember their password, you will need to create a new Keychain. |"
echo "|  It requires root privledges to run. If you make a mistake,       |"
echo "|  cancel the script by using the key combo control + C.            |"
echo "|                                                                   |"
echo "---------------------------------------------------------------------"

# Ask the admin for the user name and new password
echo -n "Enter user shortname: "
read shname
echo -n "Enter the new password: "
read newpw

/usr/bin/dscl . -passwd /Users/"$shname" "$newpw"
status=$?

if [ $status == 0 ]; then
echo "Password was changed successfully."
elif [ $status != 0 ]; then
echo "An error was encountered while attempting to change the password. /usr/bin/dscl exited $status."
fi