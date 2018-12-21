ansible-playbook mailreply.yml --check

Ad hoc to check the smtp is configured int he firewall at servera
ansible servera -u devops -b -a "firewall-cmd --list-services"

telnet servera 25


# check mode as testing tool
- tasks:
  - shell: uname -a
    always_run: yes
  
  - uri:
      url: http://api.myapp.com
      return_content: yes
    register: apiresponse
    
  - fail:
      msg: 'version was not provided'
    when: "'version' not in apiresponse.content"

# Check free memory:
  - task:
      - stat:
          path: /var/run/app.lock
        register: lock
        
      - assert:
          that:
            - lock.stat.exists
            
# Check file us present:
ansible demohost -u devops -b -m yum -a 'name=httpd state=present'

# Currently available soace on the disks configured in the demohost managed hosts:
ansible demohost -a 'lsblk'

# Check free memory
ansible demohost -a 'free -a'
