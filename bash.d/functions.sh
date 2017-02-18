#!/bin/bash
# UNIX is basically a simple operating system, but you have to be a genius to understand the simplicity. -Dennis Ritchie
#######################################################################################################################
#       __               __       ____                 __  _                 
#      / /_  ____ ______/ /_     / __/_  ______  _____/ /_(_)___  ____  _____
#     / __ \/ __ `/ ___/ __ \   / /_/ / / / __ \/ ___/ __/ / __ \/ __ \/ ___/
#    / /_/ / /_/ (__  ) / / /  / __/ /_/ / / / / /__/ /_/ / /_/ / / / (__  ) 
#   /_.___/\__,_/____/_/ /_/  /_/  \__,_/_/ /_/\___/\__/_/\____/_/ /_/____/                                                                            
#                                                                                
#######################################################################################################################
#
# Functions
#
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
	img2txt -W$COLUMNS ~/Wallpapers/cleavage_hoshizora_rin_koizumi_hanayo_love_live__murota_yuuhei_possible_duplicate_thighhighs_yazawa_nico_9691x5945.jpg
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
 
#######################################################################################################################
#	[-|\||) ()|= |_||\|[-
#######################################################################################################################