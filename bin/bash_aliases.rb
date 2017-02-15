#!/usr/bin/env ruby
# UNIX is basically a simple operating system, but you have to be a genius to understand the simplicity. -Dennis Ritchie
#######################################################################################################################
#	    __               __             ___                     
#	   / /_  ____ ______/ /_     ____ _/ (_)___ _________  _____
#	  / __ \/ __ `/ ___/ __ \   / __ `/ / / __ `/ ___/ _ \/ ___/
#	 / /_/ / /_/ (__  ) / / /  / /_/ / / / /_/ (__  )  __(__  ) 
#	/_.___/\__,_/____/_/ /_/   \__,_/_/_/\__,_/____/\___/____/   
#                                                      
#######################################################################################################################
#
# 	Load Aliases from YAML Format
# 		Called By    :	  ~/.bash_aliases
# 		Ruby Parser  :	bin/ bash_aliases.rb
# 		YAML Aliases :	  ~/.bash_aliases.yml
#
# 	This version is designed to parse aliases organized under named groups in the YAML
# 	file, so the first level of mappings are purely semantic, and are used to keep the
# 	data organized and well-documented.
#
#   If for some reason we didn't want this as a separate file
# 	the yaml could be parsed in .bash_alias directly using something like below
#   ruby -ryaml -e "puts YAML::load(open(ARGV.first).read)['tags']" example.md
#
#######################################################################################################################

require 'pathname'
require 'yaml'

# Sync to stdout so bash can read the source instruction at the end
$stdout.sync = true					

############################################################
# Load the aliases from the YAML source file
############################################################

aliases_file = '~/.bash_aliases.yml' 	# Bash Aliases in YAML format

# Load the top level alias groups
alises_groups = YAML.
	load_file Pathname(aliases_file).
	expand_path.realpath

# Aliases are all merged into a single Hash according to the rules of Ruby's `Hash#merge`,
# which silently overwrites duplicates. It may be a good idea to enhance this code with a
# declarative block passed to `merge` that prevents data loss or at least warns the user.
#aliases_yaml = alises_groups.values.reduce &:merge
aliases_yaml = alises_groups.values.reduce({}, :merge)


############################################################
# Write the YAML data to bash script using the alias command
############################################################

aliases_bash = '/tmp/aliases.bash'	# temp file to write bash aliases to

# Open the temp bash file
File.open(aliases_bash, 'w') do |f|
	
	# Write each key/value pair in the bash alias format
	aliases_yaml.each_pair do |alias_name, command|
  		# Detect whether to wrap the alias in single or double quotes
  		if command.include? "$("
  			quote = "'" # single quotes
  		else 
			quote = '"' # double quotes
  		end
    	f.puts %Q[alias #{alias_name}=#{quote}#{command}#{quote}]
  	end

end

# Output a command telling the shell to evaluate the alias file
puts "source #{aliases_bash}"

# Note: no cleanup is done for the generated Bash script, but as long as 'w' mode is used
# for file access, it can be safely overwritten indefinitely. If you try to delete the file
# immediately after printing the `source` command, it may not have time to be loaded.

#######################################################################################################################
#	[-|\||) ()|= |_||\|[-
#######################################################################################################################