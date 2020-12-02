"" Initial settings
" git clone https://github.com/w0ng/vim-hybrid.git ~/.vim/bundle/vim-hybrid.git
" ln -s ~/.vim/bundle/vim-hybrid.git/colors/hybrid.vim ~/.vim/colors/hybrid.vim
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

set background=dark
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

"" 文字化け対策
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac
syntax enable

"" Tab visualization
set list
set listchars=tab:..,trail:-,extends:>,precedes:<,nbsp:%
autocmd VimEnter,Colorscheme * highlight SpecialKey cterm=NONE ctermfg=244 ctermbg=NONE
hi SpecialKey guibg=NONE guifg=gray

"" indent
augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 shiftwidth=4
augroup END

"" 全角スペースの表示
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


"" vim-plug
call plug#begin('~/.vim/plugged')

" filetreeを表示
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
Plug 'vim-airline/vim-airline-themes'
" 補完
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" HTMLの閉じカッコ補完
Plug 'alvan/vim-closetag'
" JSハイライト
Plug 'othree/yajs.vim'
" 閉じカッコ補完
Plug 'mattn/vim-lexiv'
" vue
Plug 'posva/vim-vue'
" markdown
Plug 'plasticboy/vim-markdown'
" markdown preview (:Minidownでブラウザが起動する)
Plug 'iwataka/minidown.vim'
" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()


"" キーマップ
" ハイライトを解除する
nnoremap <Esc><Esc> :noh<CR>
" ctrl+tでターミナルを開く
nnoremap <silent> <C-t> :bo term<CR>
" jjでノーマルモードに切り替える
inoremap <silent> jj <ESC>


"" NERDTree
" ctrl+nでNERDTreeを開く
nnoremap <silent><C-n> :NERDTreeToggle<CR>
" ctrl+cで現在のファイルをNERDTreeでフォーカスする
nnoremap <silent><C-c> :NERDTreeFind<CR>
" 隠しファイルを表示する
let NERDTreeShowHidden = 1
" デフォルトでツリーを表示させる
" let g:nerdtree_tabs_open_on_console_startup=1
" 他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"" タブの操作
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
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
nnoremap [Tag] <Nop>
nmap t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tc 新しいタブを一番右に作る
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>
" tn 次のタブ
map <silent> [Tag]n :tabnext<CR>
" tp 前のタブ
map <silent> [Tag]p :tabprevious<CR>


"" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0


"" vim-airline
" tab line有効化
let g:airline#extensions#tabline#enabled = 1
" ステータスバーに表示する項目
let g:airline#extensions#default#layout = [
	\ [ 'a', 'b', 'c' ],
	\ ['z']
	\ ]
let g:airline_section_z = get(g:, 'airline_linecolumn_prefix', '').'%3l:%-2v'
" （タブが一個の場合）バッファのリストをタブラインに表示する機能をオフ
let g:airline#extensions#tabline#show_buffers = 0
" 0でそのタブで開いてるウィンドウ数、1で左のタブから連番
let g:airline#extensions#tabline#tab_nr_type = 1
" テーマ
let g:airline_theme = 'hybrid'


"" fzf.vim
nnoremap fb :Buffers<CR>
nnoremap fl :BLines<CR>
nnoremap fm :Marks<CR>
nnoremap fh :History<CR>
nnoremap fc :Commits<CR>

" :Files
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfun
nnoremap <C-p> :call FzfOmniFiles()<CR>

" :Rg
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--exact --reverse --delimiter : --nth 3..'}, 'right:50%:hidden', '?'),
\ <bang>0)
nnoremap <C-g> :Rg<CR>


" :Ag ファイル名とマッチングさせない
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 3..'}, <bang>0)

