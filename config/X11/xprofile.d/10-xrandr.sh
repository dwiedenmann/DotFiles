#!/bin/bash
########################################################################################################################
#	xrandr - primitive command line interface to RandR extension
#
#		Xrandr  is  used  to set the size, orientation and/or reflection 
#		of the outputs for a screen. It can also set the screen size.
#
########################################################################################################################

xrandr --output DP-0   --primary            # Make this primary
xrandr --output HDMI-0 --left-of DP-0       # Left Monitor
xrandr --output HDMI-1 --right-of DP-0      # Right Monitor
xrandr --output HDMI-1 --rotate left        # Rotate into Portrait Mode

########################################################################################################################
#	[-|\||) ()|= |_||\|[-
########################################################################################################################