#!/usr/bin/python

#======================================================================
# i3 (Python modfule for configuring i3wm workspaces)
# Copyright (C) 2017 David Wiedenmann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#======================================================================

import sys				# handle parameters
import yaml 			# yaml parsing
import subprocess		# used to call i3-msg
import os				# used to redirect subprocess output to /dev/null
import time 			# sleep()
import pprint			# pretty print to format dictionary
from collections.abc import Mapping
import argparse 		# argument parser

# Define i3 layouts path
userhomeDir 	= os.path.expanduser('~') + "/"
i3configDir 	= userhomeDir 	+ ".config/i3/"
i3layoutsDir 	= i3configDir 	+ "layouts/"
workspacesFile 	= i3layoutsDir 	+ "workspaces.yaml"


def main():
	"""
	The main routine
	"""
	config = Config()

	config.parse()

	return

	
	
	#config.workspaces.setup()



class Config(object):
	"""
	Config Object
	"""

	def __init__(self):
		self.loadConfigFile()
		self.workspaces = Workspaces(self.config["workspaces"])
		self.screens 	= Screens 	(self.config["screens"])
		self.programs 	= Programs  (self.config["programs"])

		self.workspaces.config = self
		self.screens.config = self
		self.programs.config = self

	def loadConfigFile(self):
		"""
		Load the config dictionaries from YAML
		"""	
		try:
			with open(workspacesFile, 'r') as stream:
				self.config = yaml.load(stream)
		except yaml.YAMLError as exc:
			print(exc)
			exit

	def parse(self):

		parser = argparse.ArgumentParser(description='Process some i3 workspaces.')
		#parser = argparse.ArgumentParser()

		parser.add_argument(
				'--current', '-c',
				help 	= 'Open current workspace',
				action 	= 'store_true'
			)

		# Create a listapps subcommand       
		parser.add_argument(
				'--auto', '-a',
				help 	= 'Open all workspaces flagged w/ autoopen attribute',
				action 	= 'store_true'
			)

		# Create a listapps subcommand       
		parser.add_argument(
				'--number', '-n',
				help 	= 'Open workspace with user supplied argument',
				nargs 	= '+'
			)

		# If called with no arguments provide help
		if len(sys.argv) <= 1:
		    sys.argv.append('--help')

		# Parse Arguments
		options = parser.parse_args()

		print(options)

		# Open Automatically flagged workspaces
		if   options.auto 	 == True:
			self.workspaces.openAutostart()

		# Open Current workspace
		elif options.current == True:
			self.workspaces.openCurrent()

		# Open Selected workspace(s)
		elif options.number  != None:
			for ws in options.number:
				self.workspaces.openOne(ws)

		return

		# print(self.programs)
		# if(len(argv) == 1):
		# 	#self.workspaces.openAutostart();
		# 	self.workspaces.openCurrent();
		# else:
		# 	self.workspaces.openOne(argv[1]);

class InheritDb(Mapping):
	"""
	Inherit dictionary functionality
	"""
	def __init__(self, *args, **kw):
		self._storage = dict(*args, **kw)
	def __getitem__(self, key):
		return self._storage[key]
	def __iter__(self):
		return iter(self._storage)    
	def __len__(self):
		return len(self._storage)

class Screens(InheritDb):
	def foo():
		pass

class Programs(InheritDb):
	def getFullCommand(self, command):
		try:
			print(self._storage)
			print(self._storage[command])
			command = self._storage[command]
			print(command)
		except KeyError as exc:
			pass
		return command

