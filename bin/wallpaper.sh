#!/bin/bash
########################################################################################################################
#	                 ____                                
#	 _      ______ _/ / /___  ____ _____  ___  __________
#	| | /| / / __ `/ / / __ \/ __ `/ __ \/ _ \/ ___/ ___/
#	| |/ |/ / /_/ / / / /_/ / /_/ / /_/ /  __/ /  (__  ) 
#	|__/|__/\__,_/_/_/ .___/\__,_/ .___/\___/_/  /____/  
#	                /_/         /_/                     
#
########################################################################################################################
#
# 	Reset workspace using JSON templates
#
# 		1. Select workspace
#		2. Kill all programs in parent container
#		3. Open Layout in i3
#		4. Open desired programs
#
########################################################################################################################
#
#	Generate a new i3 JSON template
# 		i3-save-tree --workspace 1 > ~/.config/i3/layouts/workspace-1.json
#
########################################################################################################################
# 
#	Pre-prepared Layouts
#		i3layout-generic-4 - quad windows
#
#
#
########################################################################################################################

# Anime
# Flat
# Landscapes

# Define Wallpapers base path
wallpaperRoot="$HOME/Wallpapers"

wptype="*"

wallpaperDir="$wallpaperRoot/*"

# Lookup a folder matching the argument
if [ ! -z "$1" ]; then
	wallpaperDir=`ls -Rbd $wallpaperRoot/* | grep -i $1 | head -1`
fi


echo $wallpaperDir
#exit

bgfile=`ls -Rb $wallpaperDir/*.jpg | sort -R | head -2`
#bgfile="$wallpaperDir/*"


#bgtype="--bg-scale"
bgtype="--bg-fill"


cmd="feh --randomize $bgtype ""$bgfile"""
echo $cmd
$($cmd)
#feh --randomize --bg-fill $wallpaperDir/*



########################################################################################################################
#	[-|\||) ()|= |_||\|[-
########################################################################################################################