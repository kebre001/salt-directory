{% for user in pillar.get('users', {})%}
Add user {{user["name"]}}:
  user.present:
    - name: {{user["name"]}}
    - fullname: {{user["fullname"]}}
    - password: {{user["password"]}}
{% endfor %}