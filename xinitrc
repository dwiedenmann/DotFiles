#!/bin/sh
# UNIX is basically a simple operating system, but you have to be a genius to understand the simplicity. -Dennis Ritchie
########################################################################################################################
#              _       _ __                                _____      
#        _  __(_)___  (_) /___________   _________  ____  / __(_)___ _
#       | |/_/ / __ \/ / __/ ___/ ___/  / ___/ __ \/ __ \/ /_/ / __ `/
#    _ _>  </ / / / / / /_/ /  / /__   / /__/ /_/ / / / / __/ / /_/ / 
#   (_)_/|_/_/_/ /_/_/\__/_/   \___/   \___/\____/_/ /_/_/ /_/\__, /  
#                                                            /____/   
#
########################################################################################################################
#
#   X.Org initialisation program
#    
#		The ~/.xinitrc file is a shell script read by xinit and by its front-end startx. It is
#		mainly used to execute desktop environments, window managers and other programs when
#		starting the X server (e.g., starting daemons and setting environment variables). The
#		xinit program starts the X Window System server and works as first client program on
#		systems that are not using a display manager.
#
#   Please see http://i3wm.org/docs/userguide.html for a complete reference!#
#
#   (¯`·._.·(¯`·._.·  Configuration by David Wiedenmann ·._.·´¯)·._.·´¯)
#
########################################################################################################################
#
#   References
#
#   Arch wiki 					https://wiki.archlinux.org/index.php/Xinit
#  		* Installation 			https://wiki.archlinux.org/index.php/Xinit#Installation
# 		* Tips and tricks 		https://wiki.archlinux.org/index.php/Xinit#Tips_and_tricks
#
#   Example Dotfiles
#
########################################################################################################################

########################################################################################################################
# Declare Resources
########################################################################################################################

#userresources=$HOME/etc/X11/xresources
userresources=~/.Xresources
#usermodmap=$HOME/etc/X11/modmap

sysresources=/etc/X11/xinit/Xresources
#sysmodmap=/etc/X11/xinit/Xmodmap

composite=$XDG_CONFIG_HOME/X11/compton.conf
colortheme=$XDG_CONFIG_HOME/X11/colortheme

########################################################################################################################
# Merge/Load Resources
########################################################################################################################
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

#if [ -f $sysmodmap ]; then
#    xmodmap $sysmodmap
#fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$colortheme" ]; then
    xrdb -merge "$colortheme"
fi

#if [ -f "$usermodmap" ]; then
#	xmodmap "$usermodmap"
#fi

if [ -f "$composite" ]; then
	compton -b --config "$composite"
fi



########################################################################################################################
# start some nice programs
########################################################################################################################
if [ -d ~/etc/X11/xinitrc.d ] ; then
	for f in ~/etc/X11/xinitrc.d/* ; do
		[ -x "$f" ] && ("$f" &)
	done
	unset f
fi

# Set wallpaper

feh --randomize --bg-fill ~/.wallpapers/*	# Load wallpaper
lxpolkit&									# Load Policy Kit

########################################################################################################################
#	[-|\||) ()|= |_||\|[-
########################################################################################################################