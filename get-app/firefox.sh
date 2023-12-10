#!/bin/bash

cat << EOF
# ===========================================================================
# FIREFOX INSTALLATION
# ===========================================================================
EOF

wget -O ~/FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64"
sudo tar xjf ~/FirefoxSetup.tar.bz2 -C /usr/share/
sudo ln -s /usr/share/firefox/firefox /usr/bin/firefox
rm ~/FirefoxSetup.tar.bz2
sudo cp ./desktop/firefox.desktop /usr/share/applications/firefox.desktop 

printf "\n\n\n\n\n\n\n\n\n\n"

cat << EOF
# ===========================================================================
# FINISHED INSTALLATION
# ===========================================================================
EOF