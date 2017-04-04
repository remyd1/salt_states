# salt_states

The main idea here, is to have salt formulas to do:
 - [basic monitoring](monitor_salt_json/) using some states (ganglia, [check_services](check_services/)) and salt modules (built-in), 
 - [backup](backuppc_add_client/) some minions using salt states, salt custom modules and backuppc.

All you need are the states here and a pillar. _You just have to maintain one pillar file and refresh it on minions._

Here is a sample of the pillar file content:

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

The [monitor_salt_json](monitor_salt_json/) contains files to read json outputs and create a cron file (it is not real time monitoring, just reports). With this, you have a very brief information of your servers pools in a web page.
