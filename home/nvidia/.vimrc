" Plugins {{{
call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
call plug#end()
" }}}

set number
autocmd FileType make set noexpandtab

" Spaces and Tabs {{{
set tabstop=2
set shiftwidth=2

" A combination of spaces anbd tabs are used to simulate tab stops
set softtabstop=2
set expandtab

" Show invisible characters
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
" }}}

" Line Wrap {{{
set wrap
set linebreak
set textwidth=0
set nolist
set wrapmargin=0
set autoindent
set breakindent
" }}}

" Look and Feel {{{
set lazyredraw

colorscheme gruvbox
set bg=dark
" }}}

" Key Mapping {{{

" Map ; to :
noremap ; :

" Map ctrl c to escape to fix multiple cursors issue
noremap <C-c> <Esc>

" Allows you to paste the same thing over and over
xnoremap p pgvy

" Cylces through splits using a double press of enter in normal mode
nnoremap <CR><CR> <C-w><C-w>
" Exits split with double press of \
nnoremap \\ <C-w>q

vnoremap H 0
nnoremap H I
nnoremap L A
vnoremap L $

" }}}

" Line Return {{{
" Returns you to your position on file reopen and closes all folds.
" On fold open your cursor is on the line you were at on the fold.
augroup line_return
  au!
  autocmd BufReadPost * :call LineReturn()
augroup END

function! LineReturn()
  if line("'\"") > 0 && line("'\"") <= line('$')
    execute 'normal! g`"zvzzzm'
  endif
endfunction

" }}}

