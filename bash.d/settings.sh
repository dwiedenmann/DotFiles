#!/bin/bash
# UNIX is basically a simple operating system, but you have to be a genius to understand the simplicity. -Dennis Ritchie
#######################################################################################################################
#       __               __                 __  __  _                 
#      / /_  ____ ______/ /_     ________  / /_/ /_(_)___  ____ ______
#     / __ \/ __ `/ ___/ __ \   / ___/ _ \/ __/ __/ / __ \/ __ `/ ___/
#    / /_/ / /_/ (__  ) / / /  (__  )  __/ /_/ /_/ / / / / /_/ (__  ) 
#   /_.___/\__,_/____/_/ /_/  /____/\___/\__/\__/_/_/ /_/\__, /____/  
#                                                       /____/   
#   
#######################################################################################################################
########################################
# Export Settings
########################################
export TIME_STYLE=long-iso	#ls --time-style=+"%Y-%m-%d %H:%M"
export EDITOR=subl3
export HISTSIZE=10000
export HISTFILESIZE=20000
#export SAVEHIST0=100000

# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups  

# Pager
#export PAGER=most


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# append to the history file, don't overwrite it
shopt -s histappend


#######################################################################################################################
#	[-|\||) ()|= |_||\|[-
#######################################################################################################################