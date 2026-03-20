#!/bin/bash

lock="󰌾  Lock"
sleep="󰒲  Sleep"
restart="󰑐  Restart"
shutdown="󰐥  Shutdown"
logout="󰍃  Logout"

chosen=$(echo -e "$lock\n$sleep\n$restart\n$shutdown\n$logout" | rofi -dmenu \
    -p "" \
    -no-fixed-num-lines \
    -theme ~/.config/rofi/theme.rasi \
    -theme-str '
      window { width: 220px; }
      listview { lines: 5; spacing: 0px; }
      inputbar { enabled: false; }
      element { padding: 8px 12px; }
    ')

case "$chosen" in
    "$lock")     hyprlock ;;
    "$sleep")    systemctl suspend ;;
    "$restart")  systemctl reboot ;;
    "$shutdown") systemctl poweroff ;;
    "$logout")   hyprctl dispatch exit ;;
esac
