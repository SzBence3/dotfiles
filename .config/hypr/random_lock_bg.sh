#!/bin/bash
IMG_DIR="$HOME/Pictures/wallpaper"
IMG=$(find "$IMG_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' \) | shuf -n 1)
echo "$IMG" > /tmp/hyprlock_bg
