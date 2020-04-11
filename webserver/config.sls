nginx configuration:
  file.managed:
    - name: /usr/local/etc/nginx/nginx.conf
    - source: salt://webserver/nginx.conf

{% for file in pillar["websites"] %}
site_{{file}}:
  file.managed:
    - name: /usr/local/etc/nginx/sites-enabled/{{file}}
    - source: salt://webserver/sites/{{file}}
{% endfor %}