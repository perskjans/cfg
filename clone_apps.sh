#!/bin/sh

for entry in \
    "jarun/nnn $HOME/rep/apps" \
    "junegunn/fzf $HOME/rep/apps" \
    "perskjans/dmenu $HOME/rep/apps/suckless" \
    "perskjans/dwm $HOME/rep/apps/suckless" \
    "perskjans/lemonbar-xft $HOME/rep/apps" \
    "perskjans/slock $HOME/rep/apps/suckless" \
    "perskjans/st $HOME/rep/apps/suckless"
do
    repo=${entry%\ *}
    name=${repo#*/}
    dest=${entry#*\ }
    mkdir -p $dest

    if [ $(echo "$repo" | grep -c "^http") -eq 0 ]; then
        repo="https://github.com/$repo"
    fi
    cd $dest
    if [ ! -d $name ]; then
        p_gitutils clone "$repo --recursive"
        echo
    fi
done
