# salt_states

The main idea here, is to have salt formulas to do basic monitoring with some states (ganglia, check_states) and salt modules, and backup some minions using states, pillar and backuppc.

All you need are the states here. The monitor_salt_json contains files to read json outputs and create a cron file (it is not real time monitoring, just reports).

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

