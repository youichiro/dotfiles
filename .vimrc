"""Initial settings"""
" git clone https://github.com/w0ng/vim-hybrid.git ~/.vim/bundle/vim-hybrid.git
" ln -s ~/.vim/bundle/vim-hybrid.git/colors/hybrid.vim ~/.vim/colors/hybrid.vim
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

"""usage"""
" default
" `u` undo(戻す)
" `ctrl+r` redo(戻すを戻す)
" `gt` 次のタブに切り替える
" `ctrl+w 矢印` ペインの移動
" `ctrl+w ctrl+w` ペインの移動
" `:term` ターミナルを開く
"   `:bo term` 水平分割して最下部でターミナルを開く
"   `:vert term` 垂直分割してターミナルを開く
"   `:tab term` 新規タブでターミナルを開く
"     `ctrl+w gt`でタグを切り替える
" `:vs` 垂直方向に画面分割する
" `:sp` 水平方向に画面分割する

" expanded
" `ctrl+e` ファイルツリーを開く
"   `m`    ファイルの作成等
" `ctrl+p` ファイルを検索する
"   `ctrl+t` 新規タブでファイルを開く
"   `ctrl+v` 垂直分割してファイルを開く
"   `ctrl+s` 水平分割してファイルを開く

" custom
" `ctrl+t` :bo term

colorscheme hybrid

set shell=$SHELL
set number
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set backspace=indent,eol,start
set title
set ruler
set incsearch
set cursorline
set showmatch
set showcmd
set wrapscan
set hlsearch
set virtualedit=block
set wildmenu
set ignorecase
set guioptions+=R
set laststatus=2
set completeopt=menuone,noinsert
set noswapfile
set mouse=a
set clipboard+=unnamed
set splitbelow  " :termで最下部にターミナルを開く
set termwinsize=16x0  " ターミナルのサイズを指定
syntax enable

" Tab visualization
set list
set listchars=tab:..,trail:-,extends:>,precedes:<,nbsp:%
autocmd VimEnter,Colorscheme * highlight SpecialKey cterm=NONE ctermfg=244 ctermbg=NONE
hi SpecialKey guibg=NONE guifg=gray

" indent
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 shiftwidth=4
augroup END


"""vim-plug"""
" :PlugInstall 以下のプラグインをインストールする
call plug#begin('~/.vim/plugged')
" filetreeを表示(:NERDTree)
Plug 'scrooloose/nerdtree'
" タブでもfiletreeを表示
Plug 'jistr/vim-nerdtree-tabs'
" Ruby向けにendを自動挿入してくれる
Plug 'tpope/vim-endwise'
" コメントON/OFF(ctrl+-)
Plug 'tomtom/tcomment_vim'
" 行末の半角スペースを可視化
Plug 'bronson/vim-trailing-whitespace'
" vim-lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
" gitの差分を表示(:Gstatus)
Plug 'airblade/vim-gitgutter'
" git操作
Plug 'tpope/vim-fugitive'
" status-bar
Plug 'vim-airline/vim-airline'
" fzf(:FZF)
Plug 'junegunn/fzf'
" 補完
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" HTMLの閉じカッコ補完
Plug 'alvan/vim-closetag'
" JSハイライト
Plug 'othree/yajs.vim'
" 閉じカッコ補完
Plug 'mattn/vim-lexiv'
" スニペット
" ex) :Template readme-sharp, :Template web-echo
Plug 'mattn/vim-sonictemplate'
" 検索(ctrl+p)
Plug 'ctrlpvim/ctrlp.vim'
" vue
Plug 'posva/vim-vue'
call plug#end()


" 全角スペースの表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

" ctrl+eでNERDTreeを開く
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" ctrl+fで現在のファイルをNERDTreeでフォーカスする
nnoremap <silent><C-f> :NERDTreeFind<CR>

" 隠しファイルを表示する
let NERDTreeShowHidden = 1

" デフォルトでツリーを表示させる
let g:nerdtree_tabs_open_on_console_startup=1

" 他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ctrl+tでターミナルを開く
nnoremap <silent><C-t> :bo term<CR>

" jjでノーマルモードに切り替える
inoremap <silent> jj <ESC>

" タブの操作
" https://qiita.com/wadako111/items/755e753677dd72d8036d
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap [Tag] <Nop>
nmap t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

