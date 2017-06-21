/etc/cron.daily/passwd:
  file.managed:
    - source: salt://backuppc/backuppc_client/cron.daily.passwd
    - mode: 700
    - user: root
    - group: root

/etc/cron.daily/checkacl:
  file.managed:
    - source: salt://backuppc/backuppc_client/cron.daily.checkacl
    - mode: 700
    - user: root
    - group: root

## execute immediatly the previous code
run_rootdiracl:
  cmd.run:
    - name: /etc/cron.daily/checkacl

run_passwdbackup:
  cmd.run:
    - name: /etc/cron.daily/passwd
