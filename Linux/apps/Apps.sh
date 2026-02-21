#!/bin/bash
set -e

echo "🚀 Instalando meus aplicativos no CachyOS"
echo

# Garante sudo uma vez só
sudo -v

# Espelhos primeiro (download mais rápido)
sudo pacman -S --noconfirm --needed reflector
sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist

# Atualiza sistema
sudo pacman -Syu --noconfirm

# Apps oficiais (sem mexer no sistema)
sudo pacman -S --noconfirm --needed \
mpv \
btop \
fastfetch \
alacritty \
discord \
obs-studio

# AUR helper (se não existir)
if ! command -v paru &> /dev/null; then
  sudo pacman -S --noconfirm --needed base-devel git
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si --noconfirm
  cd ..
  rm -rf paru
fi

# Apps AUR
paru -S --noconfirm --needed \
feishin \
pano \
lastfm-scrobbler

echo
echo -e "\e[1;32m✅ Tudo pronto. Seu sistema continua intacto.\e[0m"