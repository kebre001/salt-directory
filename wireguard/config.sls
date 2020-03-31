{% for interface in pillar["wireguard"]["interfaces"] %}
wireguard_{{interface.name}}_config:
 file.managed:
   - name: /usr/local/etc/wireguard/{{interface.name}}.conf
   - source: salt://wireguard/template.j2
   - template: jinja
   - defaults:
      interface: {{interface}}
   - user: root
   - group: wheel
   - mode: 640
{% endfor %}