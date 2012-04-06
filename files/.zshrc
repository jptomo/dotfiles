#if [ $TERM != "screen.mlterm" ] && [ $TERM != "screen" ]; then
#    exec screen -S main -xRR -t zsh
#fi

# PROMPT
PS1="[@${HOST%%.*} %1~]%(!.#.$) " # この辺は好み
RPROMPT="%T" # 右側に時間を表示する
setopt transient_rprompt # 右側まで入力がきたら時間を消す
setopt prompt_subst # 便利なプロント
bindkey -v # viライクなキーバインド
bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history

export LANG=ja_JP.UTF-8 # 日本語環境
export EDITOR=vim # エディタはvim

autoload -U compinit # 強力な補完機能
compinit -u # このあたりを使わないとzsh使ってる意味なし
setopt autopushd # cdの履歴を表示
setopt pushd_ignore_dups # 同ディレクトリを履歴に追加しない
setopt auto_cd # 自動的にディレクトリ移動
setopt list_packed # リストを詰めて表示
setopt list_types # 補完一覧ファイル種別表示

# 履歴
HISTFILE=~/.zsh_history # historyファイル
HISTSIZE=10000 # ファイルサイズ
SAVEHIST=10000 # saveする量
setopt hist_ignore_dups # 重複を記録しない
setopt hist_reduce_blanks # スペース排除
setopt share_history # 履歴ファイルを共有
setopt EXTENDED_HISTORY # zshの開始終了を記録

# history 操作まわり
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# alias
alias ls="ls -G"
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

[ -f ~/.zsh.alias ] && source ~/.zsh.alias # 設定ファイルのinclude

#[ -f ~/.zshrc.mode ] && source ~/.zsh.mode # 設定ファイルのinclude

[ -f ~/.zsh.include ] && source ~/.zsh.include # 設定ファイルのinclude

