#!/bin/bash

#	rename-computer.sh
#	version: 0.2
#	created: 06 Nov 2014
#	author:	Tobias Morrison
#
#	Sets Computer Name, Local Host Name, and Host Name 
#	on a standard OS X client system.
#	
#	This script assumes Watchman Monitoring 
#	(https://www.watchmanmonitoring.com)
#	is installed and has a Group assigned.


#	Provide the company abbreviated name.
COMPANY="defaults read /Library/MonitoringClient/ClientSettings ClientGroup | sed 's/[a-z][ ]*//g'"
/bin/echo "The abbreviated company name is $COMPANY"

#	Get the currently logged in user name.
CURRENTUSER=`finger $USER | egrep -o 'Name: [a-zA-Z0-9 ]{1,}' | cut -d ':' -f 2 | xargs echo`
/bin/echo "The current logged in user is $CURRENTUSER"

#	Get the hardware name from the system and abreviate it.
SYSTEM=`system_profiler SPHardwareDataType | grep "Model Identifier:" | awk '{print $3;}' | \
	sed 's/[0-9][,]*//g' | sed 's/Macmini/MM/g' | sed 's/MacBookPro/MBP/g' | sed 's/MacBookAir/MBA/g' | sed 's/MacBook/MB/g'`
/bin/echo "The abbreviated computer identifier is $SYSTEM"

#	A simple function to adjust the case of the variable outputs.
makelower() {
echo $1$2 | tr '[:upper:]' '[:lower:]' | sed 's/ //g'
}

#	Create lower case versions of all names.
L_NAME=`makelower $CURRENTUSER` 
L_COMPANY=`makelower $COMPANY`
L_SYSTEM=`makelower $SYSTEM`

/usr/sbin/scutil --set ComputerName "$CURRENTUSER $SYSTEM $COMPANY"
/usr/sbin/scutil --set LocalHostName $L_NAME-$L_SYSTEM-$L_COMPANY
/usr/sbin/scutil --set HostName $L_NAME-$L_SYSTEM-$L_COMPANY.local

#	Tell me the results.
STATUS=$?

if [ $STATUS == 0 ]; then
	echo "Computer identity was changed successfully."
	echo "$CURRENTUSER $SYSTEM $COMPANY"
	echo "$L_NAME-$L_SYSTEM-$L_COMPANY"
	echo "$L_NAME-$L_SYSTEM-$L_COMPANY.local"
elif [ $STATUS != 0 ]; then
	echo "An error was encountered while attempting to change the computer identity. /usr/sbin/scutil exited $status."
fi