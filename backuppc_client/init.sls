include:
    - backuppc_client.keys
{% if grains['os'] == 'Ubuntu' %}
    - backuppc_client.users
    - backuppc_client.packages
    - backuppc_client.files
    - backuppc_client.services
## otherwise backup with root
{% endif %}
