#!/bin/sh

# Session
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway
export XDG_CURRENT_SESSION=sway

sleep 1;

systemd-cat --identifier=sway sway $@