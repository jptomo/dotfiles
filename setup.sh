#!/usr/bin/env bash

# 対象のファイル一覧
DOT_FILES=( \
  gitconfig gitignore \
  hgrc hgeol hgignore \
  zshrc zsh.alias \
  zsh_profile zsh.mode zsh.locale \
  tmux.conf inputrc vimrc gemrc \
  gvimrc bashrc bash.alias bash.locale \
)

# バックアップディレクトリの作成
CURDIR=$(cd $(dirname $0); pwd)
BAKDIR="backup/$(date +%Y%m%d%H%M%S)"
mkdir -p "$CURDIR/$BAKDIR"

# ファイルの移動
for file in "${DOT_FILES[@]}"; do
  mv "$HOME/.$file" "$CURDIR/$BAKDIR"
  ln -s "$CURDIR/dots/$file" "$HOME/.$file"
done
