#!/bin/bash

#  extract-prev-recpts.sh
#  version: 0.1
#  created: 27 May 2015
#  author: Tobias Morrison
#
#  Uses sqlite3 to query and extract Apple Mail Previous Recipients list
#  Exports to a CSV file
#  This solution is for Mavericks and Yosemite only as the database moved
#  from ~/Library/Application Support/AddressBook to 
#  /Library/Containers/com.apple.corerecents.recentsd/Data/Library/Recents/Recents
#
#  Special thanks to Rusty Myers at PSU for assistance in locating the new sqlitedb.


#  Define our local user
MYUSER="$(whoami)"

#  Give the file a logical name
FILE="$MYUSER-contacts.csv"

#  Current directory containing the script.
#  This allows us to run the script and save the
#  results to the removable media. 
#  Source: http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#  File output path
FILEOUTPUT="$DIR/$FILE"

# Okay, robots. Do your thing.
/usr/bin/sqlite3 "/Users/$MYUSER/Library/Containers/com.apple.corerecents.recentsd/Data/Library/Recents/Recents" <<!
.headers on
.mode csv
.output "$FILEOUTPUT"
select display_name, address from contacts where kind = "email";
!

sleep 2

echo ""$FILEOUTPUT" saved."
open "$DIR"

exit 0