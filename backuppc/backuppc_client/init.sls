include:
    - backuppc.backuppc_client.keys
{% if grains['os_family'] == 'Debian' %}
    - backuppc.backuppc_client.users
    - backuppc.backuppc_client.packages
    - backuppc.backuppc_client.files
    - backuppc.backuppc_client.services
## otherwise backup with root
{% endif %}
