"""Initial settings"""
"git clone https://github.com/w0ng/vim-hybrid.git ~/.vim/bundle/vim-hybrid.git
"ln -s ~/.vim/bundle/vim-hybrid.git/colors/hybrid.vim ~/.vim/colors/hybrid.vim
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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
syntax enable

"esc2回押しでハイライト削除
nnoremap <ESC><ESC> :nohlsearch<CR><ESC>

"Tab visualization
set list
set listchars=tab:..,trail:-,extends:>,precedes:<,nbsp:%
autocmd VimEnter,Colorscheme * highlight SpecialKey cterm=NONE ctermfg=244 ctermbg=NONE
hi SpecialKey guibg=NONE guifg=gray

"indent
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 shiftwidth=4
augroup END


"""vim-plug"""
call plug#begin('~/.vim/plugged')
"filetreeを表示(:NERDTree)
Plug 'scrooloose/nerdtree'
let NERDTreeShowHidden = 1
"Ruby向けにendを自動挿入してくれる
Plug 'tpope/vim-endwise'
"コメントON/OFF(ctrl+-)
Plug 'tomtom/tcomment_vim'
"行末の半角スペースを可視化
Plug 'bronson/vim-trailing-whitespace'
"vim-lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
"gitの差分を表示(:Gstatus)
Plug 'airblade/vim-gitgutter'
"git操作
Plug 'tpope/vim-fugitive'
"status-bar
Plug 'vim-airline/vim-airline'
"fzf(:FZF)
Plug 'junegunn/fzf'
"補完
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"HTMLの閉じカッコ補完
Plug 'alvan/vim-closetag'
call plug#end()


"""全角スペースの表示"""
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

" HTMLの閉じカッコ補完
augroup HTMLANDXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

"ctrl+eでNERDTreeを開く
nnoremap <silent><C-e> :NERDTreeToggle<CR>

"括弧の補完
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><Esc><S-o><Tab>
inoremap ( ()<Esc>i
inoremap (<Enter> ()<Left><CR><Esc><S-o><Tab>
inoremap ' ''<Left>
inoremap " ""<Left>

