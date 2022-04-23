# vim: set filetype=sh shiftwidth=2 :

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Set Vi key bindings
set -o vi

# Use emacs bindings for clearing screen
bind -x '"\C-l": clear;'


## SHOPT OPTIONS
  # If set, the pattern "**" used in a pathname expansion context will match all
  # files and zero or more directories and subdirectories.
  shopt -s globstar
  # Allows you to cd into directory merely by typing the directory name
  shopt -s autocd

  # append to the history file, don't overwrite it
  shopt -s histappend

  # check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize

## BASH COMPLETION
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

## HISTORY CONFIG
  export HISTFILE="$XDG_CACHE_HOME/bash/history"

  # don't put duplicate lines or lines starting with space in the history.
  HISTCONTROL=ignoreboth

  # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
  HISTSIZE=1000
  HISTFILESIZE=20000

## EXPORTS
  ## path
    path=$HOME/.work/bin
    for d in $(find -L $HOME/bin -type d); do path=$path:$d; done

    PATH=$path:$HOME/.local/bin:$PATH
    export PATH

  ## tty
  export TTY=$(tty)

  ## Locale
    lang="sv_SE.UTF-8"
    langtime="en_DK.UTF-8"
    [[ $(locale -a | grep -c 'en_DK') -eq 0 ]] && langtime="sv_SE.UTF-8"

    unset LC_ALL
    export LANG="en_US.UTF-8"
    export LC_CTYPE="en_US.UTF-8"
    export LC_NUMERIC="$lang"
    export LC_TIME="$langtime"
    export LC_COLLATE=C
    export LC_MONETARY="$lang"
    export LC_MESSAGES="en_US.UTF-8"
    export LC_PAPER="$lang"
    export LC_NAME="$lang"
    export LC_ADDRESS="$lang"
    export LC_TELEPHONE="$lang"
    export LC_MEASUREMENT="$lang"
    export LC_IDENTIFICATION="en_US.UTF-8"

  ## Terminal colors
    #export TC_RESET="\[$(tput sgr0)\]"

    #export TC_BRIGHT="\[$(tput bold)\]"
    #export TC_UNDERSCORE="\[$(tput smul)\]"
    #export TC_REVERSE="\[$(tput rev)\]"

    #export TC_FG_BLACK="\[$(tput setaf 0)\]"
    #export TC_FG_RED="\[$(tput setaf 1)\]"
    #export TC_FG_GREEN="\[$(tput setaf 2)\]"
    #export TC_FG_YELLOW="\[$(tput setaf 3)\]"
    #export TC_FG_BLUE="\[$(tput setaf 4)\]"
    #export TC_FG_MAGENTA="\[$(tput setaf 5)\]"
    #export TC_FG_CYAN="\[$(tput setaf 6)\]"
    #export TC_FG_WHITE="\[$(tput setaf 7)\]"

    #export TC_BG_BLACK="\[$(tput setab 0)\]"
    #export TC_BG_RED="\[$(tput setab 1)\]"
    #export TC_BG_GREEN="\[$(tput setab 2)\]"
    #export TC_BG_YELLOW="\[$(tput setab 3)\]"
    #export TC_BG_BLUE="\[$(tput setab 4)\]"
    #export TC_BG_MAGENTA="\[$(tput setab 5)\]"
    #export TC_BG_CYAN="\[$(tput setab 6)\]"
    #export TC_BG_WHITE="\[$(tput setab 7)\]"

    export TC_RESET="\033[0m"

    export TC_BRIGHT="\033[1m"
    export TC_UNDERSCORE="\033[4m"
    export TC_REVERSE="\033[7m"

    export TC_FG_BLACK="\033[30m"
    export TC_FG_RED="\033[31m"
    export TC_FG_GREEN="\033[32m"
    export TC_FG_YELLOW="\033[33m"
    export TC_FG_BLUE="\033[34m"
    export TC_FG_MAGENTA="\033[35m"
    export TC_FG_CYAN="\033[36m"
    export TC_FG_WHITE="\033[37m"

    export TC_BG_BLACK="\033[40m"
    export TC_BG_RED="\033[41m"
    export TC_BG_GREEN="\033[42m"
    export TC_BG_YELLOW="\033[43m"
    export TC_BG_BLUE="\033[44m"
    export TC_BG_MAGENTA="\033[45m"
    export TC_BG_CYAN="\033[46m"
    export TC_BG_WHITE="\033[47m"

  ## XDG
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_DESKTOP_DIR="$HOME/dsk"
    export XDG_DOCUMENTS_DIR="$HOME/doc"
    export XDG_DOWNLOAD_DIR="$HOME/dwn"
    export XDG_MUSIC_DIR="$HOME/mus"
    export XDG_PICTURES_DIR="$HOME/pic"
    export XDG_PUBLICSHARE_DIR="$HOME/pub"
    export XDG_RUNTIME_DIR="$HOME/.cache/runtime"
    export XDG_TEMPLATES_DIR="$HOME/tpl"
    export XDG_VIDEOS_DIR="$HOME/vid"
    mkdir -p $XDG_DATA_HOME/fonts
    mkdir -p -m 700 $XDG_RUNTIME_DIR

  ## Misc
    #[ $(command -v st) ] && export TERMINAL=st || export TERMINAL=kitty
    export TERMINAL=kitty
    export EDITOR=vim
    if [ $(command -v nvim) ]; then
      export EDITOR=nvim
      export MANPAGER="nvim -c 'set ft=man nomod nolist' -"
    fi

    export BROWSER=chromium

    # colored GCC warnings and errors
    export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

    export QT_STYLE_OVERRIDE=gtk
    export QT_SELECT=qt5

    export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME"/bash-completion/bash_completion

    export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
    export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

    mkdir -p "$XDG_CACHE_HOME/less"
    export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"
    #export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
    export LESSHISTFILE=- # can be used to disable this feature.

    export KDEHOME="$XDG_CONFIG_HOME/kde"

    export XCOMPOSEFILE="$XDG_CONFIG_HOME/X11/xcompose"
    export XCOMPOSECACHE="$XDG_CACHE_HOME/X11/xcompose"

    export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"

    export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"

    export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"

    export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

    mkdir -p "$XDG_CONFIG_HOME/pg" && mkdir -p "$XDG_CACHE_HOME/pg"
    export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
    export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
    export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
    export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"


    export TMUX_TMPDIR="$XDG_RUNTIME_DIR"

    export WGETRC="$XDG_CONFIG_HOME/wgetrc"

    export XAUTHORITY="$HOME/.Xauthority"

    export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
    export XSERVERRC="$XDG_CONFIG_HME/X11/xserverrc"

    export SQLITE_HISTORY=$XDG_DATA_HOME/sqlite_history

    export PYTHONPYCACHEPREFIX=$XDG_CACHE_HOME/pycache

