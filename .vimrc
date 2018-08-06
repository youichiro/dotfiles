set background=dark
colorscheme hybrid

set number
set expandtab
set tabstop=4
set smartindent
set shiftwidth=4
set backspace=indent,eol,start
set title
set paste
set ruler
set incsearch
"set autoindent
syntax on


"Tab visualization
set list
set listchars=tab:..,trail:-,extends:>,precedes:<,nbsp:%
autocmd VimEnter,Colorscheme * highlight SpecialKey cterm=NONE ctermfg=244 ctermbg=NONE
hi SpecialKey guibg=NONE guifg=gray

"autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4


"NeoBundle Scripts-----------------------------
if &compatible
  set nocompatible
endif

" Required:
set runtimepath+=/home/ogawa/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('/home/ogawa/.vim/bundle'))

" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/vimproc.vim'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

NeoBundleCheck
"End NeoBundle Scripts-------------------------
