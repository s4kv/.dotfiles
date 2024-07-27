#!/bin/sh

# prompt if sure to install
echo "This script will install the following packages:"
cat pkglist.txt
echo "Are you sure you want to install these packages? (y/n)"
read -r answer
if [ "$answer" != "y" ]; then
    echo "Exiting..."
    exit 1
fi

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
