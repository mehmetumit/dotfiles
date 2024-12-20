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

PS1='%B%F{blue}%~%F{yellow}$(get_git_branch)%F{red}$(get_git_status)%(!.%F{red}.%F{green}) ➤ %b%f'

HISTFILE=~/.zsh_history
HISTSIZE=99999999
SAVEHIST=99999999
export KEYTIMEOUT=1
setopt autocd beep extendedglob PROMPT_SUBST share_history
unsetopt nomatch notify
# Disable freeze
stty stop undef
# Disable paste highlighting
zle_highlight=('paste:none')
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
# bindkey '^e' edit-command-line
bindkey -M vicmd '^e' edit-command-line
bindkey -M viins '^e' edit-command-line
bindkey -M visual '^e' edit-command-line

# Shortcuts
# Change directory with ranger
bindkey -s "\C-O" "ranger_cd\n"
# Alt + f -> edit files from current location
bindkey -s "\ef" "edit_files\n"
# Alt + d -> edit files fromdotfiles
bindkey -s "\ed" "edit_dotfiles\n"
# Alt + p -> start tmux at selected projects path
bindkey -s "\ep" "start_tmux_at_projects\n"
# Alt + t -> start tmux at selected  path
bindkey -s "\et" "start_tmux\n"
# Alt + c -> change directory
bindkey -s "\ec" "quick_cd\n"
# Ctrl + r -> search through history and edit it
bindkey -s "\C-R" "search_command\n"
# Alt + v -> take note with vimwiki
bindkey -s "\ev" "tknote\n"
# Alt + s -> calculate disk usage in current location
bindkey -s "\es" "disk_usage\n"

# Ctrl + space -> accept autosuggestion
bindkey '^ ' autosuggest-accept

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

# Extensions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
