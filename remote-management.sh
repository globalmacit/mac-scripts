#!/bin/bash


#	remote-management.sh
#	version: 0.1
#	created: 07 Nov 2014
#	author:  Tobias Morrison 
#	credit: http://support.apple.com/en-us/ht2370
#
#	Enables ARD, grants access and all privileges to the user 'gadmin'
#	Restarts the ARD agent and the ARD menu extra
#	Turns on ssh

# Set your user
User="gadmin"

#	Turn on ARD and restrict to the above user 
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -users $User -privs -all -restart -agent

#	Turn on remote login
/usr/sbin/systemsetup -f -setremotelogin on