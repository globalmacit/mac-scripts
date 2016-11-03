#!/bin/bash

#	make-admin.sh
#	created: 10 Dec 2014
#	author:	Tobias Morrison
#
#	Elevate a Standard user to the admin group.
#
#	Sourced from Greg Neagle's post: http://managingosx.wordpress.com/2010/01/14/add-a-user-to-the-admin-group-via-command-line-3-0/
#
#	-a adds the user to the group 'admin'. replace -a with -d to remove the user from the 'admin' group.
#
#	CHANGES:
#	0.2		//	Make interactive
#	0.1		// 	Initial release

## Make sure script is run by root
if [[ $EUID -ne 0 ]]; then
    echo "Script must be run as root" 1>&2
    exit 1
fi

#### Give the user some instructions
echo "-----------------------------------------------------------------------"
echo "|                                                                     |"
echo "|  This script will elevate a standard account to a admin account.    |"
echo "|  It requires root privledges to run. You will be asked for the      |"
echo "|  user shortname. If you make a mistake, cancel the script by        |"
echo "|  by using the key combo control + C.                                |"
echo "|                                                                     |"
echo "-----------------------------------------------------------------------"

## Ask the admin for the user name
echo -n "Enter user shortname: "
read shname

#	Let the robot do the work.
/usr/sbin/dseditgroup -o edit -a "$shname" -t user admin

#	Tell me the results.
STATUS=$?

if [ $STATUS == 0 ]; then
	echo "User was elevated to admin successfully."
elif [ $STATUS != 0 ]; then
	echo "An error was encountered while attempting to change the user's group. /usr/sbin/dseditgroup exited $STATUS."
fi