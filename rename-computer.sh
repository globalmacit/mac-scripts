#!/bin/bash

#	rename-computer.sh
#	version: 0.2
#	created: 06 Nov 2014
#	author:	Tobias Morrison
#
#	Sets Computer Name, Local Host Name, and Host Name 
#	on a standard OS X client system.


#	Fill out the following three items, using proper capitalization.
FIRST_NAME="Steve"
LAST_NAME="Smith"
COMPANY="WidgetCo"

#	Let the robot do the work.
makelower() {
echo $1 | tr '[:upper:]' '[:lower:]'
}

SYSTEM=`system_profiler SPHardwareDataType | grep "Model Identifier:" | awk '{print $3;}' | sed 's/[0-9][,]*//g'`
L_FIRST_NAME=`makelower $FIRST_NAME`
L_LAST_NAME=`makelower $LAST_NAME`
L_COMPANY=`makelower $COMPANY`
L_SYSTEM=`makelower $SYSTEM`

/usr/sbin/scutil --set ComputerName $FIRST_NAME$LAST_NAME-$SYSTEM-$COMPANY
/usr/sbin/scutil --set LocalHostName $L_FIRST_NAME$L_LAST_NAME-$L_SYSTEM-$L_COMPANY
/usr/sbin/scutil --set HostName $L_FIRST_NAME$L_LAST_NAME-$L_SYSTEM-$L_COMPANY.local

#	Tell me the results.
status=$?

if [ $status == 0 ]; then
	echo "Computer identity was changed successfully."
elif [ $status != 0 ]; then
	echo "An error was encountered while attempting to change the computer identity. /usr/sbin/scutil exited $status."
fi