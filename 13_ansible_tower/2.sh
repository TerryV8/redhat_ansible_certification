
ssh root@tower

wget http://.../ansible-tower-setup-bundle-3.tar.gz

tar xfz ansible-tower-setup-bundle-3.tar.gz

Edit inventory:
admin_password = 'redhat'
pg_password = 'redhat'
rabbitmq_password = 'redhat'

./setup.sh

exit


https://tower.lab.example.com

