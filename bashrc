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

########################################
# Export Settings
########################################
export TIME_STYLE=long-iso	#ls --time-style=+"%Y-%m-%d %H:%M"
export EDITOR=subl3
# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
 
# Pager
#export PAGER=most

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# append to the history file, don't overwrite it
shopt -s histappend




########################################
# Alias definitions.
########################################
if [ -f ~/.bash_aliases ]; then
    #. ~/.bash_aliases
    source ~/.bash_aliases
fi
 
########################################
# Colors
########################################
if [ -f ~/.dir_colors ]; then
	eval `dircolors ~/.dir_colors`
fi


########################################
# Prompt
########################################

# Powerline
if [ -f `which powerline-daemon` ]; then


	powerline-daemon -q
	POWERLINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
	. /usr/share/powerline/bash/powerline.sh


fi

	if [ -f /usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh ]; then
	    source /usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
	fi

#separator=''
#PS1="$color_green_black\u$color_yellow_green$separator$color_yellow_black\h$color_red_yellow$separator$color_red_black\W$color_black_red$separator$color_reset"
#if [ "$color_prompt" = yes ]; then
#    PS1='\[\e[0;34m\]┌──[\[\e[0;32m\]\u\[\e[0;31m\]@\[\e[0;35m\]\h\[\e[0;34m\]]──\[\e[0;34m\][\[\e[0;32m\]\w\[\e[0;34m\]] \n└── \[\e[0;34m\]'
#else
#    PS1='┌────[\u@\h]────────────────────────────────────────[\t]────┐ \n└───>[${PWD}] \$ '
#fi
#unset color_prompt force_color_prompt

if [ "`id -u`" -eq 0 ]; then
    PS1="\[\033[m\]|\[\033[1;35m\]\t\[\033[m\]|\[\e[1;31m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\W]> \[\e[0m\]"
else
    PS1="\[\033[m\]|\[\033[1;35m\]\t\[\033[m\]|\[\e[1m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\W]> \[\e[0m\]"
fi


 
# If not running interactively, don't do anything
[ -z "$PS1" ] && return
 
# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
 
# set variable identifying the chroot you work in (used in the prompt below)
# if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
#     debian_chroot=$(cat /etc/debian_chroot)
# fi
 

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
 
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
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
 



 
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"       
    ;;
*)
    ;;
esac
 

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
 

#######################################################################################################################
# Functions
#######################################################################################################################
 
dotfiles="~/dotfiles/"

dot_add(){
#	echo "$0"
	cfgfile=$1
	dotfile=$2
	if [ -z $dotfile ]
		then dotfile=$cfgfile
		cfgfile=".$dotfile"
	fi 
	mv ~/$cfgfile ./$dotfile
	ln -s ./$dotfile ~/$cfgfile
}


anime(){
	# animeImgs=(
		# 	)
	# if [ -f "$1" ] ; then
	# 	animeImg=$1
	# else
	# 	animeImg=${animeImgs[$1]}
	# fi
	# "img2txt $animeImg $2 $3 $4 $5 $6 $7 $8"
	img2txt -W$COLUMNS ~/.wallpapers/cleavage_hoshizora_rin_koizumi_hanayo_love_live__murota_yuuhei_possible_duplicate_thighhighs_yazawa_nico_9691x5945.jpg
}

iotek(){
	# rice
	curl http://pub.iotek.org/p/fMMfclH
	# taco
	curl http://pub.iotek.org/p/YMtPOI1
	# burger
	curl http://pub.iotek.org/p/KbMmOhi
	# pizza
	curl http://pub.iotek.org/p/WSj6PIH
	# trollface
	curl http://pub.iotek.org/p/FnFhg19
	# bubble bobble
	curl http://pub.iotek.org/p/N5Hzxif
	# metroid
	curl http://pub.iotek.org/p/l8kH4ww
	# moogle
	curl http://pub.iotek.org/p/SD1zL1x
	# weapons
	curl http://pub.iotek.org/p/x3LtyfX
	# chest
	curl http://pub.iotek.org/p/b9AgMDx
}

wopr(){
	# https://github.com/yaronn/wopr
	curl tty.zone/1\?cols=$((COLUMNS))
}

