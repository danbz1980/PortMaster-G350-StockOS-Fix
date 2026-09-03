#!/bin/bash
set -u
BASE_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
TARGET=""
for d in /PortMaster /opt/system/Tools/PortMaster /opt/tools/PortMaster /roms/ports/PortMaster /storage/roms/ports/PortMaster; do
  if [ -d "$d" ]; then TARGET="$d"; break; fi
done
if [ -z "$TARGET" ]; then echo "ERROR: PortMaster directory not found."; exit 1; fi
for f in control.txt gamecontrollerdb.txt; do
  [ -f "$TARGET/$f" ] || { echo "ERROR: missing $TARGET/$f"; exit 1; }
done
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$TARGET/g350_backup_$STAMP"
mkdir -p "$BACKUP" || exit 1
cp -p "$TARGET/control.txt" "$BACKUP/control.txt" || exit 1
cp -p "$TARGET/gamecontrollerdb.txt" "$BACKUP/gamecontrollerdb.txt" || exit 1
printf '%s\n' "$BACKUP" > "$TARGET/.g350_last_backup"
cp -p "$BASE_DIR/control.txt" "$TARGET/control.txt" || exit 1
cp -p "$BASE_DIR/gamecontrollerdb.txt" "$TARGET/gamecontrollerdb.txt" || exit 1
if ! grep -q '1900c510010000000300000011010000' "$TARGET/control.txt" || ! grep -q '^1900c510010000000300000011010000,' "$TARGET/gamecontrollerdb.txt"; then
  echo "ERROR: verification failed; restoring backup."
  cp -p "$BACKUP/control.txt" "$TARGET/control.txt"
  cp -p "$BACKUP/gamecontrollerdb.txt" "$TARGET/gamecontrollerdb.txt"
  exit 1
fi
echo "G350 fix installed successfully in $TARGET"
echo "Backup: $BACKUP"
echo "Restart EmulationStation before testing."
