{% from slspath + "/map.jinja" import salt_settings with context %}

include:
  #{% if slspath.replace("/", ".") == "salt-formula.salt" %}
  - formula.salt.master
  #{% else %}
  #- {% slspath.replace("/", ".") + "." + "master" %}
  #{% endif %}

salt-api:
{% if salt_settings.install_packages %}
  pkg.installed:
    - name: {{ salt_settings.salt_api }}
{% endif %}
  service.running:
    - enable: True
    - name: {{ salt_settings.api_service }}
    - require:
      - service: {{ salt_settings.master_service }}
{% if salt_settings.install_packages %}
    - watch:
      - pkg: salt-api
{% endif %}
