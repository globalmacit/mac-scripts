#!/bin/bash


#	remote-management.sh
#	version: 0.1
#	created: 07 Nov 2014
#	author:  Tobias Morrison 
#
#	Enables ARD, grants access and all privileges to the user 'gadmin'
#	Restarts the ARD agent and the ARD menu extra
#	Turns on ssh


#	Turn on ARD and restrict to 'gadmin' 
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -users gadmin -privs -all -restart -agent

#	Turn on remote login
/usr/sbin/systemsetup -f -setremotelogin on