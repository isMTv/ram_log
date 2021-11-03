#!/usr/bin/env bash

if err="$(journalctl --vacuum-time=1s 2>&1)"; then
    echo "[+] [@journalctl] - clearned."
else
    echo "[-] [@journalctl] - $err."
    unset err
fi

if err="$(cp ./shells/ramlog /usr/local/bin/ 2>&1)"; then
    echo "[+] [@app] - installed."
else
    echo "[-] [@app] - $err."
    unset err
fi

if err="$(chmod +x /usr/local/bin/ramlog 2>&1)"; then
    echo "[+] [@app rights] - set."
else
    echo "[-] [@app rights] - $err."
    unset err
fi

if err="$(cp ./shells/ramlog.service /etc/systemd/system/ 2>&1)"; then
    echo "[+] [@service] - installed."
else
    echo "[-] [@service] - $err."
    unset err
fi

if err="$(systemctl enable ramlog.service 2>&1)"; then
    ramlog reload
    echo "[+] [@template] - create."
else
    echo "[-] [@template] - $err."
    unset err
fi

if ! err="$(grep -q -E "# /var/log was on tmpfs" 2>&1 /etc/fstab)"; then
    echo -e "# /var/log was on tmpfs\ntmpfs /var/log tmpfs nosuid,noexec,noatime,nodev,mode=0755,size=64M" >> /etc/fstab
    echo "[+] [@fstab] - added."
else
    echo "[-] [@fstab] - not added."
    unset err
fi
