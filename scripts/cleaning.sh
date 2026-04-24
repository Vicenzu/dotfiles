#!/bin/bash

# =============================================================================
#  pulizia_sistema.sh — Arch Linux System Cleaner
# =============================================================================

# --- Colors & Styles ---------------------------------------------------------
RESET='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'

RED='\033[38;5;196m'
GREEN='\033[38;5;82m'
YELLOW='\033[38;5;220m'
BLUE='\033[38;5;75m'
CYAN='\033[38;5;51m'
MAGENTA='\033[38;5;213m'
WHITE='\033[38;5;255m'
GRAY='\033[38;5;245m'

# --- Icons -------------------------------------------------------------------
OK="${GREEN}${BOLD}  ✔${RESET}"
WARN="${YELLOW}${BOLD}  ⚠${RESET}"
INFO="${CYAN}${BOLD}  ➜${RESET}"
PKG="${MAGENTA}${BOLD}  ◈${RESET}"

# --- UI Functions ------------------------------------------------------------

print_banner() {
    clear
    echo
    echo -e "${CYAN}${BOLD}"
    echo "  ╔══════════════════════════════════════════════════╗"
    echo "  ║                                                  ║"
    echo "  ║      🧹  ARCH LINUX  —  SYSTEM CLEANER  🧹       ║"
    echo "  ║                                                  ║"
    echo "  ╚══════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    echo -e "  ${GRAY}${DIM}$(date '+%A, %d %B %Y — %H:%M')${RESET}"
    echo
}

print_header() {
    echo
    echo -e "  ${BLUE}${BOLD}┌──────────────────────────────────────────────────┐${RESET}"
    echo -e "  ${BLUE}${BOLD}│${RESET}  ${BOLD}${WHITE}$1${RESET}"
    echo -e "  ${BLUE}${BOLD}└──────────────────────────────────────────────────┘${RESET}"
    echo
}

print_footer() {
    echo
    echo -e "${GREEN}${BOLD}"
    echo "  ╔══════════════════════════════════════════════════╗"
    echo "  ║         ✅  CLEANUP COMPLETED SUCCESSFULLY       ║"
    echo "  ╚══════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    echo -e "  ${GRAY}${DIM}Free space on /: $(df -h / | awk 'NR==2{print $4}')${RESET}"
    echo
}

# =============================================================================
#  START
# =============================================================================

print_banner

# =============================================================================
#  1. SYSTEM UPDATE (PACMAN + AUR + FLATPAK)
# =============================================================================

print_header "UPDATING THE SYSTEM (pacman + AUR + flatpak)"

paru -Syu
flatpak update

# =============================================================================
#  2. PACMAN CACHE CLEANUP
# =============================================================================

print_header "CLEANING PACKAGE CACHE  (pacman)"

# Remove any leftover corrupted download files
sudo rm -rf /var/cache/pacman/pkg/download-* 2>/dev/null

numPkg=$(sudo ls /var/cache/pacman/pkg/ | wc -l)

if [ "$numPkg" -gt 0 ]; then
    echo -e "$INFO  Packages in cache:  ${BOLD}${WHITE}${numPkg}${RESET}"
    echo -e "$INFO  Space used:  ${BOLD}${YELLOW}$(sudo du -sh /var/cache/pacman/pkg/ | awk '{print $1}')${RESET}"
    echo
    echo -e "$INFO  Freeing cache..."
    # paccache -r keeps the last 3 versions of each package by default (safe).
    # Use -rk1 to keep only the currently installed version instead.
    sudo paccache -r
    sudo pacman -Sc --noconfirm   # remove uninstalled packages from cache
    echo
    echo -e "$OK  ${GREEN}Cache cleaned${RESET}"
else
    echo -e "$OK  ${GREEN}No packages in cache — nothing to do${RESET}"
fi

# =============================================================================
#  3. ORPHAN PACKAGES
# =============================================================================

print_header "CHECKING & REMOVING ORPHAN PACKAGES"

orp=$(sudo pacman -Qdtq)

if [ -n "$orp" ]; then
    echo -e "$WARN  ${YELLOW}Orphan packages found:${RESET}"
    echo
    echo "$orp" | while read -r pkg; do
        echo -e "      ${GRAY}·${RESET} ${pkg}"
    done
    echo
    echo -e "$INFO  Removing orphans..."
    sudo pacman -Rns $orp --noconfirm
    echo -e "$OK  ${GREEN}Orphan packages removed${RESET}"
else
    echo -e "$OK  ${GREEN}No orphan packages found${RESET}"
fi

# =============================================================================
#  4. USER CACHE CLEANUP (/home)
# =============================================================================

print_header "CLEANING USER CACHE  (~/.cache)"

echo -e "$INFO  Space used:  ${BOLD}${YELLOW}$(sudo du -sh ~/.cache | awk '{print $1}')${RESET}"
echo
echo -e "$INFO  Clearing cache..."
rm -rf ~/.cache/* 2>/dev/null || true
echo -e "$OK  ${GREEN}User cache cleared${RESET}"

# =============================================================================
#  5. LARGEST PACKAGES — INFO ONLY
# =============================================================================

print_header "TOP 10 HEAVIEST INSTALLED PACKAGES  (info only)"

# This section is informational only — nothing is removed automatically,
# as blindly removing large packages could break the system.
echo -e "$PKG  ${MAGENTA}${BOLD}The 10 heaviest installed packages:${RESET}"
echo
pacman -Qei \
    | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' \
    | sort -hr \
    | head -n 10 \
    | while read -r size name; do
        printf "      ${GRAY}%-12s${RESET}  %s\n" "$size" "$name"
    done

echo
echo -e "$WARN  ${YELLOW}No packages were removed in this section.${RESET}"

# =============================================================================
#  END
# =============================================================================

print_footer
