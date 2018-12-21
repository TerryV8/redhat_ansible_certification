- hosts: all
  vars:
    facts_file: facts/main.fact
    
  tasks:
    - include_vars: vars/main.yml
    - include: tasks/main.yml
    
        
# Custom facts
[packages]
db_package = mariadb-server
web_package = httpd


{{ ansible_local.custom.packages.web_package}}



- hosts: all
  var_files:
    - vars/users.yml

  tasks:
    uri:
      url: http://servera
      status_code: 200


Edit vars/users.yml:
user: joe
home: /home/joe
