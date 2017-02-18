#!/bin/bash
# UNIX is basically a simple operating system, but you have to be a genius to understand the simplicity. -Dennis Ritchie
#######################################################################################################################
#       __               __                                  __     __     
#      / /_  ____ ______/ /_     _________  ____ ___  ____  / /__  / /____ 
#     / __ \/ __ `/ ___/ __ \   / ___/ __ \/ __ `__ \/ __ \/ / _ \/ __/ _ \
#    / /_/ / /_/ (__  ) / / /  / /__/ /_/ / / / / / / /_/ / /  __/ /_/  __/
#   /_.___/\__,_/____/_/ /_/   \___/\____/_/ /_/ /_/ .___/_/\___/\__/\___/ 
#                                                 /_/                     
#   
#######################################################################################################################
# these are readline modifications to tweak the tab completion
bind 'set completion-ignore-case on'
bind 'set completion-prefix-display-length 2'
bind 'set completion-map-case on'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
 
# load git completions
_completion_loader git

# assign git's completion function _git to gi
complete -o bashdefault -o default -o nospace -F _git gi 


#######################################################################################################################
#	[-|\||) ()|= |_||\|[-
#######################################################################################################################
