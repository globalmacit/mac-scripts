#!/bin/bash

#	rename-computer.sh
#	version: 0.2
#	created: 06 Nov 2014
#	author:	Tobias Morrison
#
#	Sets Computer Name, Local Host Name, and Host Name 
#	on a standard OS X client system.


#	Provide the company abbreviated name.
COMPANY="WidgetCo"

### Let the robot do the work.
#	Grab some info from the system.
SYSTEM=`system_profiler SPHardwareDataType | grep "Model Identifier:" | awk '{print $3;}' | sed 's/[0-9][,]*//g' | sed 's/Macmini/MM/g' | sed 's/MacBookPro/MBP/g' | sed 's/MacBookAir/MBA/g' | sed 's/MacBook/MB/g'`


#	Get the currently logged in user name.
NAME=`finger `whoami` | awk -F: '{ print $3 }' | head -n1 | sed 's/^ //'`

#	A simple function to adjust the case of the variable outputs.
makelower() {
echo $1 | tr '[:upper:]' '[:lower:]' | sed 's/ //g'
}

L_NAME=`makelower $NAME` 
L_COMPANY=`makelower $COMPANY`
L_SYSTEM=`makelower $SYSTEM`

/usr/sbin/scutil --set ComputerName $NAME-$SYSTEM-$COMPANY
/usr/sbin/scutil --set LocalHostName $L_NAME-$L_SYSTEM-$L_COMPANY
/usr/sbin/scutil --set HostName $L_NAME-$L_SYSTEM-$L_COMPANY.local

#	Tell me the results.
status=$?

if [ $status == 0 ]; then
	echo "Computer identity was changed successfully."
elif [ $status != 0 ]; then
	echo "An error was encountered while attempting to change the computer identity. /usr/sbin/scutil exited $status."
fi