class Workspaces(InheritDb):

	def setup(self):
		for k, v in self._storage.items():
			workspace = Workspace(k, v)	
			workspace.config = self.config
			setupcmd = workspace.setup()
			print(setupcmd)

	def openOne(self, arg):
		"""
		Open/Launch a single workspace
		"""	
		for k, v in self._storage.items():
			workspace = Workspace(k, v)
			workspace.config = self.config
			if (arg.isdigit() and workspace.number == int(arg)
				or workspace.name == arg):
				workspace.open()

	def openAutostart(self):
		"""
		Open/Launch all workspaces with the autostart property = True
		"""	
		for k, v in self._storage.items():
			workspace = Workspace(k, v)
			workspace.config = self.config
			if (workspace.autostart == True):
				workspace.open()

	def openCurrent(self):
		ws = i3.getCurrentWorkspace()
		print(ws)
		self.openOne(str(ws))



class Workspace(object):
	"""
	A single workspace
	"""

	# def __init__(self, config, name):
	# 	"""
	# 	Initalize the workspace
	# 	"""
	# 	self.config 		= config
	# 	self.name 	= name 
	# 	self.workspaceValue = config.workspaces[name]
	# 	self.layout 		= self.workspaceValue["layout"]
	# 	try:
	# 		if (self.workspaceValue["autostart"] == True):
	# 			self.autostart = True
	# 	except KeyError as exc:
	# 		self.autostart = False
	# 	try: 
	# 		self.screen = self.workspaceValue["screen"]
	# 	except KeyError as exc:
	# 		self.screen = None

	def __init__(self, workspaceKey, workspaceValue):
		"""
		Initalize the workspace
		"""
		self.name 			= workspaceKey
		self.number 		= [int(s) for s in self.name.split(':') if s.isdigit()][0]
		self.numberMod10	= self.number % 10
		#print(self.name)
		#print(self.number)
		self.workspaceValue = workspaceValue
		self.layout 		= self.workspaceValue["layout"]
		try:
			if (self.workspaceValue["autostart"] == True):
				self.autostart = True
		except KeyError as exc:
			self.autostart = False
		try: 
			self.screen = self.workspaceValue["screen"]
		except KeyError as exc:
			self.screen = None


	def open(self):
		"""
		Open the workspace using i3-msg
		"""

		# Print the workspace
		print(self)

		# Send the request to i3-msg
		i3.i3msg(self.getOpenCmd())

		# Wait until all windows have opened before exiting
		i3.UnswallowedWait()

		# return to the previously selected workspace
		i3.i3msg('workspace back_and_forth')

	def getOpenCmd(self):
		"""
		Construct the i3-msg commands to select workspace and kill current programs
		"""
		
		# Switch to the workspace
		cmd = "workspace --no-auto-back-and-forth {0};".format(self.name)

		# Kill all windows in workspace
		cmd += "focus parent;focus parent;focus parent;kill;"

		# Load a layout template
		cmd += "append_layout {0}/{1};".format(i3layoutsDir, self.layout)

		# Loop through commands to launch
		for launch in self.workspaceValue["launch"]:
			#print("Launch:    {0}".format(launch))
			for command, args in launch.items():
				command = self.config.programs.getFullCommand(command)
				# if (command == "web"):
				# 	command = "google-chrome-stable  --app-auto-launched --new-window"
				cmd += "{0} {1}".format("exec --no-startup-id", command)
				if type(args) == type(dict()):
					for arg in args.items():
						cmd += " {0}".format(arg)
				elif args is not None:
					cmd += " {0}".format(args)
				cmd += ";"

		# Switch back to the original workspace
		#cmd = "workspace {0};".format(self.name)

		cmd = "\"{0}\"".format(cmd)

		print (cmd)

		return cmd

	def __str__(self):
		#str = ""
		#str += "Workspace: {0}\n".format(self.name)
		#str += "Layout:    {0}\n".format(self.layout)
		#str = pprint.pformat(self.workspaceValue["launch"], depth = 2, width = 1)
		str = pprint.pformat(self.workspaceValue, indent = 4, width = 1)
		return str

	def setup(self):
		cmd = ""
		# Change Workspace
		cmd = cmd + "bindsym {0}+{1} workspace \"{2}\";\n".format("$mod", self.numberMod10, self.name)
		# Set output
		cmd = cmd + "workspace \"{0}\" output {1};\n".format(self.name, self.config.screens[self.screen]["device"])
		# Move Container
		cmd = cmd + "bindsym {0}+{1}+{2} move container to workspace \"{3}\";\n".format("$mod", self.config.screens[self.screen]["modifier"], self.numberMod10, self.name)
		return cmd