wifi(){
	# setup interface/driver/configfile
	#interface=$("iw dev | grep -Po \"(?<=Interface ).*\"")	# get interface using grep
	if [ -z "$interface" ] ; then interface="wlp9s0" ; fi 		#
	driver="nl80211,wext"
	configFile="/etc/wpa_supplicant/wpa_supplicant.conf"
	if [ -f "$1" ] ; then configFile=$1 ; fi 	# use arg as config file
	sudo killall wpa_supplicant					# kill existing wpa_supplicant
	sudo wpa_supplicant -D "$driver" -i "$interface" -c "$configFile" -B
	sudo dhcpcd "$interface"
	"
	su
	wpa_supplicant -D "$driver" -i "$interface" -c "$configFile" -B
	"
}

killgrep(){
	ps -aux | grep $1 | grep -v grep | awk '{print "kill "$2}' | source /dev/stdin
}

wttr(){
	# https://github.com/chubin/wttr.in
	if [ -z "$1" ]; then city="Foster_City" ; else city="$1"; fi
	curl http://wttr.in/$city
}




# # Creates an archive from given directory
# mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
# mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
# mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }
 
### FUNCTIONS
 
# Easy extract
# uncompress depending on extension...
extract() {    
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2) tar xvjf 	"$1" ;;
      *.tar.gz)  tar xvzf 	"$1" ;;
      *.bz2)     bunzip2 	"$1" ;;
      *.rar)     unrar x 	"$1" ;;
      *.gz)      gunzip 	"$1" ;;
      *.tar)     tar xvf 	"$1" ;;
      *.tbz2)    tar xvjf 	"$1" ;;
      *.tgz)     tar xvzf 	"$1" ;;
      *.zip)     unzip 		"$1" ;;
      *.Z)       uncompress "$1" ;;
      *.7z)      7z x 		"$1" ;;
      *)
      echo "'$1' cannot be extracted"
      return 1
      ;;
    esac
  else
    echo "'$1' is not a valid file"
    return 1
  fi
  return 0
}
 
 
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
 

 #archey3
 neofetch

# ANSI Color -- use these variables to easily have different color
#    and format output. Make sure to output the reset sequence after 
#    colors (f = foreground, b = background), and use the 'off'
#    feature for anything you turn on.

initializeANSI() {
  esc=""

  # Foreground 				# Background
  blackf="${esc}[30m";   	blackb="${esc}[40m";
  redf="${esc}[31m";    	redb="${esc}[41m";
  greenf="${esc}[32m"		greenb="${esc}[42m";
  bluef="${esc}[34m";   	blueb="${esc}[44m";
  purplef="${esc}[35m"		purpleb="${esc}[45m"
  yellowf="${esc}[33m"   	yellowb="${esc}[43m";
  cyanf="${esc}[36m";    	cyanb="${esc}[46m";
  whitef="${esc}[37m"		whiteb="${esc}[47m"
  
  # Enable ASCII Feature 	# Disable ASCII Feature
  wrapon="${esc}[?7h";		wrapoff="${esc}[?7l";
  boldon="${esc}[1m";    	boldoff="${esc}[21m"
  dimon="${esc}[2m";    	boldoff="${esc}[22m"
  italicson="${esc}[3m"; 	italicsoff="${esc}[23m"
  ulon="${esc}[4m";      	uloff="${esc}[24m"
  blinkon="${esc}[5m"; 		blinkoff="${esc}[25m"
#  italicson="${esc}[6m"; 	italicsoff="${esc}[26m"
  invon="${esc}[7m";     	invoff="${esc}[27m"

  reset="${esc}[0m"
}

initializeANSI


