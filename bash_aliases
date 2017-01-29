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

#######################################################################################################################
# Aliases
#######################################################################################################################

# some more ls aliases
 alias install='sudo apt-get install'
 alias update='sudo apt-get update'
 alias upgrade='sudo apt-get -u upgrade'
 alias agi='sudo apt-get install'
 alias agu='sudo apt-get update'
 alias agg='sudo apt-get -u upgrade'
 
# personal aliases
alias ls='ls -hF --color'   # add colors for filetype recognition
alias lx='ls -lXB'        	# sort by extension
alias lk='ls -lSr'        	# sort by size
alias la='ls -Al'        	# show hidden files
alias lr='ls -lR'        	# recursive ls
alias lt='ls -ltr'        	# sort by date
# alias ll='ls -l'
# alias la='ls -A'
# alias l='ls -CF'

#alias find='find . | grep -i'

# alias lm='ls -al |more'        # pipe through 'more'
# alias ll='ls -l'        # long listing
# alias lsize='ls --sort=size -lhr' # list by size
# alias lsd='ls -l | grep "^d"'   #list only directories
# alias lalf='ls -alF'
# alias acyl='cd ~/.icons/ACYL_Icon_Theme_0.9.3/ && bash AnyColorYouLike'
alias reboot='sudo shutdown -r now'
alias shutdown='sudo shutdown -h now'
 
alias findlink="find -type l -ls | sed 's/^.*[0-9][0-9] [.]\(\/[.].*\) \(->\|<-\) \(.*\)$/~\"\1\" \2 \"\3\"/'"
alias yaourt="yaourt --sort w"
# # Command substitution
alias h='history | grep $1'
alias rm='rm -i'
alias cp='cp -v -i'
alias mv='mv -i'
alias which='type -all'
alias ..='cd ..'
alias pacman='sudo pacman'
alias neofetch2='neofetch \
--block_range 		0 15 \
--block_height 		2 \
--block_width 		5 \
--colors            2 5 7 4 3 15 \
'
alias figtime="watch -n1 \"date '+%D%n%T'|figlet -k -f $1\""

#--uptime_shorthand 	on \
#--gtk_shorthand 	on \