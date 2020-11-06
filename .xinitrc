#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# xinitrc runs automatically when you run startx.

# There are some small but important commands that need to be run when we start
# the graphical environment. I keep those commands in ~/config/xprofile because
# that file is run automatically if someone uses a display manager (login
# screen) and so they are needed there. To prevent doubling up commands, I
# source them here with the line below.

# export STATUSBAR="i3blocks" # Uncomment this line when using i3.

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/xprofile" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/xprofile"

[ -f ~/.config/Xresources ] && xrdb -merge ~/.config/Xresources -I$HOME


userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

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

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Here bspwm is kept as default
session=${1:-kde}
get_session(){
	# local dbus_args=(--sh-syntax --exit-with-session)

    case $session in
        awesome 		  ) exec dbus-launch --sh-syntax --exit-with-session awesome;;
        jwm 			  ) exec dbus-launch --sh-syntax --exit-with-session jwm;;
        deepin 			  ) exec dbus-launch --sh-syntax --exit-with-session startdde;;
        enlightenment 	  ) exec dbus-launch --sh-syntax --exit-with-session enlightenment_start;;
        gnome 			  ) exec dbus-launch --sh-syntax --exit-with-session gnome-session;;
        dwm 			  ) exec dbus-launch --sh-syntax --exit-with-session dwm;;
        bspwm 			  ) exec dbus-launch --sh-syntax --exit-with-session bspwm-session;;
        i3|i3wm           ) exec dbus-launch --sh-syntax --exit-with-session i3;;
        lxde 	          ) exec dbus-launch --sh-syntax --exit-with-session startlxde;;
        lxqt         	  ) exec dbus-launch --sh-syntax --exit-with-session lxqt-session;;
        i3|i3wm           ) exec dbus-launch --sh-syntax --exit-with-session i3;;
        kde               ) exec dbus-launch --sh-syntax --exit-with-session startplasma-x11;;
        cinnamon          ) exec dbus-launch --sh-syntax --exit-with-session cinnamon-session;;
        budgie            ) exec dbus-launch --sh-syntax --exit-with-session budgie-desktop;;
        mate              ) exec dbus-launch --sh-syntax --exit-with-session mate-session;;
        openbox           ) exec dbus-launch --sh-syntax --exit-with-session openbox-session;;
        xfce|xfce4        ) exec dbus-launch --sh-syntax --exit-with-session startxfce4;;
        # No known session, try to run it as command
        *                 ) exec dbus-launch --sh-syntax --exit-with-session $1;;
    esac
}

xset r rate 600 25
exec $(get_session)
