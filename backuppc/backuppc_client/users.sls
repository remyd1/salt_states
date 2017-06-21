backup_operator_user:
  user.present:
    - name: operator
    - remove_groups: False
