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

set +e

#echo "Launching Compton" >> $HOME/i3.log
# Launch Composite Manager for transparency
if ! pgrep -x "compton" > /dev/null
then
    compton -b --config ~/.config/compton.conf
fi

if ! pgrep -x "plank" > /dev/null
then
    plank&
fi

# Network Manager Applet
nm-applet&

# Dunst Notification Daemon
#dunst -conf "/home/david/.config/dunstrc"

# Conky
#conky main -c "/home/david/.config/i3/conky"

# Applications

#$execnsi clipit

#$execnsi xscreensaver -no-splash

# Set background
#exec --no-startup-id nitrogen --restore


# Launch Default Workspaces

$HOME/bin/i3workspace.py --auto 	# Launch Automatic Workspaces


echo "Done" >> $HOME/i3.log

# i3-msg "workspace --no-auto-back-and-forth number 1"

# Launch Rofi
# rofi -show run &

#set -e

########################################################################################################################
#	[-|\||) ()|= |_||\|[-
########################################################################################################################