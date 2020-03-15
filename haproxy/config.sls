haproxy.config:
 file.managed:
   - name: /usr/local/etc/haproxy.conf
   - source: salt://haproxy/haproxy.conf
   - template: jinja
   - user: root
   - group: root
   - mode: 644
   - require_in:
     - service: haproxy.service
   - watch_in:
     - service: haproxy.service