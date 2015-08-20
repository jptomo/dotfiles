#! /bin/sh

# assert installed ansible
if [ ! "`rpm -qa | grep ansible`" ] ; then
    sudo dnf check-update
    sudo dnf upgrade -y
    sudo dnf install -y ansible
fi

# run ansible-playbook
ansible-playbook -i /vagrant/misc/ansible/hosts /vagrant/misc/ansible/playbook.yml
