#!/bin/bash
# filepath: ~/notify_volume_brightness.sh

case "$1" in
  volume)
    # Get current volume (using pamixer, fallback to amixer)
    if command -v pamixer >/dev/null 2>&1; then
      VOL=$(pamixer --get-volume)
    else
      VOL=$(amixer get Master | grep -oP '\[\d+%\]' | head -1 | tr -d '[]%')
    fi
    dunstify -r 9842 -h int:value:$VOL "Volume: "
    ;;
  brightness)
    # Get current brightness (using brightnessctl)
    if command -v brightnessctl >/dev/null 2>&1; then
      BRIGHT=$(brightnessctl get)
      MAX=$(brightnessctl max)
      PERCENT=$((BRIGHT * 100 / MAX))
      dunstify -r 7832 -h int:value:$PERCENT "Brightness: "
    else
      dunstify "brightnessctl not found"
    fi
    ;;
  *)
    echo "Usage: $0 {volume|brightness}"
    exit 1
    ;;
esac
