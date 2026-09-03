#!/bin/bash
set -u
TARGET=""
for d in /PortMaster /opt/system/Tools/PortMaster /opt/tools/PortMaster /roms/ports/PortMaster /storage/roms/ports/PortMaster; do
  if [ -d "$d" ]; then TARGET="$d"; break; fi
done
[ -n "$TARGET" ] || { echo "ERROR: PortMaster directory not found."; exit 1; }
[ -f "$TARGET/.g350_last_backup" ] || { echo "ERROR: no G350 backup recorded."; exit 1; }
BACKUP="$(cat "$TARGET/.g350_last_backup")"
[ -d "$BACKUP" ] || { echo "ERROR: backup not found: $BACKUP"; exit 1; }
cp -p "$BACKUP/control.txt" "$TARGET/control.txt" || exit 1
cp -p "$BACKUP/gamecontrollerdb.txt" "$TARGET/gamecontrollerdb.txt" || exit 1
echo "Restored: $TARGET"
echo "Restart EmulationStation."
