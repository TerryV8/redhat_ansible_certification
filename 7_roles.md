ansible-galaxy init -p roles --offline myapache



- hosts: all
  pre_tasks:
    - debug:
        msg: 'Beginning'

  roles: 
    - student.myenv
    
  post_tasks:
    - debug:
        msg: 'End'
    
    
ansible webservers -a 'curl -s http://localhost'

curl -S http://servera.lab.example.com

To bypass any ssl strict checking:
curl -k https://servera.lab.example.com


# in the roles/myvhosts/meta/main.yml:
dependencies:
  - { role: myfirewall, firewall_service: http }

