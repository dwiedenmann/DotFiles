#!/bin/bash
# UNIX is basically a simple operating system, but you have to be a genius to understand the simplicity. -Dennis Ritchie
#######################################################################################################################
#       __               __                                        __ 
#      / /_  ____ ______/ /_     ____  _________  ____ ___  ____  / /_
#     / __ \/ __ `/ ___/ __ \   / __ \/ ___/ __ \/ __ `__ \/ __ \/ __/
#    / /_/ / /_/ (__  ) / / /  / /_/ / /  / /_/ / / / / / / /_/ / /_  
#   /_.___/\__,_/____/_/ /_/  / .___/_/   \____/_/ /_/ /_/ .___/\__/  
#                            /_/                        /_/         
#                            
#######################################################################################################################
#
# Prompt
#
#######################################################################################################################

 
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Powerline
if [ -f `which powerline-daemon` ]; then

	powerline-daemon -q
	POWERLINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
	if [ -f /usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh ]; then
	    source /usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
	fi

fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes


 
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	    # We have color support; assume it's compliant with Ecma-48
	    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	    # a case would tend to support setf rather than setaf.)
	    color_prompt=yes
    else
	    color_prompt=
    fi
fi
 

#separator=''

 #######################################################################################################################
#	[-|\||) ()|= |_||\|[-
#######################################################################################################################