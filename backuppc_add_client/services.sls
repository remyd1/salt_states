backuppc_service:
  service.running:
    - name: backuppc
    - enable: True
    - reload: True
    - watch:
      - file: /etc/backuppc/hosts
