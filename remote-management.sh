#!/bin/bash


#	remote-management.sh
#	version: 0.2
#	created: 07 Nov 2014
#	author:  Tobias Morrison 
#	credit: http://support.apple.com/en-us/ht2370
#
#	modified: 17 Feb 2015
#	made Remote Management restart its own command as it is more reliable on Yosemite.
#	removed restriction to a particular user to accommodate new remote tools.
#
#	Enables ARD, grants access and all privileges to all users
#	Restarts the ARD agent and the ARD menu extra
#	Turns on ssh


#	Turn on ARD and restrict to the above user 
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -activate -access -on -privs -all -allowAccessFor -allUsers

#	Restart Remote Management to accept the changes
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent

#	Turn on remote login
/usr/sbin/systemsetup -f -setremotelogin on