# This file is sourced by run_cfgscripts
# vim: set shiftwidth=2 filetype=sh :

mkdir -p $homedir/.local/share/applications

for f in $cfgroot/localdir/applications/*; do
  make_links "$f" "$homedir/.local/share/applications/${f##*/}"
done

for f in $(ls -A $cfgroot/homedir); do
  make_links "$cfgroot/homedir/$f" "$homedir/$f"
done

for f in $(ls -A $cfgroot/configdir); do
  make_links "$cfgroot/configdir/$f" "$homedir/.config/$f"
done

### root files ###

# link keyboard layout
make_links "$cfgroot/rootfiles/keyboard.layout" "/usr/share/X11/xkb/symbols/custom" 1

#sudo cp $HOME/cfg/rootfiles/*.desktop /usr/share/applications/

