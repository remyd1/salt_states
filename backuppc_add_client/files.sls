{% for host, hostinfo in salt['pillar.get']('machines', {}).iteritems() %}
 {% if hostinfo.has_key('RsyncShareName') %}
/etc/backuppc/{{ host }}.pl:
  file.managed:
    - source: salt://backuppc_add_client/template.pl
    - mode: 640
    - user: backuppc
    - group: www-data
    - backup: minion
    - template: jinja
    - context:
        hostinfo: {{ hostinfo }}

{{ host }}_etc_hosts:
  file.append:
    - name: /etc/hosts
    - text: "IP.IP.IP.{{ hostinfo['ip'] }}    {{ host }}"

{{ host }}_etc_backuppc_hosts:
  file.append:
    - name: /etc/backuppc/hosts
    - text: "{{ host }}    0    {{ hostinfo['user'] }}"


# here we add the known_hosts fingerprint, but we do not have it.
# so the backuppc server will need to querying the remote backuppc client
  {% if hostinfo.has_key('SaltHostname') %}
known_host__{{ grains['id']}}__{{ hostinfo['SaltHostname'] }}:
  module.run:
    - name: ssh.set_known_host
    - user: "backuppc"
    - hostname: "{{ host }}"
# encryption must be set to avoid fake duplicate (eg. : one ssh-rsa and one ecdsa) for one host in the known_hosts file
    - enc: ssh-rsa
  {% endif %}

 {% endif %}
{% endfor %}
