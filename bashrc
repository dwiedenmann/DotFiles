#!/bin/bash
# UNIX is basically a simple operating system, but you have to be a genius to understand the simplicity. -Dennis Ritchie
#######################################################################################################################
#        __               __            __         ____
#       / /_  ____ ______/ /_     _____/ /_  ___  / / /
#      / __ \/ __ `/ ___/ __ \   / ___/ __ \/ _ \/ / / 
#     / /_/ / /_/ (__  ) / / /  (__  ) / / /  __/ / /  
#    /_.___/\__,_/____/_/ /_/  /____/_/ /_/\___/_/_/   
#                                                      
#######################################################################################################################
#
#	The GNU Bourne Again shell
#
#       Bash  is  an  sh-compatible  command language interpreter that executes commands read
#       from the standard input or from a file.  Bash also incorporates useful features from
#       the Korn and C shells (ksh and csh).
#
#       Bash is intended to be a conformant implementation of the Shell and Utilities portion
#       of the IEEE POSIX specifi‐ cation (IEEE Standard 1003.1).  Bash can be configured to
#       be POSIX-conformant by default.
#
#######################################################################################################################
# 	References
#
#	Arch Wiki					https://wiki.archlinux.org/index.php/bash
#		* Invocation			https://wiki.archlinux.org/index.php/bash#Invocation
#		* Command line 			https://wiki.archlinux.org/index.php/bash#Command_line
#		* Aliases 				https://wiki.archlinux.org/index.php/bash#Aliases
#		* Tips and tricks		https://wiki.archlinux.org/index.php/bash#Tips_and_tricks
#		* Troubleshooting		https://wiki.archlinux.org/index.php/bash#Troubleshooting
#
#   Example Dotfiles
# 		* Github / Vosh 		https://github.com/vosh/scripts
# 		* Github / Stark 		https://github.com/stark/Color-Scripts
#		* .bashrc Generator 	http://bashrcgenerator.com/
#		* CousinMachu 			https://github.com/CousinMachu/linux-dotfiles (Very Complete)
#		* Lambecomeroot			https://github.com/Iambecomeroot/dotfiles/tree/master/rofi-pass
#		* SuperCuber			https://github.com/SuperCuber/dotfiles
#
#######################################################################################################################

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
 
clear

# Execute all .sh files in ~/.bash.d
for i in $HOME/.bash.d/*.sh; do 
	#echo "Sourcing $i"
	source $i; 
done
unset i


#figlet -f slant "Hello World" | lolcat

drawPacmanGhosts;






#######################################################################################################################
#	[-|\||) ()|= |_||\|[-
#######################################################################################################################