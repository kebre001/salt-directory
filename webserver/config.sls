nginx configuration:
  file.managed:
    - name: /usr/local/etc/nginx/nginx.conf
    - source: salt://webserver/nginx.conf

nginx service:
  service.running:
    - name: nginx
    - enable: True

{% for file in pillar["websites"] %}
site_{{file}}:
  file.managed:
    - name: /usr/local/etc/nginx/sites-enabled/{{file}}
    - source: salt://webserver/sites/{{file}}
    - makedirs: True
{% endfor %}