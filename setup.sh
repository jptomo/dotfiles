#!/usr/bin/env bash

DOT_FILES=( .gitconfig .gitignore .hgrc .hgrc .hgeol .hgignore .zshrc .zsh.alias \
.zsh_profile .zsh.mode .tmux.conf .inputrc .vimrc .gemrc)
BAKDIR=backup/`date +%Y%m%d%H%M%S`

CURDIR=$(cd $(dirname $0); pwd)
mkdir -p ${CURDIR}/${BAKDIR}

for file in ${DOT_FILES[@]}
do
    mv ${HOME}/${file} ${CURDIR}/${BAKDIR} 
    ln -s ${CURDIR}/dots/${file} ${HOME}/${file}
done

