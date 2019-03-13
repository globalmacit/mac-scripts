#!/bin/bash

#	makeBCinstaller
#	version: 0.1
#	created: 26 Feb 2019
#	author: Tobias Morrison
#
#	Creates a signed combo Watchman and Gruntwork installer.

### user-modifiable variables ###
# Edit the client name to reflect the Watchman Group name.
wmClient="!! CLIENT NAME !!"

### local variables ###
# Location of Gruntwork installer.
gwInstaller="$HOME/bin/onboarding/GlobalMacIT Maintenance.pkg"
# unsigned package output path
outputPath="/tmp/unsignedInstaller-$wmClient.pkg"
# signed package output path
signedOutputPath="/tmp/ManagementInstaller-$wmClient.pkg"
# final zipped output path
zippedOutput="BC_Installer-$wmClient-mojo.zip"

### Where the Robots do the work. ###
## Make sure script is run by root
if [[ $EUID -ne 0 ]]; then
    echo "Script must be run as root" 1>&2
    exit 1
fi

# Write out the Watchman postinstall script
mkdir /tmp/pkgScripts 2>/dev/null
echo '#!/bin/bash' > /tmp/pkgScripts/postinstall
echo "/usr/bin/defaults write /Library/MonitoringClient/ClientSettings ClientGroup -string \"$wmClient\"" >> /tmp/pkgScripts/postinstall
echo "/usr/bin/curl -L1 https://globalmacit.monitoringclient.com/downloads/MonitoringClient.pkg > /tmp/MonitoringClient.pkg" >> /tmp/pkgScripts/postinstall
echo "/usr/sbin/installer -pkg /tmp/MonitoringClient.pkg -target /"  >> /tmp/pkgScripts/postinstall
chmod a+x /tmp/pkgScripts/postinstall

# Build the Watchman pkg
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
fi

# Sign the metapkg
productsign --sign "!! DEVELOPER INSTALLER ID !!" "$outputPath" "$signedOutputPath"
sleep 5 # productsign needs some time to run
cd /tmp # zip is dumb and only likes to work in the current directory
zip "$zippedOutput" "ManagementInstaller-$wmClient.pkg"
if [ $? -ne 0 ]; then
	echo "Problem signing the package."
	exit 6
else
	echo "Success! Your combo installer pkg is done: /tmp/$zippedOutput"
	# Show me the money
	open "/tmp"
	# Tidy up
	rm /tmp/1wmInstall.pkg
	rm -rf /tmp/pkgScripts
	rm "$outputPath"
fi