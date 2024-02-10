#!/bin/bash
######################################################################
#                                                                    #
#                                                                    #
#           ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗         #
#           ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔════╝         #
#           ██████╔╝███████║███████╗███████║██████╔╝██║              #
#           ██╔══██╗██╔══██║╚════██║██╔══██║██╔══██╗██║              #
#           ██████╔╝██║  ██║███████║██║  ██║██║  ██║╚██████╗         #
#           ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝         #
#                                                                    #
#                                                                    #
######################################################################

[ -f "$HOME/.envrc" ] && source "$HOME/.envrc"
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"
[ -f "$HOME/.convrc" ] && source "$HOME/.convrc"

# Can be useful for PS1
export COLOR_NC='\[\e[0m\]' # No Color
export COLOR_BLACK='\[\e[1;30m\]'
export COLOR_GRAY='\[\e[1;30m\]'
export COLOR_RED='\[\e[1;31m\]'
export COLOR_LIGHT_RED='\[\e[0;31m\]'
export COLOR_GREEN='\[\e[1;32m\]'
export COLOR_LIGHT_GREEN='\[\e[0;32m\]'
export COLOR_BROWN='\[\e[1;33m\]'
export COLOR_YELLOW='\[\e[1;33m\]'
export COLOR_LIGHT_YELLOW='\[\e[1;93m\]'
export COLOR_BLUE='\[\e[1;34m\]'
export COLOR_LIGHT_BLUE='\[\e[0;34m\]'
export COLOR_PURPLE='\[\e[1;35m\]'
export COLOR_LIGHT_PURPLE='\[\e[0;35m\]'
export COLOR_CYAN='\[\e[1;36m\]'
export COLOR_LIGHT_CYAN='\[\e[0;36m\]'
export COLOR_LIGHT_GRAY='\[\e[0;37m\]'
export COLOR_WHITE='\[\e[1;37m\]'
export COLOR_MAGENTA='\[\e[1;35m\]'
export UC=$COLOR_GREEN # user's color
[ $UID -eq "0" ] && UC=$COLOR_RED   # root's color

#istty -ixon # Disable ctrl-s and ctrl-q
shopt -s autocd #Enter directory without cd
HISTSIZE='INFINITY' #Infinite history line size
HISTFILESIZE='ANDBEYOND' #Infinite history file size
#export GREP_OPTIONS='--color=auto'
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Vi mode on with escape key
set -o vi
# set show-mode-in-prompt on
# set vi-cmd-mode-string "\1\e[2 q\2"
# set vi-ins-mode-string "\1\e[6 q\2"
# set echo-control-characters off
# Tab auto completion cycle
bind "TAB:menu-complete"
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"
bind "set completion-ignore-case on"
# Clear screen in vi mode
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# Shortcuts
# Change directory with ranger
bind '"\C-O":"ranger_cd\n"'
# Alt + f -> edit files from current location
bind '"\ef":"edit_files\n"'
# Alt + d -> edit files fromdotfiles
bind '"\ed":"edit_dotfiles\n"'
# Alt + p -> start tmux at selected projects path
bind '"\ep":"start_tmux\n"'
# Alt + t -> start tmux at selected path
bind '"\et":"start_tmux\n"'
# Alt + c -> change directory
bind '"\ec":"quick_cd\n"'
# Ctrl + r -> search through history
bind '"\C-R":"search_command\n"'
# Alt + v -> take note with vimwiki
bind '"\ev":"tknote\n"'
# Alt + s -> calculate disk usage in current location
bind '"\es":"disk_usage\n"'
# bind '"ı":vi-insertion-mode' -> TODO

# User name and host name included
#PS1="${UC}\u@\h${COLOR_WHITE}:${COLOR_BLUE}\w${COLOR_YELLOW}\$(get_git_branch)${COLOR_RED} → ${COLOR_NC} "
# Without user and host name
PS1="${COLOR_BLUE}\w${COLOR_YELLOW}\$(get_git_branch)${COLOR_RED}\$(get_git_status)${UC} → ${COLOR_NC}"
#PS1="${COLOR_LIGHT_RED}➵${COLOR_NC} "

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
