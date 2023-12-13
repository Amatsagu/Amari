https://discord.com/api/download?platform=linux&format=deb

#!/bin/bash

cat << EOF
# ===========================================================================
# DISCORD INSTALLATION
# ===========================================================================
EOF

wget -O ~/DiscordSetup.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo apt install ~/DiscordSetup.deb -y
rm ~/DiscordSetup.deb
sudo cp ./desktop/discord.desktop /usr/share/applications/discord.desktop

printf "\n\n\n\n\n\n\n\n\n\n"

cat << EOF
# ===========================================================================
# FINISHED INSTALLATION
#
# Warning
# This script uses latest version of discord, outside Debian's apt stream
# - you'll have to run this script again to upgrade to each next major version.
# (Minor updates are applied without need of reinstalling)
#
# ===========================================================================
EOF