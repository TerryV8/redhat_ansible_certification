/home/student/ansible-optimize-cr/templates/index-ver1.html.j2:
<html>
<h1>
Welcome to {{ inventory_hostname }}
</h1>
</html>


The server needs to be pushed to one server at a time:
upgrade_webserver.yml:
- hosts: webservers
  remote_user: devops
  become: yes
  serial: 1
  
  tasks:
    - haproxy:
        state: disabled
        backend: app
        host: "{{ ansible_hostname }}"
        socket: /var/lib/haproxy/stats
        wait: yes
      delegate_to: "{{ item }}"
      with_items: "{{ groups["lbservers"] }}"
      
    - template:
        src: "templates/index.html.j2"
        dest: "/var/www/html/index.html"
      register: pageupgrade
      
Create a task in the .yml playbook to restart the web servers using an asynchrnous task that will not wait more than 1 second fo rthe task to complete
and that ensures tasks are not polled from completion.

Create a task in the .yml playbook to reboot the web server by adding a task to the playbook.
Use the command module to shut down the machine.
 
Execute the task if the earlier registered pageupgrade variables changes
 
    - name: restart
      shell: /bin/sleep 5 && shutdown -r now "Ansible updates triggered"
      async: 1
      poll: 0
      ignore_errors: yes
      when: pageupgrade.changed
      
 Delegate the task to localhost and use the wait_for
  
    - name: wait for webserver to reboot
      wait_for:
        host: "{{ inventory_hostname }}"
        port: 22
        state: started
        delay: 25
        timeout: 200
      delegate_to: localhost
      become: false
      when: pageupgrade.changed
      
    - wait_for:
        host: "{{ inventory_hostname }}"
        port: 80
        state: started
        timeout: 20
        
    - name: enable the server in haproxy
      haproxy:
        state: enabled
        backend: app
        host: "{{ inventory_hostname }}"
        socker: /var/lib/haproxy/stats
        wait: yes
      delegate_to: {{ item }}
      with_items: "{{ groups.lbservers  }}"
      
  
  
