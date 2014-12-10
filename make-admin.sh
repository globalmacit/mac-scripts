#!/bin/bash

#	make-admin.sh
#	version: 0.1
#	created: 10 Dec 2014
#	author:	Tobias Morrison
#
#	Elevate a Standard user to the admin group.
#
#	Sourced from Greg Neagle's post: http://managingosx.wordpress.com/2010/01/14/add-a-user-to-the-admin-group-via-command-line-3-0/
#
#	-a adds the user to the group 'admin'. replace -a with -d to remove the user from the 'admin' group.

#	Add the user's shortname
SHORTNAME="user"

#	Let the robot do the work.
/usr/sbin/dseditgroup -o edit -a $SHORTNAME -t user admin

#	Tell me the results.
STATUS=$?

if [ $STATUS == 0 ]; then
	echo "User was elevated to admin successfully."
elif [ $STATUS != 0 ]; then
	echo "An error was encountered while attempting to change the user's group. /usr/sbin/dseditgroup exited $STATUS."
fi