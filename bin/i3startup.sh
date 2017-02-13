#!/bin/bash
########################################################################################################################
# 	Set wallpaper
#
# 		could use nitrogen instead
#		Abstract this away to Xsession.avail ?
#
########################################################################################################################


# Execute main terminal in $ws_terminal
#exec --no-startup-id i3-msg 'workspace $ws_terminal; exec $terminal'

# Launch Composite Manager for transparency
compton -b --config ~/.config/compton.conf


# Network Manager Applet
nm-applet

# Dunst Notification Daemon
#dunst -conf "/home/david/.config/dunstrc"

# Conky
#conky main -c "/home/david/.config/i3/conky"

# Applications

#$execnsi clipit

#$execnsi xscreensaver -no-splash

# Set background
#exec --no-startup-id nitrogen --restore

# Launch Rofi
rofi -show run &

########################################################################################################################
#	[-|\||) ()|= |_||\|[-
########################################################################################################################