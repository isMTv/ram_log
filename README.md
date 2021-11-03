# ram_log
Moves /var/log to tmpfs. Works with systemd.

* When creating a log template, a directory and file structure is created with all rights preserved, but at the same time, will not be copied the file data.
* The logs template will be created in /var/tmp/log.hdd after reboot or shutdown.
* After /var/log is mounted in tmpfs, the contents of log.the hdd will be copied to /var/log.

### How-to:
```
# bash install.sh
```

### A record will be created/etc/fstab:
Change the variable if necessary "size=64M".
```
# /var/log was on tmpfs
tmpfs /var/log tmpfs nosuid,noexec,noatime,nodev,mode=0755,size=64M
```

### Log size control:
To prevent the logs from growing.
```
@daily /home/shells/clear_logs.sh
```
