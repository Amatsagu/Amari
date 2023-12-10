#!/bin/bash

# ===========================================================================
# STEP 0
# CREATE DIRECTORIES
# ===========================================================================


mkdir -p ~/.config
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/fonts

cat << EOF
# ===========================================================================
# STEP 1
# INSTALL CORE PACKAGES (Debian 12)
# ===========================================================================
EOF


# Install microcode
proc_type=$(lscpu)
if grep -E "GenuineIntel" <<< ${proc_type}; then
    sudo apt install intel-microcode -y
    proc_ucode=intel-ucode.img
elif grep -E "AuthenticAMD" <<< ${proc_type}; then
    sudo apt install amd64-microcode -y
fi

# Install essential packages
sudo apt install htop zip curl wget neofetch build-essential network-manager wayland-protocols blueman brightnessctl -y
sudo apt autoremove --purge
systemctl enable --now NetworkManager

# Install Sway + its essentials
sudo apt install sway waybar swaylock swayidle swaybg -y

# Install audio support
sudo apt install pipewire pipewire-audio-client-libraries pavucontrol volumeicon-alsa pamixer 
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

# Install file manager, app launcher, 
sudo apt install nemo fuzzels grimshot -y
gsettings set org.gnome.nm-applet show-applet true

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
sudo apt install materia-gtk-theme breeze-cursor-theme papirus-icon-theme fonts-hack fonts-hack-ttf fonts-hack-web fonts-noto fonts-noto-cjk fonts-noto-cjk-extra fonts-noto-color-emoji fonts-noto-core fonts-noto-extra fonts-noto-hinted fonts-noto-mono fonts-noto-ui-core fonts-noto-ui-extra fonts-noto-unhinted -y

gsettings set org.gnome.desktop.interface gtk-theme "Materia-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface cursor-theme "breeze_cursors"
gsettings set org.gnome.desktop.interface enable-animations true
gsettings set org.nemo.desktop font "Noto Sans 10"
gsettings set org.gnome.desktop.interface font-name "Noto Sans 10"
gsettings set org.gnome.desktop.interface document-font-name "Noto Sans 10"
gsettings set org.cinnamon.desktop.wm.preferences titlebar-font "Sans Bold 10"
gsettings set org.gnome.desktop.wm.preferences titlebar-font "Sans Bold 10"
gsettings set org.gnome.desktop.interface monospace-font-name "Monospace 11"
gsettings set org.gnome.desktop.interface font-antialiasing "rgba"
gsettings set org.gnome.desktop.interface font-hinting "slight"
gsettings set org.gnome.desktop.interface font-rgba-order "rgb"
gsettings set org.gnome.desktop.interface gtk-color-palette "black:white:gray50:red:purple:blue:light blue:green:yellow:orange:lavender:brown:goldenrod4:dodger blue:pink:light green:gray10:gray30:gray75:gray90"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
gsettings set org.gtk.Settings.ColorChooser custom-colors "[(0.81568627450980391, 0.81176470588235294, 0.80000000000000004, 1.0), (0.20000000000000001, 0.7803921568627451, 0.87058823529411766, 1.0), (0.16470588235294117, 0.63137254901960782, 0.70196078431372544, 1.0), (0.63921568627450975, 0.27843137254901962, 0.72941176470588232, 1.0), (0.16470588235294117, 0.4823529411764706, 0.87058823529411766, 1.0), (0.070588235294117646, 0.28235294117647058, 0.54509803921568623, 1.0), (0.9882352941176471, 0.9137254901960784, 0.30980392156862746, 1.0), (0.9137254901960784, 0.67843137254901964, 0.047058823529411764, 1.0)]"
gsettings set org.gtk.Settings.ColorChooser selected-color (true, 1.0, 1.0, 1.0, 1.0)

read -r -p "Press any key to continue (auto skip in 20s).." -t 20 -n 1 -s
printf "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

cat << EOF
# ===========================================================================
# STEP 4
# COPY CONFIGS INTO ~/.config
# ===========================================================================
EOF

sudo mv -f ./.config/* ~/.config/

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
# basic applications. Installed this way apps will be configured to work
# under wayland.
#
# ===========================================================================
EOF