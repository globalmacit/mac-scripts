#!/bin/bash

/usr/local/munki/makepkginfo --name=EnableARD \
    --displayname="Enable Apple Remote Desktop" \
    --pkgvers=1.0 \
    --description="Configures access to ARD for GlobalMac IT access." \
    --category=Management \
    --developer="Tobias Morrison" \
    --notes="Removes all accounts from ARD access except gadmin." \
    --nopkg \
    --installcheck_script=ard_installcheck.sh \
    --postinstall_script=ard_postinstall.sh \
    --unattended-install > EnableARD.plist