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

 




  
##  # Colors
##  CLR_RED="110 23 8"
##  CLR_GREEN="27 119 55"
##  CLR_YELLOW="67 109 7"
##  CLR_BLUE="7 59 74"
##  CLR_CYAN="45 103 120"
##  CLR_WHITE="255 255 255"
##  CLR_BLACK="0 0 0"
##  
##  # Exit
##  EXIT_OK="$CLR_GREEN"
##  EXIT_ERROR="$CLR_RED"
##  # User
##  USERNAME="$CLR_CYAN"
##  # Path
##  PATH_COLOR="$CLR_BLACK"
##  # Prompt
##  PROMPT_COLOR="$CLR_YELLOW"
##  # Text
##  TEXT_COLOR="$CLR_WHITE"
##  
##  get_exit_code(){
##      RV=$?
##      echo -en "$RV"
##      return $RV
##  }
##  
##  get_exit_code_color(){
##      RV=$?
##      if (( $RV == 0 )); then
##          echo -en `to_rgb $EXIT_OK 1`
##      else
##          echo -en `to_rgb $EXIT_ERROR 1`
##      fi
##      return $RV
##  }
##  
##  get_exit_code_color_2(){
##      RV=$?
##      if (( $RV == 0 )); then
##          echo -en `to_rgb $EXIT_OK 0` # Green
##      else
##          echo -en `to_rgb $EXIT_ERROR 0` # Red
##      fi
##      echo -en `to_rgb $USERNAME 1` # Cyan bg
##      return $RV
##  }
##  
##  to_rgb() {
##      if (( $4 == 0 )); then
##          printf "\x1b[38;2;$1;$2;${3}m\n"
##      else
##          printf "\x1b[48;2;$1;$2;${3}m\n"
##      fi
##  }
##  
##  RESET_COLORS="\e[00m"a
##  SEPARATOR="\342\226\210\356\202\260"
##  
##  # Exit code
##  # Username
##  # Path
##  # Prompt
##  PS1="\
##  \[\$(get_exit_code_color)\] \$(get_exit_code)\[\$(get_exit_code_color_2)\]\[$SEPARATOR\]\
##  \[\$(to_rgb $TEXT_COLOR 0)\$(to_rgb $USERNAME 1)\] \u\[\$(to_rgb $USERNAME 0)\$(to_rgb $PATH_COLOR 1)\]\[$SEPARATOR\]\
##  \[\$(to_rgb $TEXT_COLOR 0)\$(to_rgb $PATH_COLOR 1)\] \w\[$RESET_COLORS\]\[\$(to_rgb $PATH_COLOR 0)\]\[$SEPARATOR\]
##  \[\$(to_rgb $TEXT_COLOR 0)\$(to_rgb $PROMPT_COLOR 1)\] \$\[$RESET_COLORS\$(to_rgb $PROMPT_COLOR 0)\]${SEPARATOR}\[$RESET_COLORS\] "
##  
##export PS1

#export PS1="\u@\h:\w\\$\[$(tput sgr0)\]"


#######################################################################################################################
#	[-|\||) ()|= |_||\|[-
#######################################################################################################################