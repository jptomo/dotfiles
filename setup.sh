#!/usr/bin/env bash
# dotfile を $HOME にコピーする

# コピー対象のファイル一覧
DOT_FILES=( \
    gitconfig gitignore gitconfig.include\
    hgrc hgeol hgignore hgrc.include\
    zshrc zsh.alias \
    zsh_profile zsh.mode zsh.locale \
    tmux.conf inputrc vimrc gemrc \
    gvimrc bashrc bash.alias bash.locale \
)

# バックアップディレクトリの作成
printf "### 現在のファイルの"
echo   "バックアップディレクトリを作成します。"
CURDIR=$(cd $(dirname $0); pwd)
BAKDIR="backup/$(date +%Y%m%d%H%M%S)"
echo "mkdir -p \"$CURDIR/$BAKDIR\""
mkdir -p "$CURDIR/$BAKDIR"

# ファイルの移動
echo -e "\n### ファイルのコピー"
for file in "${DOT_FILES[@]}" ; do
    # ファイルチェック
    test "${file: -7}" = "include" ; INCLUDE_FLG=$?
    test -f "$HOME/.$file" ; EXIST_FLG=$?
    FLG_SUM=$(expr $INCLUDE_FLG + $EXIST_FLG)
    if [ $FLG_SUM -eq 0 ] ; then
        # ファイル名が include で終わり
        # かつ、そのファイルが $HOME に
        # 存在しない場合
        printf "指定された $file は \$HOME に"
        echo   "存在するため、コピーされませんでした。"
    else
        # その他の場合はファイルをコピーする
        mv "$HOME/.$file" "$CURDIR/$BAKDIR"
        ln -s "$CURDIR/dots/$file" "$HOME/.$file"
        echo "$file を \$HOME にコピーしました。"
    fi
done
