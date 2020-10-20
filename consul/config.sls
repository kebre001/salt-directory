{% set config_path = "/usr/local/etc/consul.d/" %}
consul_server_config:
    file.managed:
        - name: {{config_path}}server.hcl
        - mode: 600
        - source: {{ slspath }}/server.hcl.j2
