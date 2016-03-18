{% if grains['os_family'] == 'RedHat' %}
 {% set name = 'gmond' %}
{% elif grains['os_family'] == 'Debian' %}
 {% set name = 'ganglia-monitor' %}
{% endif %}


gmond_service:
  service.running:
    - name: {{ name }}
    - enable: True
    - reload: True
    - watch:
      - file: /etc/ganglia/gmond.conf
