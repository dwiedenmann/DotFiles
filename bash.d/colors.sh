#!/bin/bash
# UNIX is basically a simple operating system, but you have to be a genius to understand the simplicity. -Dennis Ritchie
#######################################################################################################################
#       __               __                  __               
#      / /_  ____ ______/ /_     _________  / /___  __________
#     / __ \/ __ `/ ___/ __ \   / ___/ __ \/ / __ \/ ___/ ___/
#    / /_/ / /_/ (__  ) / / /  / /__/ /_/ / / /_/ / /  (__  ) 
#   /_.___/\__,_/____/_/ /_/   \___/\____/_/\____/_/  /____/  
#                                                                                                        
#######################################################################################################################
#
# Functions
#
#######################################################################################################################
 
# ANSI Color -- use these variables to easily have different color
#    and format output. Make sure to output the reset sequence after 
#    colors (f = foreground, b = background), and use the 'off'
#    feature for anything you turn on.

initializeANSI() {
  esc=""

  # Foreground        # Background
  blackf="${esc}[30m";    blackb="${esc}[40m";
  redf="${esc}[31m";      redb="${esc}[41m";
  greenf="${esc}[32m"   greenb="${esc}[42m";
  bluef="${esc}[34m";     blueb="${esc}[44m";
  purplef="${esc}[35m"    purpleb="${esc}[45m"
  yellowf="${esc}[33m"    yellowb="${esc}[43m";
  cyanf="${esc}[36m";     cyanb="${esc}[46m";
  whitef="${esc}[37m"   whiteb="${esc}[47m"
  
  # Enable ASCII Feature  # Disable ASCII Feature
  wrapon="${esc}[?7h";    wrapoff="${esc}[?7l";
  boldon="${esc}[1m";     boldoff="${esc}[21m"
  dimon="${esc}[2m";      boldoff="${esc}[22m"
  italicson="${esc}[3m";  italicsoff="${esc}[23m"
  ulon="${esc}[4m";       uloff="${esc}[24m"
  blinkon="${esc}[5m";    blinkoff="${esc}[25m"
#  italicson="${esc}[6m";   italicsoff="${esc}[26m"
  invon="${esc}[7m";      invoff="${esc}[27m"

  reset="${esc}[0m"
}

initializeANSI

#######################################################################################################################

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
  for i in {0..7}; do         # step through the colors in the order we want them displayed
    colorNum=${gColor[$i]}        # map the color to get what we display by column
    bgColorNum=$((colorNum+$1*8))
    fgColor="f$i"             # color variable name
    fgColor=${!fgColor}           # color value   

    #eval "bgColor=$((${1}*60+$i+40))m"   # set Background Color
    if [ "$1" -eq "1" ]; then
      fgColor="$boldon$fgColor"

    fi
    if [ "$2" -eq "1" ]; then
      displayText=${colorNames[$colorNum]}    # Display Color Name
      #fgColor="$boldon$f0"
    else
      displayText="color${bgColorNum}"  # Display Color Hex Code
      displayText=${!displayText^^}   # Display Color Hex Code
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
eyel1="$f1█▀█"; eyer1="$f1█▀█"; eyed1="$f1███"; eyeu1="$f1█ █";
eyel2="$f1▄▄█"; eyer2="$f1█▄▄"; eyed2="$f1█ █"; eyeu2="$f1███";


# Assign eye shapes to ghosts
gEyesTop=("l" "l" "d" "d" "r" "r")
gEyesBot=("l" "l" "u" "u" "r" "r")

for gNum in {0..5};
do
  cNum="f$((gNum+2))"   # get the color number
  gCol=${!cNum}     # get the color value
  gEyes=${gEyesTop[gNum]} # get the Direction
  eval "declare gstr1$cNum=\$\"\$eye${gEyes}1\$$cNum██\$eye${gEyes}1""\$$cNum\" "
  eval "declare gstr2$cNum=\$\"\$eye${gEyes}2\$$cNum██\$eye${gEyes}2""\$$cNum\" "
  gEyes=${gEyesBot[gNum]} # get the Direction
  eval "declare gstr3$cNum=\$\"\$eye${gEyes}1\$$cNum██\$eye${gEyes}1""\$$cNum\" "
  eval "declare gstr4$cNum=\$\"\$eye${gEyes}2\$$cNum██\$eye${gEyes}2""\$$cNum\" "
done



# BASH Builtins
# : [arguments]     Do nothing beyond expanding arguments and performing redirections. The return status is zero.
# . filename [args]   Read and execute commands from filename 
# eval [arguments]    Concatenate arguments
# [           evaluate a conditional expression and return 0(true) or 1(false)
# ( expr )        Return the value of expr

# Expansion
#  {aa,bb,cc,dd}  => aa bb cc dd
#  {0..12}        => 0 1 2 3 4 5 6 7 8 9 10 11 12
#  {3..-2}        => 3 2 1 0 -1 -2
#  {a..g}         => a b c d e f g
#  {g..a}         => g f e d c b a


colpath="$HOME/bin/colors/"
ghost="$colpath/ghost.txt"
pacman="$colpath/pacman.txt"
dots="$colpath/dots.txt"
del="-d' '"
si="/dev/stdin"
echo $reset$wrapoff
# paste $pacman $dots -d ""\
#   | paste $s1 $ghost \
#   | paste $s1 $ghost \
#   | paste /dev/stdin $ghost \
#   | paste /dev/stdin $ghost \
#   | paste /dev/stdin $ghost \
#   | paste /dev/stdin $ghost

# paste <<< paste $pacman \
#     <<< paste $dots -d" " \
#       <<< paste $ghost \
#       <<< paste $ghost -d" " \
#       <<< paste $ghost \
#       <<< paste $ghost -d" " \
#       <<< paste $ghost -d" " | ( "awk ""'"'{print "\033[1;31m" $0}'"'" ) \
#       <<< "awk ""'"'{print "\033[1;31m" $0}'"'" <<< paste $ghost -d" "


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



#######################################################################################################################
# [-|\||) ()|= |_||\|[-
#######################################################################################################################