## ALIASES

  alias e=$EDITOR
  alias vi=$EDITOR
  alias epipe="$EDITOR -c 'set ft=man nomod nolist' -"

  # Use Vim to read man pages
  vman() {
      if [ $# -eq 0 ]; then
          /usr/bin/man
      elif whatis $* ; then
          /usr/bin/man $* | col -b | e -c 'set ft=man nomod nolist' -
      fi
  }
  alias man='vman'

  alias ..='cd ..'
  alias ...='cd ../..'
  alias ....='cd ../../..'

  # enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi

  alias sx="startx $XDG_CONFIG_HOME/X11/xinitrc"

  alias n='nnn -H'

  alias pl='. $HOME/.profile'

  alias psa='ps aux | grep'
  alias jb='jobs'
  alias ll='ls -alhF'
  alias la='ls -Ah'
  alias l='ls -hCF'

  alias xresources='. $HOME/.config/X11/xprofile'

  alias tx='$HOME/bin/p-runtmux'

  ## Git related aliases
    alias g='git'
    alias ga='g add'
    alias gA='ga $(gs -s | sed "s|^.*\ ||g")'
    alias gd='g diff --color=auto'
    alias gbr='g branch'
    alias gcd='cd $(git rev-parse --show-toplevel)'
    alias gchp='g cherry-pick'
    alias gci='g commit'
    alias gco='g checkout'
    alias gls='g ls-tree --full-tree --name-only -rt HEAD'
    alias gme='g merge'
    alias gps='g push'
    alias gpu='g pull'
    alias grs='g restore --staged'
    alias gs='g status'
    alias gsm='g submodule'

    alias glgf='g log -p --'
    alias glgg="g log --graph --oneline --decorate --all"
    alias glg1="g log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %s - %an%C(bold yellow)%d%C(reset)' --all"
    alias glg2="g log --reverse --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %s - %an%C(bold yellow)%d%C(reset)' --all"
    alias glg3="g log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''%s - %an' --all"
    alias glg4="g log --reverse --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''%s - %an' --all"

    alias gcl='p-gitutils clone'
    alias gfa='p-gitutils findall'
    alias gpa='p-gitutils pullall'
    alias gsa='p-gitutils submoduleadd'
    alias gsi='p-gitutils submoduleinit'
    alias gsd='p-gitutils submoduledeinit'
    alias gsl="(gcd; cat .gitmodules | grep submodule | cut -d'\"' -f2)"
    alias gslp="(gcd; git submodule status | cut -d' ' -f3)"
    alias gsr='p-gitutils submodulerm'
    alias gss='git submodule status'
    alias gsu='p-gitutils submoduleupdate'

    alias gdirset='export GIT_DIR=$HOME/.cfg.git/; export GIT_WORK_TREE=$HOME'
    alias gdirunset='unset GIT_DIR; unset GIT_WORK_TREE'

    alias gsetupstream='p-gitutils setupstream'
    alias gdeleteupstream='p-gitutils deleteupstream'

## PLATTFORM SPECIFIC
    DISTRO_TYPE=unknown

    [ -f /etc/arch-release ] && DISTRO_TYPE=arch
    [ -f /etc/redhat-release ] && DISTRO_TYPE=redhat
    [ $(command -v apt) ] && DISTRO_TYPE=debian
    [ $(command -v xbps-install) ] && DISTRO_TYPE=void
    [ $(command -v zypper) ] && DISTRO_TYPE=suse

    export DISTRO_TYPE

    ## Set up aliases for package manager
    case $DISTRO_TYPE in
        arch)
            # Use yay instead of Pacman so user repositories are used
            alias pm='yay '
            alias pi='yay -S '
            alias pr='yay -Rs '
            alias pc='yay -Scc '
            alias pu='yay -Syu '
            alias pq='yay -Q | grep "(Installed)" -A 1 | grep -v "^--$" | vim -c "set nomod nolist nonu norelativenumber filetype=man" - '
            alias pqr='yay -Ss | vim -c "set nomod nolist nonu norelativenumber filetype=man" - '
            alias prd='yay -Qdtq sudo pacman -Rs - '
        ;;

        debian)
            alias pm='sudo apt '
            alias pi='sudo apt install '
            alias pr='sudo apt remove '
            alias pc='sudo apt clean '
            alias pu='sudo apt update && sudo apt upgrade '
            alias pq='dpkg -l '
            alias pqr='sudo apt search '
            alias prd='sudo apt autoremove '
        ;;

        redhat)
            manager=yum
            [ $(command -v dnf) ] && manager=dnf

            alias pm='sudo $manager '
            alias pi='sudo $manager install '
            alias pr='sudo $manager remove '
            alias pc='sudo $manager clean all '
            alias pu='sudo $manager upgrade '
            alias pq='rpm -qa '
            alias pqr='sudo $manager search '
            alias prd='sudo $manager autoremove '
        ;;

        suse)
            alias pm='sudo zypper '
            alias pi='sudo zypper in '
            alias pr='sudo zypper rm --clean-deps '
            alias pc='sudo zypper clean all '
            alias pu='sudo zypper up '
            alias pq='zypper pa | grep "^i+" | epipe'
            alias pdu='sudo zypper dup '
            alias pqr='zypper se | epipe'
            alias prd='sudo zypper rm --clean-deps $(sudo zypper | grep "^i" | cut -d"|" -f3)'
        ;;

        void)
            alias pm='sudo xbps-install '
            alias pi='sudo xbps-install -S '
            alias pr='sudo xbps-remove -R '
            alias pc='sudo xbps-remove -Oo '
            alias pu='sudo xbps-install -Su '
            alias pq='xbps-query '
            alias pqr='xbps-query -Rsl | grep -i '
            alias prd='sudo xbps-remove -Oo '
        ;;
    esac

