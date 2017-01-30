#!/bin/bash
########################################################################################################################
#	xrandr - primitive command line interface to RandR extension
#
#		Xrandr  is  used  to set the size, orientation and/or reflection 
#		of the outputs for a screen. It can also set the screen size.
#
########################################################################################################################

# Seiki 40 Inch
# Make this primary

# Hanns G 32  Inch
# Left Monitor
# Shift the screen down a bit so mouse is more natural transitioning

# Dell 24 Inch
# Right Monitor
# Rotate into Portrait Mode

xrandr --output DP-0   --primary            # Make this primary
xrandr --output HDMI-0 --left-of DP-0       # Left Monitor
xrandr --output HDMI-0 --pos 0x500       	# Shift the screen down a bit so mouse is more natural transitioning
xrandr --output HDMI-1 --right-of DP-0      # Right Monitor
xrandr --output HDMI-1 --rotate left        # Rotate into Portrait Mode

# xrandr 	--output DP-0   --primary \
# 		--output HDMI-0 --left-of DP-0 \
# 		--output HDMI-0 --pos 0x500 \
# 		--output HDMI-1 --right-of DP-0 --rotate left


########################################################################################################################
#	[-|\||) ()|= |_||\|[-
########################################################################################################################