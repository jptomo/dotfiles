"---------------------------------------------------
" neobundle.vim
"---------------------------------------------------
set nocompatible
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'The-NERD-tree'
NeoBundle 'The-NERD-Commenter'
NeoBundle 'nvie/vim-flake8'
NeoBundle 'hallettj/jslint.vim'

filetype plugin indent on

"---------------------------------------------------
" 文字コードの自動認識
"---------------------------------------------------
set encoding=utf-8
scriptencoding utf-8
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  let &fileencodings = 'utf-8,' . &fileencodings
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" SWP BAK ファイル
"set backupdir=$VIM\_vim\backups
set noswapfile
"set directory=$VIM\_vim\swaps
set nobackup

" バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin ファイルを開くと発動します）
augroup BinaryXXD
    autocmd!
    autocmd BufReadPre  *.bin let &binary =1
    autocmd BufReadPost * if &binary | silent %!xxd -g 1
    autocmd BufReadPost * set ft=xxd | endif
    autocmd BufWritePre * if &binary | %!xxd -r | endif
    autocmd BufWritePost * if &binary | silent %!xxd -g 1
    autocmd BufWritePost * set nomod | endif
augroup END

" 検索関係
set incsearch    " インクリメンタルサーチ
set nowrapscan   " ラップしない
set ignorecase   " 大文字小文字無視
set smartcase    " 大文字で始めたら大文字小文字を区別する
set hlsearch     " 検索文字をハイライト表示

"表示関係
set number       " 行番号表示
set title        " ウィンドウのタイトルを書き換える

" カレントウィンドウのみカーソル行をハイライト
set cursorline   " カーソル行を強調表示

"カーソル下の文字コード
"http://vimwiki.net/?tips%2F98
function! Getb()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return String2Dec(c)
endfunction
function! GetB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return String2Hex(c)
endfunction
" :help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! Nr2Hex(nr)
  let n = a:nr
  let r = ""
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
func! String2Hex(str)
  let out = ''
  let ix = 0
  while ix < strlen(a:str)
    let out = out . Nr2Hex(char2nr(a:str[ix]))
    let ix = ix + 1
  endwhile
  return out
endfunc
func! String2Dec(str)
  let out = ''
  let ix = 0
  while ix < strlen(a:str)
    if ix == 1
      let out = out . ','
    endif
    let out = out . printf('%3d', char2nr(a:str[ix]))
    let ix = ix + 1
  endwhile
  return out
endfunc

" ステータスライン関係
set laststatus=2 " ステータスラインを常に表示
"set statusline=%y=[%{&fileencoding}][\%{&fileformat}]\ %F%m%r%=<%c:%l>
" ファイルパス [filetype][fenc][ff]    桁(ASCII=10進数,HEX=16進数) 行/全体(位置)[修正フラグ]
set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v(ASCII=%{Getb()},HEX=%{GetB()})\ %l/%L(%P)%m

" ファイルタイプ関係
syntax on           " シンタックスハイライト
filetype indent on " ファイルタイプによるインデントを行う
filetype plugin on  " ファイルタイプによるプラグインを使う

" 編集中のファイルのあるディレクトリに移動
au BufEnter * exec ':lcd %:p:h'

nmap <silent> <C-O> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore=['\.svn', '\.pyc']

autocmd FileType python call SettingForPython()
autocmd FileType ruby call SettingForRuby()
autocmd FileType sh call SettingForPython()
autocmd FileType ini call SettingForPython()
autocmd FileType cfg call SettingForPython()
autocmd FileType html call SettingForHTML()
autocmd FileType js call SettingForHTML()
autocmd FileType css call SettingForHTML()
autocmd FileType rst call SettingForRST()

function SettingForPython()
    " PEP 8 Indent rule
    " Folding
    setl foldmethod=indent
    setl foldlevel=99
    " indent
    setl tabstop=4
    setl softtabstop=4
    setl shiftwidth=4
    setl smarttab
    setl expandtab
    setl autoindent
    setl nosmartindent
    setl cindent
    setl textwidth=80
    setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
    setl enc=utf-8
    autocmd BufWritePre * :%s/\s\+$//ge
endfunction

function SettingForRuby()
    " Folding
    setl foldmethod=indent
    setl foldlevel=99
    " indent
    setl tabstop=2
    setl softtabstop=2
    setl shiftwidth=2
    setl smarttab
    setl expandtab
    setl autoindent
    setl nosmartindent
    setl cindent
    setl textwidth=80
    setl enc=utf-8
    autocmd BufWritePre * :%s/\s\+$//ge
endfunction

function SettingForHTML()
    setl autoindent
    setl tabstop=2
    setl softtabstop=2
    setl shiftwidth=2
    setl smarttab
    setl expandtab
    setl autoindent
    setl nosmartindent
    setl encoding=utf-8
    setl fileencoding=utf-8
    setl fileformat=unix
endfunction

function SettingForRST()
    setl autoindent
    setl tabstop=3 expandtab shiftwidth=3 softtabstop=3
    setl encoding=utf-8
    setl fileencoding=utf-8
    setl fileformat=unix
endfunction

let g:flake8_ignore='E501'

"let path = expand('%:p:h')
"python <<EOM
"import vim, sys
"sys.path.append(vim.eval('path'))
"sys.path.append('/home/nakamura/.vim/python')

"import pytest # この.vimファイルと同じディレクトリにpytest.pyを置いておく
"EOM
"python pytest.func()

nnoremap <space> za
vnoremap <space> zf

let g:neocomplcache_enable_at_startup = 1

autocmd FileType * setlocal formatoptions-=ro

hi comment gui=none ctermfg=lightblue

"---------------------------------------------------
" for Unite
"---------------------------------------------------

" 入力モードで開始する
"let g:unite_enable_start_insert=1
" バッファ一覧
"noremap <C-P> :Unite buffer<CR>
" ファイル一覧
"noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
"noremap <C-Z> :Unite file_mru<CR>
" ウィンドウを分割して開く
"au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
"au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
"au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
"au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
"au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
"au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" 初期設定関数を起動する
"au FileType unite call s:unite_my_settings()
"function! s:unite_my_settings()
  " Overwrite settings.
"endfunction
" 様々なショートカット
"call unite#set_substitute_pattern('file', '\$\w\+', '\=eval(submatch(0))', 200)
"call unite#set_substitute_pattern('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/"', 2)
"call unite#set_substitute_pattern('file', '^@', '\=getcwd()."/*"', 1)
"call unite#set_substitute_pattern('file', '^;r', '\=$VIMRUNTIME."/"')
"call unite#set_substitute_pattern('file', '^\~', escape($HOME, '\'), -2)
"call unite#set_substitute_pattern('file', '\\\@<! ', '\\ ', -20)
"call unite#set_substitute_pattern('file', '\\ \@!', '/', -30)
"if has('win32') || has('win64')
"  call unite#set_substitute_pattern('file', '^;p', 'C:/Program Files/')
"  call unite#set_substitute_pattern('file', '^;v', '~/vimfiles/')
"else
"  call unite#set_substitute_pattern('file', '^;v', '~/.vim/')
"endif

" ファイル一覧
"noremap <C-U><C-F> :UniteWithBufferDir -buffer-name=files file<CR>
