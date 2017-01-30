#!/bin/bash
########################################################################################################################
# 	Generate ~/.XResources
#
# 		Produces a ~/.Xresources file by listing files in
# 		~/.config/X11/Xresources.d/
#
########################################################################################################################

# Get the list of XResources to #include
# Get the absolute path from the relative path
RESOURCE_DIR=$( readlink -e ../Xresources.d/ )
#RESOURCE_DIR="$HOME/.config/X11/Xresources.d/"
XRESOURCES="$HOME/.Xresources"

readlink $RESOURCE_DIR

# Get a temporary file since it's a pain to handle all the
# slashes and newlines otherwise using sed replace
temp_file=$(mktemp)

# find all files in resource dir, 
# sort them, 
# add #include and wrap in quotes
# output to temp file
# Count the # of Files we need to include 
Cnt_Includes_Found=$( \
find $RESOURCE_DIR -type f \
	| sort \
	| sed 's/.*/#include "&"/' \
	| tee $temp_file \
	| wc -l \
	)

cat $temp_file

# could have just as easily reversed the order
	# | tee >(wc -l) \
	# > $temp_file 

# Count the # of existing matches in the file
# Use | sort | uniq | wc to make sure we don't double count duplicate matches
Cnt_Includes_Exist=$( \
	grep -f $temp_file $XRESOURCES \
	| sort | uniq | wc -l )

if [ $Cnt_Includes_Found -ne $Cnt_Includes_Exist ]; then
#if [ $REPLACE_XRESOURCES_INCLUDES ]; then
	# Use sed to replace the existing auto-generated section of Xresources with this
	lead='^! BEGIN GENERATED CONTENT$'
	tail='^! END GENERATED CONTENT$'
	sed -i -e "/$lead/,/$tail/{ /$lead/{p; r $temp_file
	        }; /$tail/p; d }"  $XRESOURCES
fi

# remove the temporary file
rm -f ${temp_file}

########################################################################################################################
#	[-|\||) ()|= |_||\|[-
########################################################################################################################