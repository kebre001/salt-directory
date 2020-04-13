{% for user in pillar.get('users', {})%}
Add user {{user}}:
  user.present:
    - name: {{user["name"]}}
    - fullname: {{user["fullname"]}}
    - password: {{user["password"]}}
{% endfor %}