{% if grains['os_family'] == 'RedHat' %}
 {% set name = 'crond' %}
{% elif grains['os_family'] == 'Debian' %}
 {% set name = 'cron' %}
{% endif %}

cron_service_acl:
  service.running:
    - name: {{ name }}
    - enable: True
# reload does not exist anymore on systemd for cron. Let's do a restart instead.
#    - reload: True
    - watch:
      - file: /etc/cron.daily/checkacl
