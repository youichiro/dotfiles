" [Initial settings]
" * download colorscheme vim-hybrid
" $ git clone https://github.com/w0ng/vim-hybrid.git ~/.vim/bundle/vim-hybrid.git
" $ ln -s ~/.vim/bundle/vim-hybrid.git/colors/hybrid.vim ~/.vim/colors/hybrid.vim

" * download colorscheme codedark
" $ git clone https://github.com/tomasiser/vim-code-dark.git ~/.vim/bundle/vim-code-dark.git
" $ ln -s ~/.vim/bundle/vim-code-dark.git/colors/codedark.vim ~/.vim/colors/codedark.vim

" * install vim-plug
" $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" * brew install
" $ brew install ripgrep
" $ brew install bat


" カラースキーマ
syntax enable
set background=dark
colorscheme codedark

" 新しい行のインデントを現在の行と同じインデントにする
set autoindent

" vi互換を切る
set nocompatible

" マウスを有効にする
set mouse=a

" マウスのホイールを有効にする
set ttymouse=xterm2

" タブの代わりに空白文字を挿入する
set expandtab
set smarttab

" タブの空白数
set tabstop=2

" シフト移動幅
set shiftwidth=2

" インクリメンタルサーチを行う
set incsearch

" 対応する括弧を表示する
set showmatch

" 検索時に大文字を含んでいたら大文字/小文字を区別する
set smartcase
set ignorecase

" 検索結果をハイライトする
set hlsearch

" 検索時に大文字小文字を区別しない
set ignorecase

" tabでファイル名補完を有効にする
set wildmenu

" backspaceでdeleteする
set backspace=indent,eol,start

" swapファイルを作らない
set noswapfile

" クリップボードからペーストできるようにする
set clipboard+=unnamed

" 文字化け対策
set encoding=utf-8
" set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
" set fileformats=unix,dos,mac

" 補完表示時の挙動
set completeopt=menuone,noinsert

" :termで最下部にターミナルを開く
set splitbelow

" tabを可視化する
set list
set listchars=tab:..,trail:-,extends:>,precedes:<,nbsp:%

" 自動保存
set autowrite


" netrw
filetype plugin indent on
let g:netrw_liststyle=3
let g:netrw_banner=0


