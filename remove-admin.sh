#!/bin/bash

#	remove-admin.sh
#	version: 0.1
#	created: 10 Dec 2014
#	author:	Tobias Morrison
#
#	Demote an Admin user to Standard user.
#
#	Sourced from Greg Neagle's post: http://managingosx.wordpress.com/2010/01/14/add-a-user-to-the-admin-group-via-command-line-3-0/
#
#	-d removes the user from the group 'admin'. Replace -d with -a to add the user to the 'admin' group.

## Make sure script is run by root
if [[ $EUID -ne 0 ]]; then
    echo "Script must be run as root" 1>&2
    exit 1
fi

#	Add the user's shortname
SHORTNAME="user"

#	Let the robot do the work.
/usr/sbin/dseditgroup -o edit -d $SHORTNAME -t user admin

#	Tell me the results.
STATUS=$?

if [ $STATUS == 0 ]; then
	echo "User was demoted to standard successfully."
elif [ $STATUS != 0 ]; then
	echo "An error was encountered while attempting to change the user's group. /usr/sbin/dseditgroup exited $STATUS."
fi