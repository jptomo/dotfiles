#! /bin/sh

# assert installed ansible
if [ ! "`rpm -qa | grep ansible`" ] ; then
    sudo dnf check-update
    sudo dnf upgrade -y
    sudo dnf install -y git ansible
    hash -r
fi

# run ansible-playbook
pushd ~/
    mkdir misc
    git clone https://github.com/jptomo/dotfiles.git misc/dotfiles
    ansible-playbook -i ~/misc/ansible/hosts ~/misc/ansible/playbook_setup.yml
popd
