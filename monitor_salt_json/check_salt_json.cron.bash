#!/bin/bash

WWW_DIR="/var/www/html/exports"
SUBDIR=`date '+%Y%m'`
DATE=`date '+%Y%m%d'`

mkdir -p $WWW_DIR/$SUBDIR

/usr/bin/salt '*' state.sls check_services --out=json --static > $WWW_DIR/$SUBDIR/"$DATE"_services.json
/usr/bin/salt '*' test.ping --out=json --static > $WWW_DIR/$SUBDIR/"$DATE"_hosts_status.json
/usr/bin/salt '*' disk.percent  --out=json --static  > $WWW_DIR/$SUBDIR/"$DATE"_disks.json
