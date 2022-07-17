#!/bin/sh

#Startx Automatically
if [ -z "$DISPLAY" ] && [ "$(tty)" = /dev/tty1 ]; then
	printf "Initializing X session...\n"
	startx > "$HOME/.startx.log"
logout
fi
