#!/bin/bash
# This file is sourced by run_cfgscripts
# vim: set shiftwidth=2 filetype=sh :

distrofiles=$(dirname $(dirname $(readlink $0)))/distro_specific_files

[ -f /etc/arch-release ] && DISTRO_TYPE=arch
[ -f /etc/redhat-release ] && DISTRO_TYPE=redhat
[ $(command -v apt) ] && DISTRO_TYPE=debian
[ $(command -v xbps-install) ] && DISTRO_TYPE=void
[ $(command -v zypper) ] && DISTRO_TYPE=suse

case $DISTRO_TYPE in
arch)
  packages="\
    alsa-utils \
    arandr \
    automake \
    bash \
    bash-completion \
    diffutils \
    dunst \
    fossil \
    gcc \
    libnotify \
    libvirt \
    make \
    mpv \
    neovim \
    network-manager-applet \
    networkmanager \
    nnn \
    noto-fonts \
    noto-fonts-emoji \
    openssh \
    openssl \
    papirus-icon-theme \
    patch \
    pavucontrol \
    pulseadio \
    pulsemixer \
    qemu \
    sxhkd \
    sysstat \
    tmux \
    transmission-cli \
    trayer \
    ttf-dejavu \
    ttf-inconsolata \
    ttf-liberation \
    ttf-linux-libertine \
    unzip \
    virt-manager \
    volumeicon \
    wget \
    xbacklight \
    xclip \
    xorg-font-utils \
    xorg-fonts-encodings \
    xorg-xclock \
    xorg-xinit \
    xorg-xrandr \
    xorg-xset \
    xorg-xsetroot \
    xterm \
    "
  yay -Syu $packages
;;

suse)

  sudo zypper install opi

  opi dunst
  opi neovim
  opi trayer
  opi tint2conf
  opi pulsemixer
  opi transmission
  opi volumeicon

  packages="\
    alsa \
    arandr \
    automake \
    bash \
    bash-completion \
    diffutils \
    dunst \
    fossil \
    gcc \
    kitty \
    libnotify \
    libvirt \
    make \
    mpv \
    openssh \
    openssl \
    papirus-icon-theme \
    patch \
    pavucontrol \
    pulseaudio \
    readline-devel
    sxhkd \
    sysstat \
    tmux \
    unclutter \
    unzip \
    wget \
    xorg-x11-devel \
    "

    # qemu \
    # virt-manager \

  sudo zypper ar $distrofiles/opensuse.repo 2>/dev/null
  sudo zypper install $packages

esac

