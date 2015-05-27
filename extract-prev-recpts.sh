#!/bin/bash

#  extract-prev-recpts.sh
#  version: 0.1
#  created: 27 May 2015
#  author: Tobias Morrison
#
#  Uses sqlite3 to query and extract Apple Mail Previous Recipients list
#  Exports to a CSV file


#  Define our local user
USER="$(whoami)"

#  Give the file a logical name
FILE="$USER-contacts.csv"

#	Current directory containing the script.
#+	This allows us to run the script and save the
#+	results to the removable media. 
#+	Source: http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#  File output path
FILEOUTPUT="$DIR/$FILE"

# Okay, robots. Do your thing.
/usr/bin/sqlite3 /Users/"$USER"/Library/Application\ Support/AddressBook/MailRecents-v4.abcdmr <<!
.headers on
.mode csv
.output "$FILEOUTPUT"
select ZLASTNAME, ZFIRSTNAME, ZEMAIL from ZABCDMAILRECENT;
!

echo ""$FILEOUTPUT" saved."
open "$DIR"

sleep 2

exit 0