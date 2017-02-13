#!/bin/bash
########################################################################################################################
# 	Load Policy Kit
#
#		lxpolkit  is  a  PolicyKit agent which interacts with PolicyKit 
#		daemon to provide extended privileges to applications.
#
########################################################################################################################

# name of the program to run
launch="lxpolkit"

# Exit if program is already running
if [ $( pgrep $launch | wc -l ) -ne 0 ] ; then
	return 1
fi

# check to see if lxpolkit is in the path
if [ $(which $launch) ]; then
   $launch&
fi

########################################################################################################################
#	[-|\||) ()|= |_||\|[-
########################################################################################################################
