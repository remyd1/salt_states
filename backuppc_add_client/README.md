
# How can I backup a new host ?

- Add correct content to the pillar text file:
/srv/pillar/machines/hosts.sls

Put the hostname of the machine and complete with ip address (last number), username to use for backups, directories to backup (RsyncShareName) and to exclude (BackupFilesExclude)

Syntax could be found [here](https://groups.google.com/forum/#!topic/salt-users/aKbY6xnOW_w)


- Create a salt nodegroup where you put your backuppc servers.


- Apply this formula:

```bash
salt -N 'backup' state.sls backuppc_add_client
```
This will deploy new backuppc clients config files and update /etc/hosts on backuppc servers (-N 'backup').


- For a new machine, apply also the ```backup_client``` state on the desired minion ID

```bash
salt '$minion' state.sls backuppc_client
```

