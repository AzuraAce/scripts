#!/usr/bin/env bash

wifi="$(nmcli r wifi | awk 'FNR = 2 {print $1}')"
msgTag="airplane"
if [ "$wifi" == "enabled" ] 
then
    nmcli r wifi off
    wifi="$(nmcli r wifi | awk 'FNR = 2 {print $1}')"
    # Show airplane mode notification
    dunstify -a "airplaneMode" -u low -i network-wireless-disconnected -h string:x-dunst-stack-tag:$msgTag "Wifi: $wifi" 
else
    nmcli r wifi on
    wifi="$(nmcli r wifi | awk 'FNR = 2 {print $1}')"
    # Show airplane mode notification
    dunstify -a "airplaneMode" -u low -i network-wireless-connected-100 -h string:x-dunst-stack-tag:$msgTag "Wifi: $wifi" 
fi
