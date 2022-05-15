" don't copy
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

" split window

" move
nnoremap <S-h> ^
vnoremap <S-h> ^
nnoremap <S-l> $
vnoremap <S-l> $

" format indent
nnoremap == mmggvG$=`m

" backspace
nnoremap <Backspace> i<Backspace>

" select all
nnoremap ga ggvG$

" disable lowercase and uppercase
vnoremap u <nop>
vnoremap U <nop>
