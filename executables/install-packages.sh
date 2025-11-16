#!/usr/bin/env bash
set -euo pipefail

### -------------------------
### LOG HELPERS
### -------------------------

info()  { printf "\033[1;34m[INFO]\033[0m %s\n" "$*"; }
warn()  { printf "\033[1;33m[WARN]\033[0m %s\n" "$*"; }
error() { printf "\033[1;31m[ERR ]\033[0m %s\n" "$*" >&2; }

have() {
  command -v "$1" >/dev/null 2>&1
}

### -------------------------
### PACKAGE LISTS – EDIT THESE
### -------------------------

# pacman -Ss <name> -> to see if it's a pacman package
# Packages from official Arch repos (installed with pacman)
PACMAN_PACKAGES_INSTALL=(
  git
  stow
  code
  pycharm-community-edition
  intellij-idea-community-edition
  rawtherapee
)

# yay -Ss <name> -> to see if it's an AUR package
# Packages from the AUR (installed with yay)
AUR_PACKAGES_INSTALL=(
  google-chrome
)

### -------------------------
### CHECKS
### -------------------------

if ! have pacman; then
  error "pacman not found – this script is for Arch / Arch-based systems."
  exit 1
fi

if ! have yay && ((${#AUR_PACKAGES_INSTALL[@]} > 0)); then
  warn "yay not found, but AUR_PACKAGES_INSTALL is not empty."
  warn "Install yay (or comment out AUR_PACKAGES_INSTALL) and run again if you need AUR packages."
fi

### -------------------------
### INSTALL PACMAN PACKAGES
### -------------------------

if ((${#PACMAN_PACKAGES_INSTALL[@]} > 0)); then
  info "Installing pacman packages: ${PACMAN_PACKAGES_INSTALL[*]}"
  sudo pacman -Syu --needed --noconfirm "${PACMAN_PACKAGES_INSTALL[@]}"
else
  info "No pacman packages configured to install."
fi

### -------------------------
### INSTALL AUR PACKAGES (yay)
### -------------------------

if ((${#AUR_PACKAGES_INSTALL[@]} > 0)); then
  if have yay; then
    info "Installing AUR packages via yay: ${AUR_PACKAGES_INSTALL[*]}"
    yay -S --needed --noconfirm "${AUR_PACKAGES_INSTALL[@]}"
  else
    warn "Skipping AUR packages because yay is not installed."
  fi
else
  info "No AUR packages configured to install."
fi

info "Done ✅"
