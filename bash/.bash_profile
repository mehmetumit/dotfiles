#
# ~/.bash_profile
#
#export PATH=$PATH:/home/dymos/.scripts
#export EDITOR="vim"
#export TERMINAL="termite"
#export BROWSER="firefox"
#export GREP_OPTIONS='--color=auto'
export HISTTIMEFORMAT="%d/%m/%y %T "
[[ -f ~/.bashrc ]] && . ~/.bashrc

#Startx Automatically
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
	printf "Initializing X session...\n"
	startx > "$HOME/.startx.log"
logout
fi
