#!/usr/bin/env bash

# Vars;
SYS_DIR_LOG="/var/log/"
APPS_DIR_LOG=( /home/app1/www/logs/ /home/app2/www/logs/ /home/app3/www/cloud.open-networks.ru/logs/ )

# Only files;
echo "[Files - @cleared]"
find "$SYS_DIR_LOG" -type f \( ! -iname "*.1" ! -iname "*.gz" ! -iname "*.xz" ! -iname "*.journal" \) -exec cp /dev/null {} \; -exec echo " - {}" \;
echo "[Archives - @deleted]"
find "$SYS_DIR_LOG" -type f \( -iname "*.1" -o -iname "*.gz" -o -iname "*.xz" \) -exec rm -f {} \; -exec echo " - {}" \;

# Systemd journalctl;
echo "[Jurnalctl - @cleared]"
journalctl --vacuum-time=1s

# User root;
cp /dev/null /root/.bash_history

# User apps;
for APP_DIR_LOG in "${APPS_DIR_LOG[@]}"; do
    [ -d "$APP_DIR_LOG" ] || continue
    echo "[APP - @cleared]"
    find "$APP_DIR_LOG" -type f -iname "*.log" -exec cp /dev/null {} \; -exec echo " - {}" \;
done
