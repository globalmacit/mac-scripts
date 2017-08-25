#!/bin/sh

# use kickstart to enable full Remote Desktop access
# for more info, see: http://support.apple.com/kb/HT2370

kickstart="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart"

#enable ARD access
$kickstart -configure -access -on -users gadmin -privs -all

$kickstart -configure -allowAccessFor -specifiedUsers

$kickstart -activate

exit 0