"""
bindsym 	$mod+1 				workspace 		$ws_1
bindsym 	$mod+2 				workspace 		$ws_2
bindsym 	$mod+3              workspace 		$ws_3
bindsym 	$mod+4              workspace 		$ws_4
bindsym 	$mod+5              workspace 		$ws_5
bindsym 	$mod+6              workspace 		$ws_6
bindsym 	$mod+7              workspace 		$ws_7
bindsym 	$mod+8              workspace 		$ws_8
bindsym 	$mod+9              workspace 		$ws_9
bindsym 	$mod+0              workspace 		$ws_10
workspace 	$ws_1             	output      	$monitor_1
workspace 	$ws_2             	output      	$monitor_1
workspace 	$ws_3             	output      	$monitor_1
workspace 	$ws_4            	output      	$monitor_1
workspace 	$ws_5            	output      	$monitor_1
workspace 	$ws_6             	output      	$monitor_1
workspace 	$ws_7             	output      	$monitor_1
workspace 	$ws_8             	output      	$monitor_1
workspace 	$ws_9             	output      	$monitor_1
workspace 	$ws_10				output      	$monitor_1
bindsym 	$mod+Shift+1 		move container to workspace $ws_1
bindsym 	$mod+Shift+2 		move container to workspace $ws_2
bindsym 	$mod+Shift+3 		move container to workspace $ws_3
bindsym 	$mod+Shift+4 		move container to workspace $ws_4
bindsym 	$mod+Shift+5 		move container to workspace $ws_5
bindsym 	$mod+Shift+6 		move container to workspace $ws_6
bindsym 	$mod+Shift+7 		move container to workspace $ws_7
bindsym 	$mod+Shift+8 		move container to workspace $ws_8
bindsym 	$mod+Shift+9 		move container to workspace $ws_9
bindsym 	$mod+Shift+0 		move container to workspace $ws_10
"""


class i3(object):
	# def __init__(self):
	# 	pass

	def getCurrentWorkspace():
		ws = ""
		ws = ws + "-t get_workspaces "
		ws = ws + "| jshon -a -e name -u -p -e focused -u "
		ws = ws + "| grep true -B1 "
		ws = ws + "| head -1 "
		ws = ws + "| cut -d: -f1"
		ws = "i3-msg {0}".format(ws)
		#print(ws)
		ws = subprocess.check_output(ws, shell=True) #, stderr=FNULL)	
		ws = int(ws)
		#print(ws)
		return ws

	def i3msg(args):
		"""
		Wrapper for call to subprocess.check_output to redirect stderr to /dev/null
		"""
		cmd = "i3-msg {0}".format(args)
		FNULL = open(os.devnull, 'w')
		try:
			subprocess.check_output(cmd, shell=True, stderr=FNULL)		
			return 1
		except subprocess.CalledProcessError as exc:
			return 0

	def UnswallowedWait():
		"""
		Wait until all i3 layout template windows have been populated with launched apps
		"""
		tick 	= 0.1 	# wait 0.1 seconds between checks
		timeout = 50 	# wait a maximum of 50 ticks
		timer 	= 0 	# the loop number
		while (i3.UnswallowedExist() and timer <= timeout):
			time.sleep(tick)
			timer += 1
			print(timer)

	def UnswallowedExist():
		"""
		Wrapper for call to i3-msg -t get_tree
		"""
		swallowcmd = "-t \"get_tree\" | grep \\\"name\\\":\\\"Swallows\\ "
		return i3.i3msg(swallowcmd)



if __name__ == "__main__":
    main()