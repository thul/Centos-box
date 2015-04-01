#!/usr/bin/env bash
# This file is to install python and ansible for instances where the host OS is windows.
# cause windows can not run Ansible, we have to run ansible locally to provision ourselfs
echo === Adding EPEL ===
yum -y -q install epel-release

echo === Installing pip ===
yum install -q -y install python-pip

echo === Installing ansible and dependencies ===
yum install -q -y python-markupsafe python-paramiko
pip -q install ansible

echo === copying hosts file ===
cp -f /vagrant/hosts /home/vagrant/hosts
chmod 666 /home/vagrant/hosts

echo === running ansible ===
export PYTHONUNBUFFERED=1

ansible-playbook /vagrant/playbook.yml -i /home/vagrant/hosts --connection=local --limit 'vm'

echo === All done! ===
