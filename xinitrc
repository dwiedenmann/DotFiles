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
# Load XResources
########################################################################################################################
# Declare XResources
# declare -a resourcesArray=(
# 	"/etc/X11/xinit/Xresources"	# System Resources
# 	"$HOME/.Xresources"			# User   Resources
# 	)

# # Load Xresources
# for resource in ${resourcesArray[@]} ; do
# 	if [ -f "$resource" ]; then
# 	    xrdb -merge "$resource"
# 	fi
# done

########################################################################################################################
# Load ModMaps
########################################################################################################################
# Declare ModMaps
# declare -a resourcesArray=(
# 	"/etc/X11/xinit/Xmodmap"	# System Modmap
# 	"$HOME/etc/X11/modmap"		# User 	 Modmap
# 	)

# # Load ModMaps
# for resource in ${resourcesArray[@]} ; do
# 	if [ -f "$resource" ]; then
# 	    xmodmap "$resource"
# 	fi
# done

########################################################################################################################
# start some nice programs
########################################################################################################################
# Declare folders to search for scripts
# declare -a resourcesArray=(
# #	"/etc/X11/xinitrc.d"		# System Resources
# 	"$HOME/etc/X11/xinitrc.d"	# User   Resources
# 	)
# # Load Execute
# for resource in ${resourcesArray[@]} ; do
# 	if [ -d ~/etc/X11/xinitrc.d ] ; then
# 		for f in ~/etc/X11/xinitrc.d/* ; do
# 			[ -x "$f" ] && ("$f" &)
# 		done
# 		unset f
# 	fi
# done

########################################################################################################################
# Custom launch of X11
########################################################################################################################

# Here Xfce is kept as default
# session=${1:-xfce}

# case $session in
#     awesome           ) exec awesome;;
#     bspwm             ) exec bspwm;;
#     catwm             ) exec catwm;;
#     cinnamon          ) exec cinnamon-session;;
#     dwm               ) exec dwm;;
#     enlightenment     ) exec enlightenment_start;;
#     ede               ) exec startede;;
#     fluxbox           ) exec startfluxbox;;
#     gnome             ) exec gnome-session;;
#     gnome-classic     ) exec gnome-session --session=gnome-classic;;
#     i3|i3wm           ) exec i3;;
#     icewm             ) exec icewm-session;;
#     jwm               ) exec jwm;;
#     kde               ) exec startkde;;
#     mate              ) exec mate-session;;
#     monster|monsterwm ) exec monsterwm;;
#     notion            ) exec notion;;
#     openbox           ) exec openbox-session;;
#     unity             ) exec unity;;
#     xfce|xfce4        ) exec startxfce4;;
#     xmonad            ) exec xmonad;;
#     # No known session, try to run it as command
#     *) exec $1;;
# esac


########################################################################################################################
#	[-|\||) ()|= |_||\|[-
########################################################################################################################