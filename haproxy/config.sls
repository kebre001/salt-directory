haproxy.conf:
 file.managed:
   - name: /usr/local/etc/haproxy.conf
   - source: salt://haproxy/haproxy.conf
   - template: jinja
   - user: root
   - group: wheel
   - mode: 644

{% for certificate, attr in pillar["certificates"].items() %}
{{certificate}}.pem:
 file.managed:
   - name: /usr/local/etc/haproxy/{{certificate}}.pem
   - contents:
      - {{attr["public_key"]}}
      - {{attr["private_key"]}}
   - makedirs: True
   - user: root
   - group: wheel
   - mode: 640
{% endfor %}