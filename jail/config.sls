
/etc/jail.conf:
    file.blockreplace:
        - name: /etc/jail.conf
        - marker_start: "###START-JAIL-DO-NOT-EDIT###"
        - marker_start: "###END-JAIL###"
        - prepend_if_not_found: True
        - content: |
            exec.start = "/bin/sh /etc/rc";
            exec.stop = "/bin/sh /etc/rc.shutdown";
            exec.consolelog = "/jail/LOG/${name}_console.log";
            exec.clean;
            devfs_ruleset = "5";
            mount.devfs;

            path = "/jail/${name}/ROOT";
            $jailbase = "/jail";

{% for jail,attr in pillar.get('jails', []).items() -%}
/etc/jail.conf-{{jail}}:
    file.blockreplace:
        - name: /etc/jail.conf
        - source: salt://jail/jails.conf.j2
        - template: jinja
        - defauls: 
            name: jail
            jail: attr
        - marker_start: "#JAIL-{{jail|upper}}-DO-NOT-EDIT-"
        - marker_end: "#END-{{jail|upper}}#"
        - append_if_not_found: True
        - show_changes: True
{% endfor -%}