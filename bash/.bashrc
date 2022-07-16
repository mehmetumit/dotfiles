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

export sv="185.225.39.250"
# Change npm default directory
export NPM_CONFIG_PREFIX=~/.npm-global
# Export path after your path to prevent overwritten
export JAVA_HOME="$HOME/GraalVM"
export PATH="$HOME/.local/bin:$HOME/.scripts/:$HOME/.scripts/dmenu-scripts/:$HOME/.scripts/dwm-scripts/:$JAVA_HOME/bin:$HOME/.npm-global/bin/:$PATH"
# Sync multiple bash history in runtime
#export PROMPT_COMMAND='history -a'
export EDITOR="vim"
export TERMINAL="urxvt"
# Fix color issues
export TERM="xterm-256color"
#export BROWSER="firefox"
#export BROWSER="brave"
export GREP_OPTIONS='--color=auto'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
 export FZF_DEFAULT_COMMAND="find -L"
export GDK_DPI_SCALE=1.15
# For UnityEditor
export FrameworkPathOverride=/etc/mono/4.5
#istty -ixon # Disable ctrl-s and ctrl-q
shopt -s autocd #Enter directory without cd
HISTSIZE='INFINITY' #Infinite history line size
HISTFILESIZE='ANDBEYOND' #Infinite history file size
#export GREP_OPTIONS='--color=auto'
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Vi mode on with escape key
set -o vi
# Tab auto completion cycle
bind "TAB:menu-complete"
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"
bind "set completion-ignore-case on"
# Clear screen in vi mode
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
# Shortcuts
# Alt + f -> edit file from current location
bind '"\ef":"vim \"$(find . -type f -print | fzf)\" \n"'
# Alt + d -> edit file from dotfiles
bind '"\ed":"vim \"$(find $HOME/dotfiles -type f -print | fzf)\" \n"'
# Alt + p -> start tmux at projects path
bind '"\ep":"cd \"$(find $HOME/Projects -maxdepth 2 -type d -print | fzf)\" && tmux && cd - && clear\n"'
# Alt + c -> change directory
bind '"\ec":"cd \"$(find . -type d -print | fzf)\" \n"'
# bind '"ı":vi-insertion-mode' -> TODO
# set show-mode-in-prompt on
# set vi-cmd-mode-string "\1\e[2 q\2"
# set vi-ins-mode-string "\1\e[6 q\2"
# set echo-control-characters off
#Aliases
alias rm='rm -i'
alias cp='cp -iv'
alias cds="cd $HOME/.scripts/"
alias cdd="cd $HOME/dotfiles"
alias cdp="cd $HOME/Projects"
alias cdw="cd $HOME/Projects/web"
alias ls='ls -hN --color=auto --group-directories-first'
alias lsa='ls -ahN --color=auto --group-directories-first'
alias lsl='ls -lhN --color=auto --group-directories-first'
alias lsla='ls -lahN --color=auto --group-directories-first'
alias lsal='ls -lahN --color=auto --group-directories-first'
alias lsx='ls -XhN --color=auto --group-directories-first'
alias lslx='ls -lXhN --color=auto --group-directories-first'
alias lsxl='ls -lXhN --color=auto --group-directories-first'

alias grep='grep --color=auto' #Grep highlight
alias less='less -r' # less highlight
alias c='clear'
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias q='exit'
alias p='sudo pacman --color=auto'
alias yay='yay --color=auto'
alias v='vim'
alias ta='tmux attach'
# Fix tmux color issue
alias tmux="TERM=screen-256color-bce tmux"
alias cal='cal -m' # Monday first
# Don't use root user's .vimrc use your own
alias sv='sudo -E  vim'
alias g='git'
alias r='ranger'
alias sr='sudo ranger'
alias th='thunar'
alias sth='sudo thunar'
alias sshot='cd $HOME/Screenshots'
alias yt='yt-dlp --add-metadata -ic' # Download video link
alias yta='yt-dlp --audio-format mp3 --add-metadata -xic' # Download only audio
# reload bashrc settings
alias sbr="source $HOME/.bashrc"
alias htb='sudo openvpn ~/ovpn/htb.ovpn'
# openvpn alias
alias conn-vpn='sudo openvpn --config'
# Run with Nvidia GPU
alias unityhub='prime-run unityhub'
#alias trash='cd ~/.local/share/Trash/files'
#alias empty-trash='gio trash --empty;  echo "The trash has been emptied"'
#PS1='\[\033[0;31m\]\u@\h:\[\033[01;34m\]\w\[\033[1;00m\]> '

# If you using double quotes in PS1 don't forget to add escape otherwise it doesn't update until you source bashrc
get_git_branch() {
	git branch 2> /dev/null | awk '/*/{printf "(%s)", $2}'

}

# User name and host name included
#PS1="${UC}\u@\h${COLOR_WHITE}:${COLOR_BLUE}\w${COLOR_YELLOW}\$(get_git_branch)${COLOR_RED} → ${COLOR_NC} "
# Without user and host name
PS1="${COLOR_BLUE}\w${COLOR_YELLOW}\$(get_git_branch)${UC} → ${COLOR_NC}"
#PS1="${COLOR_LIGHT_RED}➵${COLOR_NC} "

#Neofetch from cache
#cat ~/.cache/neofetch
#if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
#echo "->Starting dymdm..."
# else
#	neofetch
#fi
# Increase scroll key speed
xset r rate 300 50
# Swap capslock and escape for vim
setxkbmap -option caps:swapescape
