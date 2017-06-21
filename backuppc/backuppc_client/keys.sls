{% for host, hostinfo in salt['pillar.get']('machines', {}).iteritems() %}
 {% if hostinfo.has_key('RsyncShareName') %}
  {% if hostinfo.has_key('SaltHostname') %}
   {% if hostinfo['SaltHostname'] == grains['id'] %}

backuppc_serv1_key:
  ssh_auth.present:
    - user: {{ hostinfo['user'] }}
    - enc: ssh-rsa
    - names:
      - {{ salt['pillar.get']('backuppc_keys:serv1_key') }}

backuppc_serv2_key:
  ssh_auth.present:
    - user: {{ hostinfo['user'] }}
    - enc: ssh-rsa
    - names:
      - {{ salt['pillar.get']('backuppc_keys:serv2_key') }}

   {% endif %}
  {% endif %}
 {% endif %}
{% endfor %}
