#!/bin/bash

if [ "$1" -gt 100 ]; then
  echo "Valore troppo alto"
  exit 1
elif [ "$1" -le 20 ]; then
  echo "Valore troppo basso"
  exit 2
fi


curr=$(cat /sys/class/power_supply/BAT1/charge_control_end_threshold)
if [ "$1" -ne "$curr" ]; then
	sudo asusctl battery limit $1;
	carica=$(cat /sys/class/power_supply/BAT1/charge_control_end_threshold);
	echo "La carica è impostata al $carica%";
else
	echo "La carica è già impostata al $1%"
fi
