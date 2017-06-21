This formula is not a backuppc server configuration tool.

You need a backuppc server already installed to use this salt state.


# How can I backup a new host ?

- Add correct content to the pillar text file:
/srv/pillar/machines/hosts.sls

Put the hostname of the machine and complete with ip address (last number), username to use for backups, directories to backup (RsyncShareName) and to exclude (BackupFilesExclude)

Syntax could be found [here (first mail)](https://groups.google.com/forum/#!topic/salt-users/aKbY6xnOW_w)

Example :

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

This formula expects a C class network, but you can modify it to allow full IP instead of the last number.


- Create a salt nodegroup 'backup' where you put your backuppc servers in it.
- Or create a salt grain called 'roles' and set it to ['backup'] where you put your backuppc servers in it.
eg
```
salt 'backuppcserver' grains.append roles backup
```


- Apply this formula:

```bash
# for a nodegroup
salt -N 'backup' state.sls backuppc.backuppc_add_client
# for a grain 'roles:backup'
salt -G 'roles:backup' state.sls backuppc.backuppc_add_client
```

This will deploy new backuppc clients config files and update /etc/hosts on backuppc servers (-N 'backup').


- For a new machine, apply also the ```backup_client``` state on the desired minion ID

```bash
salt '$minion' state.sls backuppc_client
```