" [キーマップ]
" ハイライトを解除する
nnoremap <Esc><Esc> :noh<CR>
" タブ
nnoremap <Space>] :tabn<CR>
nnoremap <Space>[ :tabp<CR>
nnoremap <Space><Space> :tabnew<CR>:b #<CR>
" コピーしない
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
nnoremap s "_s
nnoremap c "_c
vnoremap x "_x
vnoremap d "_d
vnoremap D "_D
vnoremap s "_s
vnoremap c "_c
" カーソル位置の単語をヤンク
nnoremap yw vawy
" 選択箇所をヤンクして削除
vnoremap yx ygvx
" 単語を検索したら現在位置の単語から表示する
nnoremap * *N
" カーソル位置以降をヤンクする
nnoremap Y y$
" ウィンドウ分割
nnoremap <C-s><C-s> :split<CR>:set laststatus=2<CR>
nnoremap <C-s><C-v> :vsplit<CR><C-w>w:set laststatus=2<CR>
" 下に空行を挿入して移動
nnoremap <CR> o<ESC>
" 上に改行を挿入して移動
nnoremap <S-CR> O<ESC>
" buffer
nnoremap bp :bp<CR>
nnoremap bn :bn<CR>
" ウィンドウ切り替え
nnoremap <Tab> <C-w><C-w>
nnoremap <S-Tab> <C-w>W
" 行頭に移動
nnoremap <S-h> 0
vnoremap <S-h> 0
" 行末に移動
nnoremap <S-l> $
vnoremap <S-l> $
" インデントを整える
nnoremap == mmggvG$=`m
" バックスペースで削除
nnoremap <Backspace> i<Backspace>
" 単語を置換する
nnoremap # *:%s/<C-r>///g<Left><Left>
" 再読み込み
nnoremap <S-r> :e!<CR>
" 全選択
nnoremap ga ggvG$
" ctrl+tでターミナルを開く
nnoremap <silent> <C-t> :bo term<CR>
" lowercase, uppercaseを無効化
vnoremap u <nop>
vnoremap U <nop>
" 複数行を移動
vnoremap <S-k> "zx<Up>"zP`[V`]
vnoremap <S-j> "zx"zp`[V`]


" 自動コメントアウト無効
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

" 最後のカーソル位置に移動する
augroup vimrcEx
    autocmd!
      autocmd BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END


" 自作コマンド
" jsonフォーマットするコマンド
function! JsonFormat()
  set filetype=json
  :%!jq '.'
endfunction
command Json :call JsonFormat()

" 開いているファイルのパスを確認するコマンド
function! Pwd()
    :echo expand("%:p")
endfunction
command Pwd :call Pwd()


" 背景透過
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none


" [vim-plug]
call plug#begin()
" 行末の半角スペースを可視化
Plug 'bronson/vim-trailing-whitespace'
" 補完
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" windowのリサイズ (<C-q>でリサイズモード)
Plug 'simeji/winresizer'
" コメントON/OFF(ctrl+-)
Plug 'tomtom/tcomment_vim'
" svelte
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
" ファイラー
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
" スクロールをヌルヌルさせる
Plug 'yuttie/comfortable-motion.vim'
" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" gitの差分を表示
Plug 'airblade/vim-gitgutter'
" カーソル位置の単語をハイライト
Plug 'osyo-manga/vim-brightest'
call plug#end()


" simeji/winresizer
" ウィンドサイズを変更するモード
let g:winresizer_start_key = '<C-q>'


" coc.nvim
" 以下のextentionが無ければインストールする
let g:coc_global_extensions = [
      \  'coc-lists'
      \, 'coc-json'
      \, 'coc-html'
      \, 'coc-css'
      \, 'coc-tsserver'
      \, 'coc-svelte'
      \, 'coc-prettier'
      \, '@yaegassy/coc-tailwindcss3'
      \, 'coc-jedi'
      \ ]
" 定義にジャンプ
nmap <silent> gd <Plug>(coc-definition)
" 参照一覧を表示
nmap <silent> gr <Plug>(coc-references)
" 型定義
nmap <silent> gt <Plug>(coc-type-definition)
" ホバーでinfo(hint, ヒント)を表示
nmap <silent> gi :call CocAction('doHover')<CR>


" tcomment_vim
vnoremap <Space>- :TComment<CR>
nnoremap <Space>- :TComment<CR>


" fern.vim
" サイドバーで開く/閉じる
nnoremap <C-n><C-b> :Fern . -reveal=% -drawer -toggle -width=40<CR>
" サイドバーで開く
nnoremap <C-n><C-m> :Fern . -reveal=% -drawer -width=40<CR>
" 現在のバッファで開く
nnoremap <C-n><C-n> :Fern . -reveal=% -opener=edit<CR>
" 隠れファイルを表示する
let g:fern#default_hidden=1


" comfortable-motion
let g:comfortable_motion_interval = 2400.0 / 60
let g:comfortable_motion_friction = 100.0
let g:comfortable_motion_air_drag = 3.0


" fzf.vim
nnoremap fb :Buffers<CR>
nnoremap ls :Buffers<CR>
nnoremap fh :History<CR>
nnoremap fl :BLines<CR>
nnoremap fc :Commits<CR>

" search file by filename
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GFiles
  endif
endfun
nnoremap <C-p> :call FzfOmniFiles()<CR>

" search file by word
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}, 'up:60%')
  \ : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'right:50%:hidden', '?'),
  \ <bang>0)
nnoremap <C-g> :Rg<CR>


" vim-gitgutter
" 前の変更箇所へ移動
nnoremap g[ :GitGutterPrevHunk<CR>
" 次の変更箇所へ移動
nnoremap g] :GitGutterNextHunk<CR>
" diffをハイライトする
nnoremap gh :GitGutterLineHighlightsToggle<CR>
" カーソル行のdiffを表示
nnoremap gp :GitGutterPreviewHunk<CR>
" 記号の色を変更
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=blue
highlight GitGutterDelete ctermfg=red

" vim-brightest
" カーソル位置の単語をアンダーラインでハイライトする
let g:brightest#highlight = {"group" : "BrightestUnderline"}

