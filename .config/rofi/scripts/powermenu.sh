#!/bin/bash

# Options
lock="󰌾  Lock"
sleep="󰒲  Sleep"
restart="󰑐  Restart"
shutdown="󰐥  Shutdown"
logout="󰍃  Logout"

# Rofi menu
chosen=$(echo -e "$lock\n$sleep\n$restart\n$shutdown\n$logout" | rofi -dmenu \
    -display-drun "⏻  " \
    -p "⏻  " \
    -theme ~/.config/rofi/theme.rasi \
    -theme-str 'window { width: 220px; } listview { lines: 5; }')

# Actions
case "$chosen" in
    "$lock")     hyprlock ;;
    "$sleep")    systemctl suspend ;;
    "$restart")  systemctl reboot ;;
    "$shutdown") systemctl poweroff ;;
    "$logout")   hyprctl dispatch exit ;;
esac
