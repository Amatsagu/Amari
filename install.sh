#!/bin/bash

# ===========================================================================
# STEP 0
# CREATE DIRECTORIES
# ===========================================================================

mkdir -p ~/.config
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/fonts
sudo chmod +x ./script/*
sudo chmod +x ./get-app/*
sudo chmod +x ./remove-app/*
# sudo cp ./script/* /usr/local/bin/ -r

cat << EOF
# ===========================================================================
# STEP 1
# INSTALL CORE PACKAGES (Debian 12)
# ===========================================================================
EOF


# Install microcode && drivers to enable hardware acceleration (at least for integrated graphics)
proc_type=$(lscpu)
if grep -E "GenuineIntel" <<< ${proc_type}; then
    sudo apt install intel-microcode -y
    # No extra driver installation for intel APU as linux-firmware should already have it.
elif grep -E "AuthenticAMD" <<< ${proc_type}; then
    sudo apt install amd64-microcode -y
    sudo apt install libegl-mesa0 libgbm1 libgl1-mesa-dri libglapi-mesa libglx-mesa0 mesa-utils-bin mesa-va-drivers mesa-vdpau-drivers mesa-vulkan-drivers -y
fi

# Install essential packages
sudo apt install htop zip curl wget neofetch build-essential network-manager wayland-protocols blueman brightnessctl gpg xdg-desktop-portal-wlr -y
sudo apt autoremove --purge -y
systemctl enable --now NetworkManager

# Install Sway + its essentials
sudo apt install sway waybar wlogout swaylock swayidle swaybg mako-notifier -y

# Install audio support
sudo apt install pipewire pipewire-audio-client-libraries pavucontrol volumeicon-alsa pamixer -y
systemctl --user daemon-reload
systemctl --user --now enable pipewire pipewire-pulse

# Install gsettings
sudo apt install libglib2.0-0 libglib2.0-bin -y

read -r -p "Press any key to continue (auto skip in 20s).." -t 20 -n 1 -s
printf "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

cat << EOF
# ===========================================================================
# STEP 2
# INSTALL MAIN DESKTOP APPLICATIONS (Debian 12)
# ===========================================================================
EOF

# Install file manager, app launcher, and image capturer, graphical network manager
sudo apt install nemo fuzzel grim slurp network-manager-gnome -y

read -r -p "Press any key to continue (auto skip in 20s).." -t 20 -n 1 -s
printf "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

cat << EOF
# ===========================================================================
# STEP 3
# CONFIGURE STYLES, ICONS & FONTS (Debian)
#
# Warning
# Those styles were composed for 1920x1080, 14'' laptop [IPS] (250 nits)
# screen. Please modify font size & aliasing settings for your display:
#
# Previously applied changes:
#
# gsettings set org.nemo.desktop font "Noto Sans 10"
# gsettings set org.gnome.desktop.interface font-name "Noto Sans 10"
# gsettings set org.gnome.desktop.interface document-font-name "Noto Sans 10"
# gsettings set org.cinnamon.desktop.wm.preferences titlebar-font "Sans Bold 10"
# gsettings set org.gnome.desktop.wm.preferences titlebar-font "Sans Bold 10"
# gsettings set org.gnome.desktop.interface monospace-font-name "Monospace 11"
# gsettings set org.gnome.desktop.interface font-antialiasing "rgba"
# gsettings set org.gnome.desktop.interface font-hinting "slight"
# gsettings set org.gnome.desktop.interface font-rgba-order "rgb"
#
# ===========================================================================
EOF

# Install styles, icons & fonts
sudo apt install materia-gtk-theme breeze-cursor-theme papirus-icon-theme fonts-font-awesome fonts-hack fonts-hack-ttf fonts-hack-web fonts-noto fonts-noto-cjk fonts-noto-cjk-extra fonts-noto-color-emoji fonts-noto-core fonts-noto-extra fonts-noto-hinted fonts-noto-mono fonts-noto-ui-core fonts-noto-ui-extra fonts-noto-unhinted -y

sh ./script/amari-gsettings.sh

read -r -p "Press any key to continue (auto skip in 20s).." -t 20 -n 1 -s
printf "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

cat << EOF
# ===========================================================================
# STEP 4
# COPY CONFIGS INTO ~/.config
# ===========================================================================
EOF

sudo cp ./config/* ~/.config/ -r -v

printf "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

cat << EOF
# ===========================================================================
# FINISHED BASIC INSTALLATION
#
# Warning
# Some GTK settings are quirky with auto reload, please restart your
# computer to see all changes.
#
# Note
# Consider checking ./get-app directory. It constains installation scripts for
# applications that are known to cause problems under wayland. Installed this
# way apps will automatically use proper flags to launch under wayland.
#
# ===========================================================================
EOF
