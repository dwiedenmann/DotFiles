#!/bin/bash
########################################################################################################################
#	compton - a compositor for X11
#
#		compton is a compositor based on Dana Jansens' version of xcompmgr 
#		(which itself was written by Keith Packard).  It includes some 
#		improvements over the original xcompmgr, like window frame opacity 
#  		and inactive window transparency.
#
########################################################################################################################

# Exit if program is already running
#
if [ $( pgrep compton | wc -l ) -ne 0 ] ; then
	return 1
fi

# Declare Multiple possible config files
declare -a resourcesArray=(
	$( readlink -e ../../compton.conf)	# Relative Path
	"$HOME/.config/X11/compton.conf"	# Home Path
	"$XDG_CONFIG_HOME/X11/compton.conf"	# XDG_CONFIG Path
	)

# Load Xresources
for resource in ${resourcesArray[@]} ; do
	if [ -f "$resource" ]; then
		echo $resource
		compton -b --config $resource
	    break
	fi
done


########################################################################################################################
#	[-|\||) ()|= |_||\|[-
########################################################################################################################