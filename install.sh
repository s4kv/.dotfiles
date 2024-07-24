#!/bin/sh

# Check if paru is installed
if ! command -v paru >/dev/null 2>&1; then
    echo "paru is not installed. Installing now..."
    git clone https://aur.archlinux.org/paru.git
    cd paru || exit
    makepkg -si
else
    echo "paru is already installed."
fi

sudo paru -S --noconfirm --needed "$(cat pkglist.txt)"

# Create symlink to for the files in ~/ and ~/.config
mkdir -p ~/.config
for file in ~/.dotfiles/.*; do ln -sf "$file" ~; done
for file in ~/.dotfiles/.config/*; do ln -sf "$file" ~/.config/; done
