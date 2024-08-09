#!/bin/sh
# ensure the script is being run in the correct directory
if [ ! -f polute.sh ]; then
    echo "You are running the script from the wrong directory"
    exit 1
fi

# Remove all the files from the directory except the script, the README.md, and  .git
find . -maxdepth 1 -type f | grep -v -E '(install.sh|pkglist.txt|polute.sh|README.md|.git|powertop.service)' | xargs rm -f
rm -rf .config
rm -rf Backgrounds

mkdir Backgrounds
mkdir .config
cp ~/.zshrc .zshrc
cp ~/.zshenv .zshenv
cp ~/.Xresources .XresourceS
cp ~/.xinitrc .xinitrc
# cp ~/.Xauthority .Xauthority
cp -r ~/Backgrounds/ .
cp -r ~/.config/Thunar/ .config/
cp -r ~/.config/bspwm/ .config/
cp -r ~/.config/sxhkd/ .config/
cp -r ~/.config/kitty/ .config/
cp -r ~/.config/neofetch/ .config/
cp -r ~/.config/nitrogen/ .config/
cp -r ~/.config/nvim/ .config/
cp -r ~/.config/picom/ .config/
cp -r ~/.config/polybar/ .config/
cp -r ~/.config/rofi/ .config/
cp -r ~/.config/wired .config/

# git add, commit, and push
git add .
git commit -m "polute"
git push
