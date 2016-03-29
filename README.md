# salt_states

The main idea here, is to have salt formulas to do [basic monitoring](monitor_salt_json/README.md) with some states (ganglia, [check_services](check_services/README.md)) and salt modules, and [backup](backuppc_add_client/README.md) some minions using states, pillar and backuppc. You just have to maintain a pillar file and refresh it on minions.

All you need are the states here and a pillar. The [monitor_salt_json](monitor_salt_json/README.md) contains files to read json outputs and create a cron file (it is not real time monitoring, just reports).

Pillar file content:

```
machines:
  www:
    ip: 26
    user: root
    RsyncShareName:
      - /var/www
      - /var/backups
      - /root
      - /etc
      - /var/lib/mysql
      - /var/log
      - /var/spool/cron
    BackupFilesExclude:
      - /root/.ssh
      - /etc/ssh
    SaltHostname: www.example.com
    services:
      - ssh
      - apache
      - mysql

```

