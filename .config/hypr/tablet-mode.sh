#!/bin/bash

libinput debug-events --device /dev/input/event10 | while read -r line; do
    if echo "$line" | grep -q "KEY_TOUCHPAD_OFF (532) pressed"; then
        # Tablet mode ON
        notify-send "Tablet mode" ""
        iio-hyprland & 
    fi

    if echo "$line" | grep -q "KEY_TOUCHPAD_ON (531) pressed"; then
        # Laptop mode
        notify-send "Laptop mode" ""
        killall iio-hyprland
        # hyprctl --batch "keyword monitor eDP-1,1366x768@60,auto,0,transform,0; keyword input:touchdevice:transform 0; keyword input:tablet:transform 0" 
    fi
done
