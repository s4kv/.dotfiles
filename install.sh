#!/bin/sh

# ensure the script is being run in the correct directory
if [ ! -f install.sh ]; then
    echo "You are running the script from the wrong directory"
    exit 1
fi
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

# create powertop service
#  1   │ [Unit]
#  2   │ Description=Powertop tunings
#  3   │
#  4   │ [Service]
#  5   │ Type=oneshot
#  6   │ RemainAfterExit=yes
#  7   │ ExecStart=/usr/bin/powertop --auto-tune
#  8   │ ExecStartPost=/bin/sh -c 'for f in $(grep -l "Mouse" /sys/bus/usb/devices/*/product
#      │ | sed "s/product/power\\/control/"); do echo on >| "$f"; done'
#  9   │
# 10   │ [Install]
# 11   │ WantedBy=multi-user.target
POWERTOP_SERVICE_PATH="/etc/systemd/system/powertop.service"
sudo cp powertop.service "$POWERTOP_SERVICE_PATH"

# start system services
# auto-cpufreq.service                                                      enabled         disabled
# bluetooth.service                                                         enabled         disabled
# getty@.service                                                            enabled         enabled
# ModemManager.service                                                      enabled         disabled
# NetworkManager-dispatcher.service                                         enabled         disabled
# NetworkManager-wait-online.service                                        enabled         disabled
# NetworkManager.service                                                    enabled         disabled
# powertop.service                                                          enabled         disabled
# supergfxd.service                                                         enabled         disabled
# systemd-boot-update.service                                               disabled        enabled
# systemd-confext.service                                                   disabled        enabled
# systemd-fsck-root.service                                                 enabled-runtime disabled
# systemd-homed-activate.service                                            enabled         enabled
# systemd-homed.service                                                     enabled         enabled
# systemd-network-generator.service                                         disabled        enabled
# systemd-networkd-wait-online.service                                      disabled        enabled
# systemd-networkd.service                                                  disabled        enabled
# systemd-pstore.service                                                    disabled        enabled
# systemd-remount-fs.service                                                enabled-runtime disabled
# systemd-resolved.service                                                  disabled        enabled
# systemd-sysext.service                                                    disabled        enabled
# systemd-timesyncd.service                                                 enabled         enabled
# systemd-journald-audit.socket                                             disabled        enabled
# systemd-mountfsd.socket                                                   disabled        enabled
# systemd-nsresourced.socket                                                disabled        enabled
# systemd-userdbd.socket                                                    enabled         enabled
# machines.target                                                           disabled        enabled
# reboot.target                                                             disabled        enabled
# remote-cryptsetup.target                                                  disabled        enabled
# remote-fs.target                                                          enabled         enabled
systemctl enable --now auto-cpufreq bluetooth getty@.service ModemManager NetworkManager-dispatcher NetworkManager-wait-online NetworkManager powertop supergfxd systemd-boot-update systemd-confext systemd-fsck-root systemd-homed-activate systemd-homed systemd-network-generator systemd-networkd-wait-online systemd-networkd systemd-pstore systemd-remount-fs systemd-resolved systemd-sysext systemd-timesyncd systemd-journald-audit.socket systemd-mountfsd.socket systemd-nsresourced.socket systemd-userdbd.socket machines.target reboot.target remote-cryptsetup.target remote-fs.target