#######################################################################################################################
# Pacman ASCII
#######################################################################################################################
drawPacmanGhosts(){
# Assign ghost color order
gColor=(3 7 1 2 4 5 6 0)
#gColor=(5 3 7 1 2 4 6 0)

# Make Ghost Eyes
# Initializing procedure by lolilolicon

f=3 b=4
for j in f b; do
#  for i in {0..7}; do
  for i in {0..7}; do
  	gCol=${gColor[i]}
  	#echo $gCol
    printf -v $j$i %b "\e[${!j}${gCol}m"
    #printf -v $j$i %b "\e[${!j}${i}m"
  done
done


# Define different Eye Shapes
eyel1="$f1█▀█";	eyer1="$f1█▀█";	eyed1="$f1███";	eyeu1="$f1█ █";
eyel2="$f1▄▄█";	eyer2="$f1█▄▄";	eyed2="$f1█ █";	eyeu2="$f1███";


# Assign eye shapes to ghosts
gEyesTop=("l" "l" "d" "d" "r" "r")
gEyesBot=("l" "l" "u" "u" "r" "r")

for gNum in {0..5};
do
	cNum="f$((gNum+2))"		# get the color number
	gCol=${!cNum}			# get the color value
	gEyes=${gEyesTop[gNum]}	# get the Direction
	eval "declare gstr1$cNum=\$\"\$eye${gEyes}1\$$cNum██\$eye${gEyes}1""\$$cNum\" "
	eval "declare gstr2$cNum=\$\"\$eye${gEyes}2\$$cNum██\$eye${gEyes}2""\$$cNum\" "
	gEyes=${gEyesBot[gNum]}	# get the Direction
	eval "declare gstr3$cNum=\$\"\$eye${gEyes}1\$$cNum██\$eye${gEyes}1""\$$cNum\" "
	eval "declare gstr4$cNum=\$\"\$eye${gEyes}2\$$cNum██\$eye${gEyes}2""\$$cNum\" "
done



# BASH Builtins
# : [arguments]			Do nothing beyond expanding arguments and performing redirections. The return status is zero.
# . filename [args] 	Read and execute commands from filename 
# eval [arguments]		Concatenate arguments
# [						evaluate a conditional expression and return 0(true) or 1(false)
# ( expr )				Return the value of expr

# Expansion
#  {aa,bb,cc,dd}  => aa bb cc dd
#  {0..12}        => 0 1 2 3 4 5 6 7 8 9 10 11 12
#  {3..-2}        => 3 2 1 0 -1 -2
#  {a..g}         => a b c d e f g
#  {g..a}         => g f e d c b a

# Added to .config/X11/xprofile.d/25-export-xresources-to-env
# Need a way to call this both on X startup and Bash login
# Export Xresources colors to variables
 
eval "$( xrdb -query \
		| grep -E '^\*[.]*(\w)+:\s*(.*)$' \
		| sed   's/^\*[.]*\([[:alnum:]]*\):\s*\(.*\)$/export \1=\2/' \
		)"
 

# Do the same, except add 75% transparency
eval "$( xrdb -query \
		| grep -E '^\*[.]*(\w)+:\s*#(.*)$' \
		| sed   's/^\*[.]*\([[:alnum:]]*\):\s*#\(.*\)$/export \1_alpha=#C0\2/' \
		)"

# colors=( $( xrdb -query | grep -E '^\*[.]*color[0-9]+' | sed 's/^.*color\([0-9]*\).*:\s*\(.*\)$/\2/' ) )
# echo -e "\e[1;37m 
#  Black    Red      Green    Yellow   Blue     Magenta   Cyan    White   
# ──────────────────────────────────────────────────────────────────────\e[0m"
# for i in {0..7}; do echo -en "\e[$((30+$i))m ${colors[i]} \e[0m"; done
# echo
# for i in {8..15}; do echo -en "\e[1;$((22+$i))m ${colors[i]} \e[0m"; done
# echo -e "\n"


# Get the Hexademinal Colors
#colorHex=( $( sed -re '/^!/d; /^$/d; /^#/d; s/(\*[.]color)([0-9]):/\10\2:/g;' $xdef | grep 'color[01][0-9]:' | sort | sed  's/^.*: *//g' ) )


colorNames=("BLACK" "RED" "GREEN" "YELLOW" "BLUE" "MAGENTA" "CYAN" "WHITE")
# Create a function to draw the colors
displayColors() { 
	for i in {0..7}; do 				# step through the colors in the order we want them displayed
		colorNum=${gColor[$i]}				# map the color to get what we display by column
		bgColorNum=$((colorNum+$1*8))
		fgColor="f$i"							# color variable name
		fgColor=${!fgColor} 					# color value		

		#eval "bgColor=$((${1}*60+$i+40))m"		# set Background Color
		if [ "$1" -eq "1" ]; then
			fgColor="$boldon$fgColor"

		fi
		if [ "$2" -eq "1" ]; then
			displayText=${colorNames[$colorNum]}		# Display Color Name
			#fgColor="$boldon$f0"
		else
			displayText="color${bgColorNum}"	# Display Color Hex Code
			displayText=${!displayText^^}		# Display Color Hex Code
			fgColor="$invon$fgColor"
		fi
		displayColor=$fgColor

		# 4+3+7
		printf "$wrapoff%s    %-7s   $wrapon" $displayColor $displayText; 
	done; 
}

printf "%s\n" "$(displayColors 0 1)" 
printf "%s\n" "$(displayColors 0 0)"
printf "%s\n" "$(displayColors 1 0)"
printf "\n\n"

colpath="$HOME/bin/colors/"
ghost="$colpath/ghost.txt"
pacman="$colpath/pacman.txt"
dots="$colpath/dots.txt"
del="-d' '"
si="/dev/stdin"
echo $reset$wrapoff
# paste $pacman $dots -d ""\
# 	| paste $s1 $ghost \
# 	| paste $s1 $ghost \
# 	| paste /dev/stdin $ghost \
# 	| paste /dev/stdin $ghost \
# 	| paste /dev/stdin $ghost \
# 	| paste /dev/stdin $ghost

# paste	<<< paste $pacman \
# 		<<< paste $dots -d" " \
# 	  	<<< paste $ghost \
# 	  	<<< paste $ghost -d" " \
# 	  	<<< paste $ghost \
# 	  	<<< paste $ghost -d" " \
# 	  	<<< paste $ghost -d" " | ( "awk ""'"'{print "\033[1;31m" $0}'"'" ) \
# 	  	<<< "awk ""'"'{print "\033[1;31m" $0}'"'" <<< paste $ghost -d" "


#cat $ghost | awk '{print "\033[1;31m" $0}'
#cat $ghost | awk '{print "\033[1;31m" $0}'

echo $reset$wrapon
cat << EOF
$reset$wrapoff
$f0   ▄███████▄   $f1              $f2  ▄██████▄    $f3  ▄██████▄    $f4  ▄██████▄    $f5  ▄██████▄    $f6  ▄██████▄    $f7  ▄██████▄  
$f0 ▄█████████▀▀  $f1              $f2▄$gstr1f2██▄  $f3▄█$gstr1f3█▄  $f4▄█$gstr1f4█▄  $f5▄█$gstr1f5█▄  $f6▄██$gstr1f6▄  $f7▄██$gstr1f7▄
$f0 ███████▀      $f1 ▄▄  ▄▄  ▄▄   $f2█$gstr2f2███  $f3██$gstr2f3██  $f4██$gstr2f4██  $f5██$gstr2f5██  $f6███$gstr2f6█  $f7███$gstr2f7█
$f0 ███████▄      $f1 ▀▀  ▀▀  ▀▀   $f2████████████  $f3████████████  $f4████████████  $f5████████████  $f6████████████  $f7████████████
$f0 ▀█████████▄▄  $f1              $f2██▀██▀▀██▀██  $f3██▀██▀▀██▀██  $f4██▀██▀▀██▀██  $f5██▀██▀▀██▀██  $f6██▀██▀▀██▀██  $f7██▀██▀▀██▀██
$f0   ▀███████▀   $f1              $f2▀   ▀  ▀   ▀  $f3▀   ▀  ▀   ▀  $f4▀   ▀  ▀   ▀  $f5▀   ▀  ▀   ▀  $f6▀   ▀  ▀   ▀  $f7▀   ▀  ▀   ▀
$boldon
$f0   ▄███████▄   $f1              $f2  ▄██████▄    $f3  ▄██████▄    $f4  ▄██████▄    $f5  ▄██████▄    $f6  ▄██████▄    $f7  ▄██████▄  
$f0 ▄█████████▀▀  $f1              $f2▄$gstr3f2██▄  $f3▄█$gstr3f3█▄  $f4▄█$gstr3f4█▄  $f5▄█$gstr3f5█▄  $f6▄██$gstr3f6▄  $f7▄██$gstr3f7▄
$f0 ███████▀      $f1 ▄▄  ▄▄  ▄▄   $f2█$gstr4f2███  $f3██$gstr4f3██  $f4██$gstr4f4██  $f5██$gstr4f5██  $f6███$gstr4f6█  $f7███$gstr4f7█
$f0 ███████▄      $f1 ▀▀  ▀▀  ▀▀   $f2████████████  $f3████████████  $f4████████████  $f5████████████  $f6████████████  $f7████████████
$f0 ▀█████████▄▄  $f1              $f2██▀██▀▀██▀██  $f3██▀██▀▀██▀██  $f4██▀██▀▀██▀██  $f5██▀██▀▀██▀██  $f6██▀██▀▀██▀██  $f7██▀██▀▀██▀██
$f0   ▀███████▀   $f1              $f2▀   ▀  ▀   ▀  $f3▀   ▀  ▀   ▀  $f4▀   ▀  ▀   ▀  $f5▀   ▀  ▀   ▀  $f6▀   ▀  ▀   ▀  $f7▀   ▀  ▀   ▀
$reset$wrapon
EOF

}

