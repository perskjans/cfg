#!/bin/bash
# vim: set shiftwidth=2 :

cfgroot=$(dirname $(realpath $0))
homedir=$HOME

function usage()
{
  echo """
  Args:
  --dry : dry run, nothing is done
  --home <homedir> : Acting home directory.
  """
}

function args_handling()
{
  while [ "$#" -ne 0 ]; do
    case $1 in
      --dry) dryrun=1 ;;
      --home) shift; homedir=$1 ;;
      *)
        usage; exit 1 ;;
    esac
    shift
  done
}

function run_cmd()
{
  local cmd="$1"
  echo -e "Running: $cmd"
  if [ -z "$dryrun" ]; then
    $cmd
  else
    echo -e "Dry run. Not running command!\n"
  fi
}

function make_link()
{
  local target="$1"
  local link_name="$2"
  local ln_cmd="ln -sf -T"
  local do_sudo=''
  [ -n "$3" ] && do_sudo="sudo "

  if [ -e "$link_name" ]; then
    if [ $(realpath "$link_name") != "$target" ]; then
      echo -e "\nFile exist: $(stat -c '%F %N' $link_name)"
      read -r -p "Replace? y/n: " answer

      case ${answer,,} in
        y) run_cmd "${do_sudo}$ln_cmd $target $link_name" ;;
        *) should_make_link=0; echo "Skipping!" ;;
      esac
      echo
    fi
  else
    run_cmd "${do_sudo}$ln_cmd $target $link_name"
  fi
}

function make_default_dirs()
{
  for dir in app tmp rep msc $(grep -o '/.*"' "$cfgroot/homedir/.config/user-dirs.dirs~link" | tr '"' ' ')
  do
    [ ! -d "$homedir/$dir" ] && run_cmd "mkdir -p -m 755 $homedir/${dir#*\/}"
  done

  # Delete dirs created by desktop environments
  for dir in Desktop Documents Downloads Music Pictures Public Templates Videos
  do
    [ -d "$homedir/$dir" ] && run_cmd "rm -rf $homedir/$dir"
  done
}

function link_files()
{
  for f in $(find "$cfgroot/homedir" -name '*~link*'); do
    local link_name=${f%~link*}
    link_name=${link_name/"$cfgroot/homedir"/$homedir}
    local dirname=${link_name%/*}
    mkdir -p "$dirname"
    make_link "$f" "$link_name"
  done
}

function link_root_files()
{
  make_link "$cfgroot/rootfiles/keyboard.layout" "/usr/share/X11/xkb/symbols/custom" 1
}

function install_packages()
{
  echo "Install packages"
}

function apply_fonts()
{
  cd $homedir/.config/fontconfig

  mkfontscale
  mkfontdir

  xset fp rehash
  fc-cache

  xset q

  cd - >/dev/null
}

function main()
{
  [ -n "$dryrun" ] && echo DRY RUN!!
  echo "cfg root: $cfgroot"
  echo "Acting homedir: $homedir"

  echo
  read  -p "Continue? y/n: " answer
  [ "$answer" != "y" ] && echo Quiting! && exit 0

  cd $cfgroot/cfgscripts

  scripts=("0.Quit")
  scripts+=($(ls))
  scriptslen=${#scripts[@]}
  last_index=$(( scriptslen - 1 ))

  while true; do
    echo -e """
    0. Quit
    1. Create dirs
    2. Link files
    3. Link root files
    4. Install packages
    5. Apply fonts

    At first time running the script, you should execute the functions in order!
    """

    read  -p "Chose function [0-$last_index]: " answer

    echo
    case $answer in
      0) echo -e "\nQuiting!" ; exit 0 ;;
      1) make_default_dirs ;;
      2) link_files ;;
      3) link_root_files ;;
      4) install_packages ;;
      5) apply_fonts ;;
      *) echo "Faulty choice!!" ;;
    esac
  done
}

args_handling "$@"
main
