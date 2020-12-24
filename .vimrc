""" Initial settings
"" download colorscheme vim-hybrid
" $ git clone https://github.com/w0ng/vim-hybrid.git ~/.vim/bundle/vim-hybrid.git
" $ ln -s ~/.vim/bundle/vim-hybrid.git/colors/hybrid.vim ~/.vim/colors/hybrid.vim
"" download colorscheme codedark
" $ git clone https://github.com/tomasiser/vim-code-dark.git ~/.vim/bundle/vim-code-dark.git
" $ ln -s ~/.vim/bundle/vim-code-dark.git/colors/codedark.vim ~/.vim/colors/codedark.vim

"" install vim-plug
" $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

"" install ripgrep
" $ brew install ripgrep

"" install Menlo Nerd Font
" download and install -> https://github.com/yumitsu/font-menlo-extra/blob/master/Menlo-Regular-Normal.ttf
" change terminal font

"" install ctag for tagbar
" $ brew install ctags

"" テーマ
" set background=dark
" colorscheme hybrid
colorscheme codedark

"" options
set shell=$SHELL
set number
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set backspace=indent,eol,start
" set title
" set ruler
set incsearch
set cursorline
set showmatch
set showcmd
set wrap
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
set updatetime=250 " 反映時間を短くする(デフォルトは4000ms)
set scrolloff=20  " スクロールしたときにこの数だけ行数を残す
set noshowmode
set pumheight=10 " 補完のポップアップメニューを10行までにする
set shortmess+=F " コマンドラインにファイル名を表示しない
syntax enable

" 文字化け対策
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac

" Tab visualization
set list
set listchars=tab:..,trail:-,extends:>,precedes:<,nbsp:%


"" autocmd
" pythonの場合はインデントを4に設定する
augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 shiftwidth=4
augroup END

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

" 最後のカーソル位置に移動する
augroup vimrcEx
  autocmd!
  autocmd BufRead * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END

" 自動コメントアウト無効
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END


"" 共通キーマップ
" iTerm2のキー設定を利用してShift+?を拾う
map π <S-CR>
map ˚ <S-Up>
map ∆ <S-Down>


"" キーマップ
" ハイライトを解除する
nnoremap <Esc><Esc> :noh<CR>
" ctrl+tでターミナルを開く
nnoremap <silent> <C-t> :bo term<CR>
" jjでノーマルモードに切り替える
inoremap <silent> jj <ESC>
" カーソル位置の単語をヤンク
nnoremap yw vawy
" タブ操作
nnoremap <Tab> :tabn<CR>
nnoremap <S-Tab> :tabp<CR>
nnoremap tn :tabn<CR>
nnoremap tp :tabp<CR>
nnoremap tc :tabnew<CR>
nnoremap tx :tabclose<CR>
" コピーしない
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
nnoremap s "_s
nnoremap c "_c
" 選択箇所をヤンクして削除
vnoremap yx ygvx
" 単語検索マップ
nnoremap <Space><Space> *N
" カーソル位置以降をヤンクする
nnoremap Y y$
" ウィンドウ分割
nnoremap <C-s><C-s> :split<CR>
nnoremap <C-s><C-v> :vsplit<CR><C-w>w
" 下に空行を挿入して移動
nnoremap <CR> o<ESC>
" 上に改行を挿入して移動
nnoremap <S-CR> O<ESC>

" ref: https://qiita.com/itmammoth/items/312246b4b7688875d023
" 行を移動
nnoremap <S-Up> "zdd<Up>"zP
nnoremap <S-Down> "zdd"zp
" 複数行を移動
vnoremap <S-Up> "zx<Up>"zP`[V`]
vnoremap <S-Down> "zx"zp`[V`]

" バッファが2つ以上ある場合はvimを終了しない
" fun! Quit()
"   if len(getbufinfo({'buflisted':1})) > 1
"     bd
"   else
"     q
"   endif
" endfun
" nnoremap :q :call Quit()

" buffer
nnoremap bp :bp<CR>
nnoremap bn :bn<CR>

" 行連結したときのスペースを削除する
nnoremap J Jx<C-Space>


"" ノーマルモードでのキーマップ
" jjでエスケープ
inoremap <silent> jj <ESC>
" 日本語入力で”っj”と入力してもEnterキーで確定させればインサートモードを抜ける
inoremap <silent> っj <ESC>


"" vim-plug
call plug#begin('~/.vim/plugged')

" Ruby向けにendを自動挿入してくれる
Plug 'tpope/vim-endwise'
" コメントON/OFF(ctrl+-)
Plug 'tomtom/tcomment_vim'
" 行末の半角スペースを可視化
Plug 'bronson/vim-trailing-whitespace'
" vim-lsp
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
" gitの差分を表示
Plug 'airblade/vim-gitgutter'
" git操作
Plug 'tpope/vim-fugitive'
" githubを開く
Plug 'tpope/vim-rhubarb'
" status-bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasiser/vim-code-dark'
" 補完
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" HTMLの閉じカッコ補完
Plug 'alvan/vim-closetag'
" 閉じカッコ補完
Plug 'mattn/vim-lexiv'
" vue
Plug 'posva/vim-vue'
" markdown syntax highlight
Plug 'tpope/vim-markdown'
" markdown preview (:PrevimOpenでブラウザが起動する)
Plug 'previm/previm'
Plug 'tyru/open-browser.vim'
" tableを簡単に書く(:TableModeToggle)
Plug 'dhruvasagar/vim-table-mode'
" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" windowのリサイズ (<C-q>でリサイズモード)
Plug 'simeji/winresizer'
" カーソル位置の単語をハイライト
Plug 'osyo-manga/vim-brightest'
" スクロールバー
" Plug 'obcat/vim-sclow'
" fern.vim
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'LumaKernel/fern-mapping-fzf.vim'
" fern.vimにアイコンをつける
" Plug 'ryanoasis/vim-devicons'
" Plug 'lambdalisue/nerdfont.vim'
" Plug 'lambdalisue/fern-renderer-nerdfont.vim'
" Plug 'lambdalisue/glyph-palette.vim'
" svelte
Plug 'evanleck/vim-svelte', {'branch': 'main'}
" エディタのみ表示する(:Goyo)
Plug 'junegunn/goyo.vim'
" インデントラインを表示する
Plug 'Yggdroot/indentLine'
" 関数をアウトラインで表示する
Plug 'majutsushi/tagbar'
" 日本語の単語単位で移動する
Plug 'deton/jasegment.vim'
" prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
"" React
" syntax highlight
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
" snippets
Plug 'cristianoliveira/vim-react-html-snippets'
Plug 'SirVer/ultisnips'

call plug#end()


"" fern.vim
" ファイルを開いていればタブで開き、そうでなければバッファで開く
fun! OpenFern()
  if empty(@%)
    :Fern . -reveal=% -opener=edit
  else
    :Fern . -reveal=% -opener=tabedit
  endif
endfun

" サイドバーで開く
nnoremap <C-n><C-m> :Fern . -reveal=% -drawer -toggle -width=40<CR>
" 新規タブで開く
nnoremap <C-n><C-n> :call OpenFern()<CR>
" 現在のバッファで開く
nnoremap <C-n><C-b> :Fern . -reveal=% -opener=edit<CR>
" " fern.vimにアイコンをつける
" let g:fern#renderer = "nerdfont"
" " fern.vimのアイコンに色をつける
" augroup my-glyph-palette
"   autocmd! *
"   autocmd FileType fern call glyph_palette#apply()
"   autocmd FileType nerdtree,startify call glyph_palette#apply()
" augroup END


"" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0


"" vim-airline
" テーマ
let g:airline_theme = 'hybrid'
" let g:airline_theme = 'codedark'
" tab line有効化
let g:airline#extensions#tabline#enabled = 1
" ステータスバーに表示する項目を変更する
let g:airline#extensions#default#layout = [
  \ [ 'a', 'b', 'c' ],
  \ ['z']
  \ ]
let g:airline_section_c = '%t %M'
let g:airline_section_z = get(g:, 'airline_linecolumn_prefix', '').'%3l:%-2v'
let g:airline#extensions#wordcount#enabled = 0 " word countを表示しない
" 変更がなければdiffの行数を表示しない
let g:airline#extensions#hunks#non_zero_only = 1
" powerlineを使う
let g:airline_powerline_fonts = 1
" タブラインの表示を変更する
" ref:https://www.reddit.com/r/vim/comments/crs61u/best_airline_settings/
let g:airline#extensions#tabline#fnamemod = ':t' " ファイル名のみタブに表示する
let g:airline#extensions#tabline#show_buffers = 1 " enable/disable displaying buffers with a single tab
let g:airline#extensions#tabline#show_splits = 0 "enable/disable displaying open splits per tab
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 0 " tab number
let g:airline#extensions#tabline#show_tab_type = 1  " bufferかtabかを表示する
let g:airline#extensions#tabline#close_symbol = '×'
let g:airline#extensions#tabline#show_close_button = 0


"" fzf.vim
nnoremap fb :Buffers<CR>
nnoremap fp :Buffers<CR><CR>
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
    :GFiles
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
  \, 'coc-svelte'
  \, 'coc-prettier'
  \ ]


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

"" git操作
" ref: https://wonderwall.hatenablog.com/entry/2016/03/26/211710
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
" ブラウザで該当のファイルを開く
nnoremap gb :Gbrowse<CR>
vnoremap gb :Gbrowse<CR>


"" vim-table-mode
" markdownの表にする
let g:table_mode_corner = '|'


"" previm
" GitHubプレビューの見た目にする
let g:previm_disable_default_css = 1
let g:previm_custom_css_path = '~/dotfiles/vim/previm/markdown.css'
" ヘッダーを表示しない
let g:previm_show_header = 0

"" tagbar
nnoremap tb :TagbarOpenAutoClose<CR>


"" indentLine
let g:indentLine_char = '│'


"" vim-closetag
let g:closetag_filenames = '*.html,*.erb,*.php,*.vue'

"" vim-jsx-pretty
let g:vim_jsx_pretty_colorful_config = 1

