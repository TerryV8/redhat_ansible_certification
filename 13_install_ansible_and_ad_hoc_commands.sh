yum -y install ansible

Edit inventory:
[dev]
servera.lab.example.com
serverb.lab.example.com


Edit ansible.cfg:
[defaults]
inventory=inventory/hosts
remote_user=devops

[privilege_escalation]
become: yes


Ad hoc command:
ansible dev -m copy -a "content='Managed by Ansible\n' dest=/etc/motd" -b --user devops


ansible dev -m command -a "cat /etc/motd"

