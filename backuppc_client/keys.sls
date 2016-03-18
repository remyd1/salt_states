backuppc_serv1_key:
  ssh_auth.present:
{% if grains['os'] == 'Ubuntu' %}
    - user: operator
{% else %}
    - user: root
{% endif %}
    - enc: ssh-dsa
    - names:
      - {{ salt['pillar.get']('backuppc_keys:serv1_key') }}

backuppc_serv2_key:
  ssh_auth.present:
{% if grains['os'] == 'Ubuntu' %}
    - user: operator
{% else %}
    - user: root
{% endif %}
    - enc: ssh-dsa
    - names:
      - {{ salt['pillar.get']('backuppc_keys:serv2_key') }}

#known_host__{{ grains['id']}}:
#  ssh_known_hosts.present:
#    - name: "{{ salt['network.ip_addrs']('cidr="192.168.1.0/24"')[0] }}"
#    - user: backuppc
#    - enc: ssh-rsa
#    - key: "{{ salt['ssh.host_keys']('/etc/ssh')['rsa.pub'].split()[1] }}"
