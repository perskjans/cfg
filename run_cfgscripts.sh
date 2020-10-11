#!/bin/bash
# vim: set shiftwidth=2 :

cfgroot=$(dirname $(realpath $0))
homedir=$HOME

while [ "$#" -ne 0 ]; do
  case $1 in
    --dry) dryrun=1 ;;
    --home) shift; homedir=$1 ;;
    *)
    cat << EOS
Args:
  --dry : dry run, nothing is done
  --home <homedir> : Acting home directory.
EOS
    exit 1
    ;;

  esac
  shift
done



function run_cmd()
{
  local cmd="$1"
  echo -e "$cmd"
  if [ -z "$dryrun" ]; then
    $cmd
  fi
}

function make_links()
{
  local target="$1"
  local link_name="$2"
  local ln_cmd="ln -sf"
  local do_sudo=''
  [ -n "$3" ] && do_sudo="sudo "

  local should_make_link=1
  if [ -e "$link_name" ] || [ -L "$link_name" ]; then
    echo -e "\nFile exist: $(stat -c '%F %N' $link_name)"
    read  -p "Replace? y/n: " answer

    case $answer in
      y) ${do_sudo}rm -rf $link_name;;
      n) should_make_link=0 ;;
    esac
    echo
  fi

  [ $should_make_link -eq 1 ] && run_cmd "${do_sudo}$ln_cmd $target $link_name"
}

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
  echo
  for i in "${!scripts[@]}"; do echo "${scripts[$i]}"; done

  echo -e "\nAt first time running the script, you should execute the functions in order!"
  read  -p "Chose function [0-$last_index]: " answer

  echo
  case $answer in
    0) echo -e "\nQuiting!" ; exit 0 ;;
    [1-9]*)
      if [ $answer -lt $scriptslen ]; then
        source ${scripts[$answer]}
      else
        echo "Faulty choice!!"
      fi
      ;;
    *) echo "Faulty choice!!" ;;
  esac
done

