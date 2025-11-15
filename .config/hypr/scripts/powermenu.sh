#!/usr/bin/env bash

dir="~/dotfiles/.config/hypr/themes"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -no-config -theme $dir/powermenu.rasi"

# Options
shutdown=" Shutdown"
reboot=" Restart"
lock=" Lock"
suspend=" Sleep"
logout=" Logout"

# Variable passed to rofi
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
    
	$shutdown)
		systemctl poweroff
        ;;

    $reboot)
		systemctl reboot
		;;

	$lock)
		hyprlock
		;;

	$suspend)
		mpc -q pause
		amixer set Master mute
		systemctl suspend
		;;

    $logout)
		loginctl terminate-session $XDG_SESSION_ID
        ;;
esac
