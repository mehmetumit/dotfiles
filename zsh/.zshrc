#!/bin/zsh
##################################################################
# 																 #
# 																 #
# 		 ████████  ████████ ██      ██ ███████     ██████  		 #
# 		░░░░░░██  ██░░░░░░ ░██     ░██░██░░░░██   ██░░░░██ 		 #
# 		     ██  ░██       ░██     ░██░██   ░██  ██    ░░ 		 #
# 		    ██   ░█████████░██████████░███████  ░██       		 #
# 		   ██    ░░░░░░░░██░██░░░░░░██░██░░░██  ░██       		 #
# 		  ██            ░██░██     ░██░██  ░░██ ░░██    ██ 		 #
# 		 ████████ ████████ ░██     ░██░██   ░░██ ░░██████ 		 #
# 		░░░░░░░░ ░░░░░░░░  ░░      ░░ ░░     ░░   ░░░░░░  	     #
# 																 #
# 																 #
##################################################################

[ -f "$HOME/.envrc" ] && source "$HOME/.envrc"
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"
[ -f "$HOME/.convrc" ] && source "$HOME/.convrc"

PS1='%B%F{blue}%~%F{yellow}$(get_git_branch)%(!.%F{red}.%F{green}) → %b%f'

HISTFILE=~/.zsh_history
HISTSIZE=99999999
SAVEHIST=99999999
export KEYTIMEOUT=1
setopt autocd beep extendedglob PROMPT_SUBST
unsetopt nomatch notify
# Disable freeze
stty stop undef
# Vi mode
bindkey -v

# autoload -Uz compinit
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
# Include hidden files
_comp_options+=(globdots)
compinit

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
# Edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Shortcuts
# Change directory with ranger
bindkey -s "\C-O" "ranger_cd\n"
# Alt + f -> edit files from current location
bindkey -s "\ef" "edit_files\n"
# Alt + d -> edit files fromdotfiles
bindkey -s "\ed" "edit_dotfiles\n"
# Alt + p -> start tmux at projects path
bindkey -s "\ep" "start_tmux\n"
# Alt + c -> change directory
bindkey -s "\ec" "quick_cd\n"
# Alt + h -> search through history and edit it
bindkey -s "\eh" "search_command\n"

#Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

autoload -U colors && colors

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
