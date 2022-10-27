#!/bin/bash
# This file is sourced by run_cfgscripts
# vim: set shiftwidth=2 filetype=sh :

INSTALL_X_PACKAGES=${1:-0}

distrofiles=$(dirname $(dirname $(realpath $0)))/distro_specific_files

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

  #sudo zypper install opi

  # opi dunst
  # opi neovim
  # opi trayer
  # opi tint2conf
  # opi pulsemixer
  # opi transmission
  # opi volumeicon

  server_packages=(
    bash
    bash-completion
    neovim
    openssh
    openssl
    opi
    sysstat
    tmux
    unzip
    wget
  )

  dev_packages=(
    automake
    clang
    diffutils
    fossil
    gcc
    gdb
    git
    make
    patch
    readline-dev
    xorg-x11-devel
  )

  x_packages=(
    alsa
    arandr
    codecs
    dunst
    kitty
    libnotify
    libvirt
    mpv
    papirus-icon-theme
    pavucontrol
    pulseaudio
    sxhkd
    unclutter
    virt-manager
    xorg-x11-server
  )

    # qemu \

  sudo zypper ar $distrofiles/opensuse.repo
  sudo zypper install "${server_packages[@]}" "${dev_packages[@]}"
  if [[ $INSTALL_X_PACKAGES -ne 0 ]]; then
    sudo zypper install "${x_packages[@]}"
  fi
esac

