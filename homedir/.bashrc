# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Set Vi key bindings
set -o vi

 # Use emacs bindings for clearing screen
 bind -x '"\C-l": clear;'

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

shopt -s autocd # Allows you to cd into directory merely by typing the directory name

# append to the history file, don't overwrite it
shopt -s histappend

export HISTFILE="$HOME/.cache/bash/history"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

for f in $HOME/.config/shfiles/*; do . $f; done

# source work specific files
[ -d $HOME/.work/config ] && for f in $HOME/.work/config/*; do . $f; done
