""" Initial settings
"" install vim-hybrid
" $ git clone https://github.com/w0ng/vim-hybrid.git ~/.vim/bundle/vim-hybrid.git
" $ ln -s ~/.vim/bundle/vim-hybrid.git/colors/hybrid.vim ~/.vim/colors/hybrid.vim

"" install vim-plug
" $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

"" install ripgrep
" $ brew install ripgrep

"" install nerd-fonts
" $ brew tap homebrew/cask-fonts
" $ brew cask install font-hack-nerd-font
" change terminal font

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
set smartcase
set guioptions+=R
set laststatus=2
set completeopt=menuone,noinsert
set noswapfile
set mouse=a
set clipboard+=unnamed
set splitbelow  " :termで最下部にターミナルを開く
set termwinsize=16x0  " ターミナルのサイズを指定
set showtabline=2 " 常にタブラインを表示
syntax enable

"" 文字化け対策
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac
syntax enable

"" Tab visualization
set list
set listchars=tab:..,trail:-,extends:>,precedes:<,nbsp:%

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

"" コメントアウト行後の改行時にコメントアウトを入れない
autocmd FileType * setlocal formatoptions-=ro


" 前回終了したカーソル行に移動
autocmd bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif


"" vim-plug
call plug#begin('~/.vim/plugged')

"" NERDTree
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
" windowのリサイズ (<C-e>でリサイズモード, hjklでリサイズ)
Plug 'simeji/winresizer'
" ddでコピーしない、mmでコピーする
Plug 'svermeulen/vim-easyclip'
" カーソル位置の単語をハイライト
Plug 'osyo-manga/vim-brightest'
" スクロールバー
Plug 'obcat/vim-sclow'
" fern.vim
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
" fern.vimにアイコンをつける
Plug 'ryanoasis/vim-devicons'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
" fernツリーでff,fd,faで検索できる
Plug 'LumaKernel/fern-mapping-fzf.vim'

call plug#end()


"" キーマップ
" ハイライトを解除する
nnoremap <Esc><Esc> :noh<CR>
" ctrl+tでターミナルを開く
nnoremap <silent> <C-t> :bo term<CR>
" jjでノーマルモードに切り替える
inoremap <silent> jj <ESC>
" 空行を挿入
nnoremap <CR> o<ESC>zz
" カーソル位置の単語をヤンク
nnoremap yw vawy
" タブ操作
nnoremap tp :tabp<CR>
nnoremap tn :tabn<CR>
nnoremap tc :tabnew<CR>
nnoremap tx :tabclose<CR>
" :wのマップ
nnoremap <C-s> <Esc>:w<CR>


"" fern.vim
" サイドバーでファイラーを開く
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=50<CR>
" fern.vimにアイコンをつける
let g:fern#renderer = "nerdfont"
" fern.vimのアイコンに色をつける
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END


"" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0


"" vim-airline
" テーマ
let g:airline_theme = 'hybrid'
" tab line有効化
let g:airline#extensions#tabline#enabled = 1
" (タブが一個の場合) バッファのリストをタブラインに表示する機能をオフ
let g:airline#extensions#tabline#show_buffers = 0
" 0でそのタブで開いてるウィンドウ数、1で左のタブから連番
let g:airline#extensions#tabline#tab_nr_type = 1
" ステータスバーに表示する項目
let g:airline#extensions#default#layout = [
	\ [ 'a', 'b', 'c' ],
	\ ['z']
	\ ]
let g:airline_section_z = get(g:, 'airline_linecolumn_prefix', '').'%3l:%-2v'
" ファイル名のみタブに表示する
let g:airline#extensions#tabline#fnamemod = ':t'


"" fzf.vim
nnoremap fb :Buffers<CR>
nnoremap fl :BLines<CR>
nnoremap fm :Marks<CR>
nnoremap fh :History<CR>
nnoremap fp :History<CR><CR>
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
\ : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'right:50%:hidden', '?'),
\ <bang>0)
nnoremap <C-g> :Rg<CR>

" :Ag ファイル名とマッチングさせない
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 3..'}, <bang>0)

" カーソル位置の単語をRgでファイル検索
nnoremap fr vawy:Rg <C-R>"<CR>
" visualモードで選択した単語をRgでファイル検索
xnoremap fr y:Rg <C-R>"<CR>


"" coc.nvim 以下のextentionが無ければインストールする
let g:coc_global_extensions = [
  \  'coc-lists'
  \, 'coc-json'
  \, 'coc-marketplace'
  \, 'coc-html'
  \, 'coc-css'
  \, 'coc-tsserver'
  \, 'coc-solargraph'
  \, 'coc-python'
  \, 'coc-snippets'
  \, 'coc-vetur'
  \ ]


" vimでファイルを開いたときに、tmuxのwindow名にファイル名を表示
if exists('$TMUX') && !exists('$NORENAME')
  au BufEnter * if empty(&buftype) | call system('tmux rename-window ""'.expand('%:t:S')) | endif
  au VimLeave * call system('tmux set-window automatic-rename on')
endif


"" カーソル位置の単語をアンダーラインでハイライトする
let g:brightest#highlight = {
  \ "group" : "BrightestUnderline"
  \}


"" ウィンドサイズを変更するモード
let g:winresizer_start_key = '<C-q>'


"" coc-nvim
" ref: https://wonderwall.hatenablog.com/entry/2019/08/17/003000
" 定義にジャンプ
nmap <silent> gd <Plug>(coc-definition)
" 参照一覧を表示
nmap <silent> gr <Plug>(coc-references)

