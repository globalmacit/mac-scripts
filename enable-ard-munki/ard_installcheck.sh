#!/bin/sh

# munki install_check script
# exit status of 0 means install needs to run
# exit status 1 means no installation necessary

# adapted scripts from  here: https://jamfnation.jamfsoftware.com/discussion.html?id=1989

# check if ARD is running

ardrunning=$(/bin/ps ax | /usr/bin/grep -c -i "[Aa]rdagent")

if [[ $ardrunning -eq 0 ]]; then
	echo "ARD not running"
	exit 0
fi

# check that gadmin account exists

gadmin_acct=$(/usr/bin/dscl . list /Users UniqueID | /usr/bin/awk '$2 > 498 { print $1 }' | /usr/bin/grep gadmin)

if [[ $gadmin_acct != *gadmin* ]]; then
	echo "gadmin does not exist"
	exit 1
fi

# All Users access should be off

all_users=$(/usr/bin/defaults read /Library/Preferences/com.apple.RemoteManagement ARD_AllLocalUsers 2>/dev/null)

if [[ $all_users -eq 1 ]]; then
	echo "All Users Access Enabled"
	exit 0
fi

# Check if gadmin account is privileged

ard_admins=$(/usr/bin/dscl . list /Users naprivs | cut -d ' ' -f 1)

if [[ $ard_admins != *gadmin* ]]; then
	echo "gadmin is not an ARD admin"
	exit 0
fi

echo "everything looks great"

exit 1