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

#set +e

# Launch Composite Manager for transparency
if ! pgrep -x "compton" > /dev/null
then
    compton -b --config ~/.config/compton.conf
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

i3workspace.sh 21	& # Terminals
sleep 2
i3workspace.sh 22	& # Files
sleep 2
i3workspace.sh 23	& # Music
sleep 2

i3workspace.sh 11	& # Web
sleep 2
i3workspace.sh 12	& # Watch
sleep 2
i3workspace.sh 13	& # Git
sleep 2


i3workspace.sh 1	& # Explore
sleep 2
i3workspace.sh 2	& # Code
sleep 2
i3workspace.sh 3	& # Atom
sleep 2




i3-msg "workspace --no-auto-back-and-forth number 1"

# Launch Rofi
rofi -show run &

#set -e

########################################################################################################################
#	[-|\||) ()|= |_||\|[-
########################################################################################################################