#!/bin/sh
# For fix java awt white screen on dwm
export AWT_TOOLKIT=MToolkit
# For fix java gui problems
export _JAVA_AWT_WM_NONREPARENTING=1
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
# XCURSOR_THEME=Oxygen 14 Matrix Green
# XCURSOR_THEME=Oxygen 18 White
# edit ~/.icons/default/index.theme , ~/.Xresources and ~/.config/gtk-3.0/settings.ini for change cursor theme
# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi
# Needed for cinnamon dwm already includes this script in ~/.dwm/ directory
#(startup-script &> .startup.log)&

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        # shellcheck source=/dev/null
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Start display manager
printf "Initializing dymdm...\n"
dymdm 2>&1
#picom &
#nitrogen --restore &
#startup_script &
#while true; do
#	dwm >/dev/null 2>&1
#done
#
#exec dwm
