backuppc_user:
  user.present:
    - name: backuppc
    - remove_groups: False
