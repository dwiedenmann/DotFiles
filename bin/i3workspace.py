#!/usr/bin/python
from sys import argv
import yaml
import os
import time
from collections import Iterable
# Define i3 layouts path
i3layouts="/home/david/.config/i3/layouts"

workspacesFile = "/home/david/.config/i3/layouts/workspaces.yaml"

# Construct the i3-msg commands to select workspace and kill current programs
execnsi="exec --no-startup-id"
#outputredirect="&> /dev/null"
resetworkspace="focus parent;focus parent;focus parent;kill;"

def main():
	workspaces = loadWorkspaces()

	if(len(argv) == 1):
		loadAll(workspaces);
	else:
		loadOne(workspaces, argv[1]);


def loadWorkspaces():
	try:
		with open(workspacesFile, 'r') as stream:
			workspaces = yaml.load(stream)["workspaces"]
	except yaml.YAMLError as exc:
		print(exc)
		exit
	return workspaces


def loadWorkspace(workspaceKey, workspaceValue):
	layout = workspaceValue["layout"]
	print("workspace: {0}".format(workspaceKey))
	print("layout:    {0}".format(layout))

	cmd = "i3-msg \""
	cmd += "workspace --no-auto-back-and-forth {0};".format(workspaceKey)
	cmd += resetworkspace
	cmd += "append_layout {0}/{1};".format(i3layouts, layout)
	for launch in workspaceValue["launch"]:
		print("Launch: {0}".format(launch))
		for command, args in launch.items():
			if (command == "web"):
				command = "google-chrome-stable  --app-auto-launched --new-window"
			cmd += "{0} {1}".format(execnsi, command)
#			print(type(args))
			if type(args) == type(dict()):
				for arg in args.items():
					cmd += " {0}".format(arg)
			elif args is not None:
				cmd += " {0}".format(args)
			cmd += ";"
	cmd += "\""
	print(cmd)
	os.system(cmd)
	waitforswallow()

def search(workspaces, lookup):
	for key, value in workspaces.items():
		#print(key)
		if lookup in key:
			return key

def loadOne(workspaces, arg):
	#print(arg)
	k = search(workspaces, arg)
	v = workspaces[k]
	loadWorkspace(k, v)

def loadAll(workspaces):
	for key in workspaces:
		value = workspaces[key]
		loadWorkspace(key, value)


def waitforswallow():
	#sleep 0.1
	# using 
	tick=0.1 	# wait 0.1 seconds between checks
	timeout=50 	# wait a maximum of 50 ticks
	timer=0 	# the loop number
	#while [ ! -z $(i3-msg -t "get_tree" | grep -q \"name\":\"Swallow\ ) & $timer -lt $timeout]
	while (os.system("i3-msg -t \"get_tree\" | grep \\\"name\\\":\\\"Swallows\\ ") != 0 and timer <= timeout):
		time.sleep(tick)
		timer+=1
		print(timer)



if __name__ == "__main__":
    main()