drawPacmanGhosts;



export PS1="\u@\h:\w\\$\[$(tput sgr0)\]"

#######################################################################################################################
#	[-|\||) ()|= |_||\|[-
#######################################################################################################################

# figlet -f slant "Hello World" | lolcat

fortune | lolcat



# Colors
CLR_RED="110 23 8"
CLR_GREEN="27 119 55"
CLR_YELLOW="67 109 7"
CLR_BLUE="7 59 74"
CLR_CYAN="45 103 120"
CLR_WHITE="255 255 255"
CLR_BLACK="0 0 0"

# Exit
EXIT_OK="$CLR_GREEN"
EXIT_ERROR="$CLR_RED"
# User
USERNAME="$CLR_CYAN"
# Path
PATH_COLOR="$CLR_BLACK"
# Prompt
PROMPT_COLOR="$CLR_YELLOW"
# Text
TEXT_COLOR="$CLR_WHITE"

get_exit_code(){
    RV=$?
    echo -en "$RV"
    return $RV
}

get_exit_code_color(){
    RV=$?
    if (( $RV == 0 )); then
        echo -en `to_rgb $EXIT_OK 1`
    else
        echo -en `to_rgb $EXIT_ERROR 1`
    fi
    return $RV
}

get_exit_code_color_2(){
    RV=$?
    if (( $RV == 0 )); then
        echo -en `to_rgb $EXIT_OK 0` # Green
    else
        echo -en `to_rgb $EXIT_ERROR 0` # Red
    fi
    echo -en `to_rgb $USERNAME 1` # Cyan bg
    return $RV
}

