check_ganglia_packages:
  pkg.installed:
    - pkgs:
{% if grains['os_family'] == 'Debian' %}
      - ganglia-monitor
      - ganglia-monitor-python
      - ganglia-modules-linux
      - libganglia1
{% else %}
      - ganglia-gmond
      - ganglia-monitor-core
      - ganglia-gmond-python
      - ganglia-devel
{% endif %}
