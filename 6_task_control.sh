when: 
  - inventory_hostname in groups['webservers']
  - "(ansible_memory_mb.real.total) > (memory)"




- shell:
    rpm -q http
  register: rpm_check
  failed_when: rpm_check != 0
  

- stat:
    path: /etc/httpd/conf.d/ssl.conf
  register: ssl_file
  
  shell:
    mv /a /b
  when ssl_file.stat.exists
  
  
  - unarchive:
      src: /a
      dest: /b
      copy: no
      
    
    

- tasks:
    - block:
        - include: install_packages.yml
          vars:
            memory: 256
        
      rescue:
        - yum:
            name: httpd
            state: latest
          notify: 
            - restart_services
            
   handlers:
     - name: restart_services
       service:
         name: httpd
         state: restarted
  
    
