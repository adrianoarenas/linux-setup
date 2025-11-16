#!/usr/bin/env bash
set -euo pipefail

### ------------------------------------------------------------
### CONFIG – set your script names here
### ------------------------------------------------------------

INSTALL_SCRIPT="./install-packages.sh"
UNINSTALL_SCRIPT="./app-cleanup.sh"
BINDINGS_SCRIPT="./update-keybindings.sh"

### ------------------------------------------------------------
### LOG HELPERS
### ------------------------------------------------------------

info()  { printf "\033[1;34m[INFO]\033[0m %s\n" "$*"; }
warn()  { printf "\033[1;33m[WARN]\033[0m %s\n" "$*"; }
error() { printf "\033[1;31m[ERR ]\033[0m %s\n" "$*" >&2; }

run_step() {
  local name="$1"
  local script="$2"

  if [ -x "$script" ]; then
    info "Running: $name ($script)"
    "$script"
    info "Finished: $name"
  elif [ -f "$script" ]; then
    warn "Script $script exists but is not executable. Run: chmod +x $script"
  else
    warn "Script $script not found – skipping $name."
  fi
}

### ------------------------------------------------------------
### MAIN
### ------------------------------------------------------------

info "=== Omarchy bootstrap starting ==="

# 1. Uninstall unwanted packages first
run_step "Uninstall packages" "$UNINSTALL_SCRIPT"

# 2. Install / sync packages next
run_step "Install packages" "$INSTALL_SCRIPT"

# 3. Update Hypr/Omarchy bindings last
run_step "Update keybindings" "$BINDINGS_SCRIPT"

info "=== Bootstrap finished ✅ ==="packages
echo "If keybindings were changed, reload Hyprland with: hyprctl reload"
