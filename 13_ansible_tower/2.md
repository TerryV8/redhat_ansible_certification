
# Connect to tower server
ssh root@tower

wget http://.../ansible-tower-setup-bundle-3.tar.gz

tar xfz ansible-tower-setup-bundle-3.tar.gz

Edit inventory:
admin_password = 'redhat'
pg_password = 'redhat'
rabbitmq_password = 'redhat'

./setup.sh

exit

# Open a server
https://tower.lab.example.com
login/password : admin / redhat

Add the licence http://material.../Ansible-Tower-licence.txt

Put in /home/student/ansible-tower-cr
execute the playbook mkdemoproject.yml against tower.lab.example.com.
This installs a demo job template on the Tower server:
ansible-playbook mkdemoproject.yml

In the Tower web interface, identify the job template created during the Ansible Tower installation. Click TEMPLATES
You should see Demo Job Template.

ACTIONS column of the Demo Job template.

Successfukk


