- tasks:
    command: ps
    register: remote_process
    changed_when: false
    delegate_to: localhost
    
    
    
# Delegating a task to a host does not exist in the inventoryL

- tasks:
    - add_host:
        name: demo
        ansible_host: 123.45.33.2
        ansible_user: devops
        
    - command: echo "hello from {{ inventory_hostname }}"
      delegate_to: demo
      delegate_facts: True
      
