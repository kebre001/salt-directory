nginx configuration:
  file.managed:
    - name: /usr/local/etc/nginx/nginx.conf
    - source: salt://webserver/nginx.conf

nginx service:
  service.running:
    - name: nginx
    - enable: True

php configuration:
  file.managed:
    - name: /usr/local/etc/php/99-custom.ini
    - content: |
        display_errors=Off
        safe_mode=Off
        safe_mode_exec_dir=
        safe_mode_allowed_env_vars=PHP_
        expose_php=Off
        log_errors=On
        error_log=/var/log/nginx/php.scripts.log
        register_globals=Off
        cgi.force_redirect=0
        file_uploads=On
        allow_url_fopen=On
        sql.safe_mode=Off
        disable_functions=show_source, system, shell_exec, passthru, proc_nice, exec, popen
        max_execution_time=60
        memory_limit=128M
        upload_max_filesize=16M
        post_max_size=16M
        cgi.fix_pathinfo=0
        sendmail_path=/usr/sbin/sendmail -fwebmaster@localhost -t

php-fpm configuration:
  file.managed:
    - name: /usr/local/etc/php-fpm.d/www.conf
    - source: salt://webserver/www.conf
    - makedirs: True

php service:
  service.running:
    - name: php-fpm
    - enable: True

{% for file in pillar["websites"] %}
site_{{file}}:
  file.managed:
    - name: /usr/local/etc/nginx/sites-enabled/{{file}}
    - source: salt://webserver/sites/{{file}}
    - makedirs: True
{% endfor %}