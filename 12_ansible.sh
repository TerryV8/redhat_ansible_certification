- name: intranet service
  hosts: all
  become: yes
  become_user: root
  tasks:
    - yum:
        name: httpd
        state: latest
    - yum:
        name: firewalld
        state: latest
    - service:
        name: httpd
        enabled: true
        state: started
    - service:
        name: firewalld
        enabled: true
        state: started
    - firewalld:
        service: http
        permanent: true
        state: enabled
      notify:
        restart firewalld
    - file:
        path: /root/.ssh
        state: directory
        mode: 0700
    - copy:
        src: /root/.ssh/id_rsa
        dest: /root/.ssh/id_rsa
        mode: 0600
    
    handlers:
      - name: restart firewalld
        service: 
          name: firewalld
          state: restarted
        
      
