# This file is sourced by run_cfgscripts
# vim: set shiftwidth=2 filetype=sh :

for dir in app tmp rep msc $(grep -o '/.*"' $cfgroot/configdir/user-dirs.dirs | tr '"' ' ')
do
  [ ! -d "$homedir/$dir" ] && run_cmd "mkdir -p -m 755 $homedir/${dir#*\/}"
done

# Delete dirs created by desktop environments
for dir in Desktop Documents Downloads Music Pictures Public Templates Videos
do
  [ -d "$homedir/$dir" ] && run_cmd "rm -rf $homedir/$dir"
done

