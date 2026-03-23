🛠️ Fix OMV: Errore "No Space Left" su Raspberry Pi
Questa guida serve a risolvere il blocco degli aggiornamenti quando la cache di APT (in RAM) si riempie, impedendo l'accesso ai file e il completamento dei processi di sistema.

1. Diagnosi Rapida
Se ricevi l'errore Write error - write (28: No space left on device) nonostante df -h mostri GB liberi, la cache è piena.

Controlla lo stato della cache:

Bash
df -h /var/cache/apt/archives
Se la dimensione è circa 200-400MB ed è piena, procedi al fix.

2. Procedura di Sblocco (Fix)
Esegui questi comandi in ordine per forzare il sistema a usare la MicroSD invece della RAM.

A. Pulizia e Smontaggio Cache
Bash
# 1. Svuota la cache attuale
sudo apt-get clean
sudo apt-get autoclean

# 2. Smonta le directory virtuali (per usare lo spazio della SD)
sudo umount -l /var/cache/apt/archives
sudo umount -l /var/lib/apt/lists
B. Riparazione Database Pacchetti
Bash
# 3. Sblocca processi interrotti
sudo dpkg --configure -a

# 4. Risolvi dipendenze corrotte
sudo apt-get install -f
C. Aggiornamento Incrementale
Non aggiornare tutto insieme per non saturare la CPU/RAM del Pi 3:

Bash
# 5. Aggiorna prima i core (OMV e Samba)
sudo apt-get update
sudo apt-get install --only-upgrade openmediavault samba

# 6. Completa l'aggiornamento totale
sudo apt-get dist-upgrade -y
3. Ripristino Servizi
Dopo l'aggiornamento, i dischi potrebbero non essere montati correttamente.

Riavvia il sistema: sudo reboot (Questo riattiva automaticamente la cache in RAM).

Forza il montaggio via SSH (se necessario):

Bash
sudo omv-salt deploy run fstab
Interfaccia Web OMV: * Vai in Storage > File Systems.

Clicca su Applica (barra gialla) se presente.

Se il disco è "Missing", usa il tasto Mount.

⚠️ Consigli per il Futuro
Alimentazione: Se senti "click" dall'HDD, usa sempre un Hub USB alimentato con un alimentatore di qualità (almeno 2A dedicato all'hub).

Debian Trixie: Essendo una versione "Testing", gli indici dei pacchetti sono più pesanti del normale. Esegui sudo apt-get clean regolarmente dopo ogni aggiornamento riuscito.
