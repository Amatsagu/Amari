#!/bin/bash

cat << EOF
# ===========================================================================
# SPOTIFY DELETION
# ===========================================================================
EOF

sudo apt purge --auto-remove spotify -y
sudo rm /usr/share/applications/spotify.desktop

printf "\n\n\n\n\n\n\n\n\n\n"

cat << EOF
# ===========================================================================
# FINISHED REMOVAL
# ===========================================================================
EOF