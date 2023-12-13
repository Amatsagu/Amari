#!/bin/bash

cat << EOF
# ===========================================================================
# VISUAL STUDIO CODE INSTALLATION
# ===========================================================================
EOF

wget -O ~/VSCSetup.deb "https://go.microsoft.com/fwlink/?LinkID=760868"
sudo apt install ~/VSCSetup.deb -y
rm ~/VSCSetup.deb
sudo cp ./desktop/code.desktop /usr/share/applications/code.desktop
sudo rm /usr/share/applications/code-url-handler.desktop
xdg-mime default code.desktop text/plain

printf "\n\n\n\n\n\n\n\n\n\n"

cat << EOF
# ===========================================================================
# FINISHED INSTALLATION
# ===========================================================================
EOF