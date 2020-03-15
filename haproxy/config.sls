haproxy config:
 file.managed:
   - name: /usr/local/etc/haproxy.conf
   - source: salt://haproxy/haproxy.conf
   - template: jinja
   - user: root
   - group: wheel
   - mode: 644