ansible-galaxy init --offline -p roles/ encryptdisk

in ~/lab-ansible/roles/encrypteddisk/vars/main.yml
---
luks_name: crypto



ansible-playboo --ask-vault-pass encrypt.yml



user:
  name: "{{ item.name }}"
  password: "{{ item.pw | password_hash('sha256') }}"
  
with_items: "{{ newusers }}"



echo 'redhat' > vault-pass
chmod 0600 vault-pass

ansible-playbook --vault-password-file=vault-pass create_users.yml


