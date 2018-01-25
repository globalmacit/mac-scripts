#!/bin/sh

# Copied without modifications from 
# https://gist.github.com/sowderca/6b58b448ffedf38f12a3dbde5a2aa981
#
# Successfully tested without modifications 25 Jan 2018

me=`basename $0`

if [ $EUID -ne 0 ]; then
   echo "This script must be run as root." 1>&2
   echo "Execute from a command prompt:" 1>&2
   echo "sudo ./$me" 1>&2
   if [ "./$me" != "$0" ]; then
      echo "   or   " 1>&2
      echo "sudo $0" 1>&2
   fi
   echo 1>&2
   exit 1
fi

if launchctl list | grep com.labtechsoftware.LTSvc; then
    launchctl stop com.labtechsoftware.LTSvc &>nul
    launchctl remove com.labtechsoftware.LTSvc &>nul
	launchctl stop com.labtechsoftware.ltechagent &>nul
    launchctl remove com.labtechsoftware.ltechagent &>nul
    launchctl unload /Library/LaunchDaemons/com.labtechsoftware.LTSvc.plist &>nul
fi

if launchctl list | grep com.labtechsoftware.LTTray; then 
    launchctl stop com.labtechsoftware.LTTray &>nul
    launchctl remove com.labtechsoftware.LTTray &>nul
    launchctl unload /Library/LaunchAgents/com.labtechsoftware.LTTray.plist &>nul
	launchctl unload /Library/LaunchDaemons/com.labtechsoftware.LTTray.plist &>nul
fi

if launchctl list | grep com.labtechsoftware.LTUpdate; then 
    launchctl stop com.labtechsoftware.LTUpdate &>nul
    launchctl remove com.labtechsoftware.LTUpdate &>nul
    launchctl unload /Library/LaunchDaemons/com.labtechsoftware.LTUpdate.plist &>nul
fi

if launchctl list | grep com.labtechsoftware.LTSvc; then
    launchctl stop com.labtechsoftware.LTSvc &>nul
    launchctl remove com.labtechsoftware.LTSvc &>nul
    launchctl unload /Library/LaunchDaemons/com.labtechsoftware.LTSvc.plist &>nul
fi

rm -rf /usr/LTSvc/ &>nul
rm -rf /usr/local/ltechagent/ &>nul
rm -rf /Library/LaunchDaemons/com.labtechsoftware.LTSvc.plist &>nul
rm -rf /Library/LaunchAgents/com.labtechsoftware.LTTray.plist &>nul
rm -rf /Library/LaunchDaemons/com.labtechsoftware.LTTray.plist &>nul
rm -rf /Library/LaunchDaemons/com.labtechsoftware.LTUpdate.plist &>nul