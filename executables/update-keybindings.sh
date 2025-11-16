#!/usr/bin/env bash
set -euo pipefail

BINDINGS_FILE="$HOME/.config/hypr/bindings.conf"

# Backup first
backup="${BINDINGS_FILE}.bak.$(date +%s)"
cp "$BINDINGS_FILE" "$backup"
echo "Backup created at: $backup"

# Append our overrides at the end
{
  echo ""
  echo "# --- Custom overrides (auto-added) ---"
  echo "unbind = SUPER, W"
  echo "unbind = SUPER, Q"
  echo "bindd = SUPER, Q, Close window, killactive"

  echo "unbind = SUPER, SHIFT, N"
  echo "unbind = SUPER, SHIFT, G"
  echo "unbind = SUPER, SHIFT, O"
  echo "unbind = SUPER, SHIFT, W"
  echo "unbind = SUPER, SHIFT, ALT, A"
  echo "unbind = SUPER, SHIFT, ALT, G"
  echo "unbind = SUPER, SHIFT, CTRL, G"
  echo "unbind = SUPER, SHIFT, P"

} >> "$BINDINGS_FILE"

echo "Updated $BINDINGS_FILE"
echo "Reload Hyprland with: hyprctl reload"