to_rgb() {
    if (( $4 == 0 )); then
        printf "\x1b[38;2;$1;$2;${3}m\n"
    else
        printf "\x1b[48;2;$1;$2;${3}m\n"
    fi
}

RESET_COLORS="\e[00m"a
SEPARATOR="\342\226\210\356\202\260"

# Exit code
# Username
# Path
# Prompt
PS1="\
\[\$(get_exit_code_color)\] \$(get_exit_code)\[\$(get_exit_code_color_2)\]\[$SEPARATOR\]\
\[\$(to_rgb $TEXT_COLOR 0)\$(to_rgb $USERNAME 1)\] \u\[\$(to_rgb $USERNAME 0)\$(to_rgb $PATH_COLOR 1)\]\[$SEPARATOR\]\
\[\$(to_rgb $TEXT_COLOR 0)\$(to_rgb $PATH_COLOR 1)\] \w\[$RESET_COLORS\]\[\$(to_rgb $PATH_COLOR 0)\]\[$SEPARATOR\]
\[\$(to_rgb $TEXT_COLOR 0)\$(to_rgb $PROMPT_COLOR 1)\] \$\[$RESET_COLORS\$(to_rgb $PROMPT_COLOR 0)\]${SEPARATOR}\[$RESET_COLORS\] "


#eval 'dircolors ~/.dir_colors' 	# without this path it will just use

#######################################################################################################################
#	[-|\||) ()|= |_||\|[-
#######################################################################################################################