#!/bin/bash

#	Adobe Reader Plug-in Remover 
#	Version 0.1
#	Author: Tobias Morrison
#	Created: 09 Jul 2014

# Path to Internet Plug-ins
PLUGINS="/Library/Internet Plug-Ins"

# Remove the Plug-Ins
if [ -e "${PLUGINS}/AdobePDFViewer.plugin" ]; then
	/bin/rm -r "${PLUGINS}/AdobePDFViewer.plugin"
fi

if [ -e "${PLUGINS}/AdobePDFViewerNPAPI.plugin" ]; then
	/bin/rm -r "${PLUGINS}/AdobePDFViewerNPAPI.plugin"
fi

exit 0