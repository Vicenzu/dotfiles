#!/bin/bash

echo
echo "------------------------------------------------"
echo "               INIZIO LA PULIZIA                "
echo "------------------------------------------------"
echo

echo
echo "------------------------------------------------"
echo "        AGGIORNO I PACCHETTI DI SISTEMA...      " 
echo "------------------------------------------------"
echo

sudo pacman -Syu

echo
echo "------------------------------------------------"
echo "           AGGIORNO I PACCHETTI AUR...          "
echo "------------------------------------------------"
echo

paru -Syu

echo
echo "------------------------------------------------"
echo " CONTROLLO SE CI SONO PACCHETTI NELLA CACHE...  "
echo "------------------------------------------------"
echo
numPkg=$(sudo ls /var/cache/pacman/pkg/ | wc -l)

if [ $numPkg -gt 0 ]; then 
  echo "$numPkg"
  echo "ECCO LO SPAZIO CHE OCCUPANO: $(du -sh /var/cache/pacman/pkg/)"
  echo "PROCEDO A LIBERARE LA CACHE"
  sudo paccache -r
else
  echo "NON CI SONO PACCHETTI NELLA CACHE"
fi

orp=$(sudo pacman -Qdtq | wc -l)

echo
echo "------------------------------------------------"
echo "    CONTROLLO SE CI SONO PACCHETTI ORFANI...    "
echo "------------------------------------------------"
echo
if [ $orp -gt 0 ]; then
  echo "ECCO I PACCHETTI ORFANI: $(sudo pacman -Qdtq)"
  echo "PROCEDO CON LA RIMOZIONE..."
  sudo pacman -Rns $(pacman -Qdtq)
else
  echo "NON CI SONO PACCHETTI ORFANI"
fi

unwanted=$(pacman -Qei | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h)
unwantedAUR=$(pacman -Qim | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h)
numUnwanted=$(echo "$unwanted" | wc -l)
numUnwantedAUR=$(echo "$unwantedAUR" | wc -l)


echo
echo "------------------------------------------------"
echo "CONTROLLO SE CI SONO UNWANTED PACKAGES E AURs..."
echo "------------------------------------------------"
echo
if [[ ($numunwanted -gt 0) || ($numunwantedAUR -gt 0) ]]; then
  echo "UNWATED PACKAGES: $unwanted"
  echo "UNWANTED AURs: $unwantedAUR"
  echo "PROCEDO CON LA RIMOZIONE"
  sudo pacman -Rns $(pacman -Qdtq)
  else
    echo "NON CI SONO UNWANTED PACKAGES"
fi

echo
echo "------------------------------------------------"
echo "           PULISCO LA CACHE DI /home...         "
echo "------------------------------------------------"
echo "SPAZIO OCCUPATO: $(sudo du -sh ~/.cache)"
echo "PROCEDO A LIBERARE LA CACHE /home"
rm -rf ~/.cache/*
         
echo
echo "------------------------------------------------"
echo "                PULIZIA FINITA                  "
echo "------------------------------------------------"

