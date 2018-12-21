ansible-galaxy -p roles --offlines ansible-vsftpd

Edit roles/ansible-vsftpd/*.yml:
- yum:
    name: '{{ vsftpd_packages }}'
    state: installed
    
- service:
    name: '{{ item }}'
    state: started
    enabled: true
  with_items: '{{ vsftpd_service }}'
  
- template:
    src: vsftpd.conf.j2
    dest: '{{vsftpd_config_file }}'
    owner: root
    group: root
    mode: '0600'
    setype: etc_c
  notify: restartt vsftpd
  
-  name: open ftp port in firewall
   firewalld:
     service: ftp
     permanent: true
     immediate: yes
     state: enabled
     
Modify the contents of the meta/main.yml:
author: Red hat training
description: role for D0477
licence: BSD


Modify the contents of README.md:
ansible-vsftpd
==============

Example ansible-vsftpd role from Red hat's

Requirement
-----------

None.

Role variables
--------------

* defaults/main.yml contains variables used to configure the vsftpd.conf template
* var/main.yml contains the name of the vsftpd service, the name of RPM package, and the location of the service's configuration file

Dependencies
------------

Example Playbook
----------------
 - hosts: servers
   roles:
     - ansible-vsftpd
    
Licence
-------

BSD

Author information
------------------
Red hat



Edit vsftpd-configure.yml:
- hosts: ftpservers
  become: true
  vars:
    anon_root: /mnt/share/
    local_root: /mnt/share/
  roles:
    - ansible-vsftpd
    
  tasks:
    - command: creates=/dev/vd1 parted --script /dev/vdb mklabel gpt mkpart primary 1MiB 100%
    
    - filesystem:
        dev: /dev/vdb1
        fstype: xfs
        force: no
    
    - file:
        path: '{{ vsftpd_anon_root }}'
        state: directory
        
    - mount:
        name: '{{ vsftpd_anon_root }}'
        src: /dev/vdb1
        fstype: xfs
        state: mounted
        dump: '1'
        passno: '2'
      notify: restart vsftpd
      
    - file:
        path: '{{ ]vsftpd_anon_root }}'
        owner: root
        group: root
        mode: '0755'
        setype: "{{ vsftpd_setype}}"
        state: directory
        
    - copy:
        dest: '{{ vsftpd_ano_root }}/README'
        content: "welcome to the FTP  {{ ansible_fqdn }}"
        setype: '{{ vsftpd_setype}}'
      
This playbook site.yml should include the plays from the other 2 playbooks by containing exaactly 2 lines:      
        
    - include: ftpclient.yml
    - include: vsftpd-configure.yml
    
        
        
