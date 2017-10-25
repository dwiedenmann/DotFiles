#!/bin/bash
########################################################################################################################
#	setxkbmap - set the keyboard using the X Keyboard Extension
#
#		The setxkbmap command maps the keyboard to use the layout determined 
#		by the options specified on the command line.
#
#		An XKB keymap is constructed from a number of components which are 
# 		compiled only as needed.  The source  for  all of the components can 
# 		be found in /usr/share/X11/xkb.
#
#
########################################################################################################################


# Set numeric keypad behavour so that shift <numeric key> works the same
# as shift <cursor key> when numlock is off.
setxkbmap -layout us -option numpad:microsoft

# set caps lock by hitting both shift keys.
#setxkbmap -option shift:both_capslock_cancel

# or this one
#setxkbmap -option shift:both_shiftlock
########################################################################################################################
#	[-|\||) ()|= |_||\|[-
########################################################################################################################
