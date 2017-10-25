#!/usr/bin/env python3
import subprocess
import os
import re
import glob


# Place in ~/.local/share/nemo/scripts

# --- set the list of valid extensions below (lowercase)
# --- use quotes, *don't* include the dot!
ext = ["jpg", "jpeg", "png", "gif", "icns", "ico"]
# ---

# retrieve the path of the targeted folder
#current = "/media/MediaCode/Test"
current = os.getenv("NEMO_SCRIPT_CURRENT_URI").replace("file://", "").replace("%20", " ")
#current = os.getenv("NAUTILUS_SCRIPT_CURRENT_URI").replace("file://", "").replace("%20", " ")
dr = os.path.realpath(current)

# custom ordering function for picking the best folder icon
def ordering(f):
  if f == "folder.jpg":
    return " " + f
  if "pl.jpg" in f:
    return " " + f
  return f

for root, dirs, files in os.walk(dr):
    #if len(dirs) = 0:
    #  dirs = current
    for directory in dirs:
        folder = os.path.join(root, directory)
        try:
            images = (p for p in os.listdir(folder) 
                     if p.split(".")[-1].lower() in ext)
            
            try:
              first = min(images, key = lambda f: ordering(f))
            except ValueError:
              #print (folder + "/**/*.jpg")
              images = glob.glob(folder + r'/*/*.jpg', recursive=True)
              #print (images)
              first = min(images, key = lambda f: ordering(f))
            
        except ValueError:
            pass
        else:
              jpg = os.path.abspath(os.path.join(folder, first))
              icon = os.path.abspath(os.path.join(folder, "folder.ico"))
#              cmd = ["convert", first, " -resize x16 -gravity center -crop 16x16+0+0 -flatten -colors 256 -background transparent output/", icon]
              cmd = ["convert", 
                     "-resize", "x128", 
                     "-colors", "256", 
                     jpg, icon]
              #print (cmd)
              subprocess.Popen(cmd)
              # cmd = ["gvfs-set-attribute", "-t", "string",
              #   os.path.abspath(folder), "metadata::custom-icon",
              #   "file://"+os.path.abspath(os.path.join(folder, first))]
              cmd = ["gvfs-set-attribute", "-t", "string",
                os.path.abspath(folder), "metadata::custom-icon",
                "file://"+icon]
              subprocess.Popen(cmd)
              print(cmd)
#

