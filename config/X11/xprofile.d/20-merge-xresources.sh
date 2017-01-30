#!/bin/bash
########################################################################################################################
#	xrdb - X server resource database utility
#
#      Xrdb  is  used to get or set the contents of the RESOURCE_MANAGER property on the root window of screen 0, or the
#      SCREEN_RESOURCES property on the root window of any or all screens, or everything combined.  You  would  normally
#      run this program from your X startup file.
#
#      Most  X  clients  use  the  RESOURCE_MANAGER and SCREEN_RESOURCES properties to get user preferences about color,
#      fonts, and so on for applications.  Having this information in the server (where it is available to all  clients)
#      instead  of on disk, solves the problem in previous versions of X that required you to maintain defaults files on
#      every machine that you might use.  It also allows for dynamic changing of defaults without editing files.
#
#      The  RESOURCE_MANAGER  property  is  used  for  resources  that  apply  to  all  screens  of  the  display.   The
#      SCREEN_RESOURCES  property  on  each  screen  specifies  additional (or overriding) resources to be used for that
#      screen.  (When there is only one screen, SCREEN_RESOURCES is normally not used, all resources are just placed  in
#      the RESOURCE_MANAGER property.)
#
#      The  file  specified by filename (or the contents from standard input if - or no filename is given) is optionally
#      passed through the C preprocessor with the following symbols defined, based on the  capabilities  of  the  server
#      being used:
#
########################################################################################################################

# 	Merge ~/.Xresources
xrdb -merge ~/.Xresources

########################################################################################################################
#	[-|\||) ()|= |_||\|[-
########################################################################################################################
