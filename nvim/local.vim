set encoding=utf-8
scriptencoding utf-8

" 新しい行のインデントを現在の行と同じインデントにする
set autoindent
" タブの代わりに空白文字を挿入する
set expandtab
" インクリメンタルサーチを行う
set incsearch
" 行番号を表示する
set number
" 対応する括弧を表示する
set showmatch
" 検索時に大文字を含んでいたら大文字/小文字を区別する
set smartcase
" マウスを有効にする
set mouse=a
" シフト移動幅
set shiftwidth=2
" タブの空白数
set tabstop=2

" 文字化け対策
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac

" 行番号のカラーを変更
highlight LineNr ctermfg=DarkGray

" タブ
nnoremap <Space>] :tabn<CR>
nnoremap <Space>[ :tabp<CR>
nnoremap <Space><Space> :tabnew<CR>

" コピーしない
nnoremap x "_
nnoremap d "_d
nnoremap D "_D
nnoremap s "_s
nnoremap c "_c
vnoremap x "_x
vnoremap d "_d
vnoremap D "_D
vnoremap s "_s
vnoremap c "_c

" ペイン切り替え
nnoremap <Tab> <C-w><C-w>

" 行頭に移動
nnoremap <S-h> 0
vnoremap <S-h> 0
" 行末に移動
nnoremap <S-l> $
vnoremap <S-l> $

" インデントを整える
nnoremap == mmggvG$=`mdm-

" 全選択
nnoremap ga ggvG$

" 複数行を移動
vnoremap <S-k> "zx<Up>"zP`[V`]
vnoremap <S-j> "zx"zp`[V`]

"" 背景透過
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none

" NeoTree
nnoremap ;E :NeoTreeFloat<CR>

