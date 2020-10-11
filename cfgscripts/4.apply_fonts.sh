# This file is sourced by run_cfgscripts
# vim: set shiftwidth=2 filetype=sh :

###
### This script generate font settings
###

cd $homedir/.config/fontconfig

mkfontscale
mkfontdir

xset fp rehash
fc-cache

xset q

cd - >/dev/null
