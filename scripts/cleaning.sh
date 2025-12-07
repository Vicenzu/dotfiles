#!/bin/bash

# Funzione per separatori estetici
print_header() {
    echo
    echo "------------------------------------------------"
    echo "    $1"
    echo "------------------------------------------------"
    echo
}

print_header "INIZIO LA PULIZIA DEL SISTEMA"

print_header "AGGIORNO IL SISTEMA (PACMAN & AUR)"

paru -Syu

print_header "PULIZIA CACHE PACCHETTI (PACMAN)"

numPkg=$(sudo ls /var/cache/pacman/pkg/ | wc -l)

if [ $numPkg -gt 0 ]; then 
  echo "$numPkg"
  echo "ECCO LO SPAZIO CHE OCCUPANO: $(du -sh /var/cache/pacman/pkg/)"
  echo "PROCEDO A LIBERARE LA CACHE"
  # paccache -r mantiene di default le ultime 3 versioni (sicurezza).
  # Se vuoi pulire TUTTO tranne l'ultima versione installata, usa -rk1
  sudo paccache -r
  sudo pacman -Sc --noconfirm   #rimuove i pacchetti non installati nella cache
else
  echo "NON CI SONO PACCHETTI NELLA CACHE"
fi


print_header "CONTROLLO E RIMOZIONE PACCHETTI ORFANI"
orp=$(sudo pacman -Qdtq)
if [ -n "$orp" ]; then
  echo "ECCO I PACCHETTI ORFANI: $orp"
  echo "PROCEDO CON LA RIMOZIONE..."
  sudo pacman -Rns $orp --noconfirm
else
  echo "NON CI SONO PACCHETTI ORFANI"
fi


print_header "PULIZIA CACHE UTENTE (/home)"
echo "SPAZIO OCCUPATO: $(sudo du -sh ~/.cache | awk '{print $1}')"
echo "PROCEDO A LIBERARE LA CACHE..."
# Il comando 'true' alla fine assicura che lo script non si fermi se rm dà errore
# 2> /dev/null nasconde i messaggi di errore "Directory not empty" o "Permission denied"
rm -rf ~/.cache/* 2>/dev/null || true
         
print_header "ANALISI PACCHETTI PIÙ GRANDI (SOLO INFO)"
# Questa sezione mostra solo i pacchetti pesanti, NON li rimuove automaticamente (sarebbe pericoloso)
echo "I 10 pacchetti più pesanti installati:"
pacman -Qei | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -hr | head -n 10

print_header "PULIZIA COMPLETATA"
