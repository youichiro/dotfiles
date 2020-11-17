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
let NERDTreeShowHidden = 1
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

" ctrl+tでターミナルを開く
nnoremap <silent><C-t> :bo term<CR>

