#!/bin/bash
if [ "$1" -ne "$(cat /sys/class/power_supply/BAT1/charge_control_end_threshold)" ]; then
	sudo asusctl -c $1;
	carica=$(cat /sys/class/power_supply/BAT1/charge_control_end_threshold);
	echo "La carica è impostata al $carica%";
else
	echo "La carica è già impostata al $1%"
fi
