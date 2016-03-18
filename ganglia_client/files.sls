{% if 'roles' in grains %}

{% set itsroles = salt['grains.get']('roles', []) %}

{% set sourcename = "" %}

{% if 'big' in itsroles %}
  {% set gangliaclient = "big" %}
  {% set sourcename = "salt://ganglia_client/gmond.conf.ucast.tmpl" %}
{% elif 'nasgroup1' in itsroles %}
  {% set gangliaclient = "nas" %}
  {% set sourcename = "salt://ganglia_client/gmond.conf.mcast.cl1.tmpl" %}

#getiface__{{ grains['id'] }}:
#  module.run:
#    - name: customnetwork.ifacestartswith
#    - m_name: customnetwork.py
#    - opts: "10.1"
#    - returner

{% elif 'nasgroup2' in itsroles %}
  {% set gangliaclient = "nas" %}
  {% set sourcename = "salt://ganglia_client/gmond.conf.mcast.cl2.tmpl" %}


{% endif %}

{% if gangliaclient %}

/etc/ganglia/gmond.conf:
  file.managed:
    - name: /etc/ganglia/gmond.conf
    - source: {{ sourcename }}
    - mode: 644
    - user: root
    - group: root


{% if gangliaclient == "nas" %}
## enable nfsstat
enab_nfsstat:
  file.rename:
    - source: /etc/ganglia/conf.d/nfsstats.pyconf.disabled
    - name: /etc/ganglia/conf.d/nfsstats.pyconf


replace_mcast_if:
  file.blockreplace:
    - name: /etc/ganglia/gmond.conf
    - marker_start: "/* START managed zone */"
    - marker_end: "/* END managed zone */"
    - content: "    mcast_if = {{ salt['customnetwork.ifacestartswith']('10.1')[0] }}"
    - backup: '.bak'
    - show_changes: True


{% endif %}

{% endif %}


{% endif %}
