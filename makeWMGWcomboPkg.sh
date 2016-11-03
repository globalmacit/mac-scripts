#!/bin/bash

### This script will take a Watchman Client Group name, create a no-payload pkg Watchman installer,
### then make a meta pkg with both the Watchman installer and the Gruntwork installer

# EDIT THESE!!!!!
wmServer="CHANGE THIS" #This is the subdomain for your watchman server. Eg. if your watchman server is acme.monitoringclient.com, enter "acme"
gwInstaller="CHANGE THIS" #This is the path to where you keep the GW installer on your machine, eg. /Users/user/Desktop/GruntworkInstaller.pkg

wmClient="CHANGE THIS" #the WM client group name
outputPath="/tmp/comboGwWmInstaller-$wmClient.pkg" #full output path for the finished pkg

## Sanity checks
## Make sure script is run by root
if [[ $EUID -ne 0 ]]; then
    echo "Script must be run as root" 1>&2
    exit 1
fi
# Check that all variables contain data
if [ -z "$wmClient" ]; then
	echo "Need to specify the Watchman Client Group name exactly as it appears in Watchman as the first argument."
	exit 2
fi
if [ -z "$wmServer" ] || [ -z "$gwInstaller" ]; then
	echo "Please edit this script's first 2 variables with the location of your Gruntwork installer and Watchman server name."
	exit 3
fi


### All the things!

## Create the Watchman pkg
# Write out the postinstall script
mkdir /tmp/pkgScripts 2>/dev/null
echo '#!/bin/bash' > /tmp/pkgScripts/postinstall
echo "/usr/bin/defaults write /Library/MonitoringClient/ClientSettings ClientGroup -string \"$wmClient\"" >> /tmp/pkgScripts/postinstall
echo "/usr/bin/curl -L1 https://$wmServer.monitoringclient.com/downloads/MonitoringClient.pkg > /tmp/MonitoringClient.pkg" >> /tmp/pkgScripts/postinstall
echo "/usr/sbin/installer -pkg /tmp/MonitoringClient.pkg -target /"  >> /tmp/pkgScripts/postinstall
chmod a+x /tmp/pkgScripts/postinstall

# Build the pkg
pkgbuild --identifier com.globalmacit.wmInstall --nopayload --scripts /tmp/pkgScripts "/tmp/1wmInstall.pkg"
if [ $? -ne 0 ]; then
	echo "Problem building the WM package."
	exit 4
fi

## Create the metapkg
productbuild --package "/tmp/1wmInstall.pkg" --package "$gwInstaller" "$outputPath"
if [ $? -ne 0 ]; then
	echo "Problem building the metapkg package."
	exit 5
else
	echo "Success! Your combo installer pkg is done: $outputPath"
	# Show me the money
	/usr/bin/open "/tmp"
	# Tidy up
	/bin/rm /tmp/1wmInstall.pkg
	/bin/rm -rf /tmp/pkgScripts
fi

exit 0