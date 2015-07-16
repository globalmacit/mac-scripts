#!/bin/bash

# 	print-auth-for-std-users.sh
#	version: 0.1
#	created: 26 Aug 2014
#	author: Tobias Morrison
#
#	Give all standard users access to the Printing Preference Pane,
#	and allow pausing/resuming printers.
#
# 	For background on /var/db/auth.db, see Samuel Keeley's AFP548 writeup on the topic:
#	http://www.afp548.com/2013/10/22/modifying-the-os-x-mavericks-authorization-database/
#
# 	For information on more advanced modification of auth.db, see Rich Trouton's writeup here:
#	http://derflounder.wordpress.com/2014/02/16/managing-the-authorization-database-in-os-x-mavericks/
#
#	For an exhaustive list of available security commands, see this article:
#	http://www.dssw.co.uk/reference/authorization-rights/index.html



# Allow access to the Printing Preference Pane
security authorizationdb write system.preferences.printing allow

# Allow access to Printing Administrative tasks
security authorizationdb write system.print.admin allow 

# Allow access to pausing/resuming queues
security authorizationdb write system.print.operator allow 