#!/usr/bin/env zsh

###############################################################################
# Title: run-zsh-command.zsh                                                  #
#                                                                             #
# Description: run arbitrary zsh command and show ouput in Raycast window.    #                                                                            #
#              will expand aliases in ~/.zsh/aliases                          #
# Arguments:                                                                  #
#         <command> Your arbitrary zsh commands (oneliner).                   #
#                   * If blank, it opens the Terminal app and cd to <dir>.    #
#       <directory> The directory where your command will be excuted.         #
#                   * If blank, it uses $HOME.                                #
#                                                                             #
###############################################################################
#
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Run Command
# @raycast.description Run arbitrary zsh command and return output in Raycast.
# @raycast.mode fullOutput
# @raycast.author Matt Burman
# @raycast.authorURL https://github.com/mattburman
#
# Optional parameters:
# @raycast.icon images/run-zsh-command.png
# @raycast.packageName Zsh Command
# @raycast.argument1 { "type": "text", "placeholder": "Command (Default: open Terminal)", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "Directory (Default: $HOME)", "optional": true }

cmd="$1"
dir="${2/#\~/$HOME}"

expanded=$(grep "^alias $cmd=" ~/.zsh/aliases -rh | head -n 1 | awk -F "'" '{print $2}')
if [ -z "$expanded" ]; then
	cd $dir
	eval $cmd
else
	cd $dir
	eval ${expanded}
fi
