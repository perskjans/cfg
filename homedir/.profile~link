### START: general

    stty -ixon # Disable ctrl-s and ctrl-q

    # Load dircolors for ls
    test -r ~/.config/dircolors && eval "$(dircolors -b ~/.config/dircolors)"

### END: general

### START: Load rc file for current shell
    case $SHELL in
        *bash) [ -f $HOME/.bashrc ] && . $HOME/.bashrc ;;
    esac
### END: Load rc file for current shell


# Start xserver if on tty1 and not already running
#[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/den/null && exec startx $HOME/.config/X11/xinitrc