## PROMPT
    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
    esac

    # Using this so I can override it in my work config
    get_hostname(){ hostname; }

    promptcmd()
    {
        local exitstatus=$?
        local exitcolor="${TC_FG_GREEN}"

        if [ $exitstatus -ne 0 ]; then
            exitcolor="${TC_FG_RED}"
        fi

        userco="$TC_FG_GREEN"

        if [ "$UID" == "0" ]; then
            userco="$TC_FG_RED"
        fi

        local LNS="\[${TC_FG_BLUE}\]\n#\[${TC_RESET}\]"
        local LBRACK="\[${TC_FG_BLUE}\][\[${TC_RESET}\]"
        local RBRACK="\[${TC_FG_BLUE}\]]\[${TC_RESET}\]"
        local EXIT="${LBRACK}\[${exitcolor}\]${exitstatus}${RBRACK}"
        local DATE="${LBRACK}$(date +%H:%M)${RBRACK}"
        local USR="\[${userco}\]${USER}\[${TC_RESET}\]"
        local HOST="\[${userco}\]$(get_hostname)\[${TC_RESET}\]"
        local CWD="\[${TC_FG_YELLOW}\]$(pwd)\[${TC_RESET}\]"
        local CLNS="\[${TC_FG_BLUE}\]\n#$ \[${TC_RESET}\]"
        local GITSTATUS="$(p-gitutils current_status)"
        [ -n "$GITSTATUS" ] && GITSTATUS="${LBRACK}${GITSTATUS}${RBRACK}"

        export PS1=''
        export PS1="${LNS}${EXIT}${DATE}${LBRACK}${USR}@${HOST}: ${CWD}${RBRACK}${GITSTATUS}${CLNS}"
    }
    export PROMPT_COMMAND=promptcmd

# source plugins
for f in $HOME/.config/shellfiles/bash/*; do . $f; done

# source work specific files
[ -d $HOME/.work/config ] && for f in $HOME/.work/config/*; do . $f; done

