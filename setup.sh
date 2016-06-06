#! /usr/bin/env bash
# dotfile を $HOME にコピーする

# コピー対象のファイル一覧
my_link_files=(bashrc bash_profile gemrc)
my_copy_files=(bashrc.local gitconfig hgrc vimrc gvimrc inputrc tmux.conf)

printf "### 現在のファイルの"
echo   "バックアップディレクトリを作成します。"
my_curdir=$(cd $(dirname $0); pwd)
my_bakdir="backup/$(date +%Y%m%d%H%M%S)"
echo "mkdir -p \"$my_curdir/$my_bakdir\""
mkdir -p "$my_curdir/$my_bakdir"

echo -e "\n### ファイルのリンク"
for file in "${my_link_files[@]}" ; do
    mv "$HOME/.$file" "$my_curdir/$my_bakdir"
    ln -s "$my_curdir/dots/$file" "$HOME/.$file"
    echo "$file を \$HOME にリンクしました。"
done

echo -e "\n### ファイルのコピー"
for file in "${my_copy_files[@]}" ; do
    test -f "$HOME/.$file" ; exist_flg=$?
    if [ $exist_flg -eq 0 ] ; then
        printf "指定された $file は \$HOME に"
        echo   "存在するため、コピーされませんでした。"
    else
        cp "$my_curdir/dots/$file" "$HOME/.$file"
        echo "$file を \$HOME にコピーしました。"
    fi
done
