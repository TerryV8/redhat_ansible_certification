In /etc/ansibke/ansible.cfg:
forks = 5







- hosts: appservers
  serial: 2

#!bin/bash
for i in {00..30}; do
  echo "run $i"
  sleep 1
done


- name: run longfiles script
  command: "/usr/local/bin/longfiles {{ item }} /tmp/{{ item }}.file"
  async: 3600
  poll: 0
  with_items:
    - foo
    - bar
    - baz
  register: script_sleeper
  
- name: check status
  async_status:
    jid: {{ item.ansible_job_id }}
  register: lock
  until: lock.finished
  retries: 30
  with_items: "{{ script_sleeper.results }}"
