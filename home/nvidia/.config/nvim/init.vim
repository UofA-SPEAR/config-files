" Mark's init.vim
scriptencoding utf-8
set encoding=utf-8

" Leader
let g:mapleader = "\<space>"

" Plugins {{{

" Auto install plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config//nvim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    augroup PLUG
        au!
        autocmd VimEnter * PlugInstall
    augroup END
endif

call plug#begin('~/.config/nvim/plugged')

" Writing plugins
Plug 'mzlogin/vim-markdown-toc'

" Async Linting
Plug 'w0rp/ale'
    let g:ale_lint_on_save = 1
    let g:ale_lint_on_text_changed = 0
    let g:ale_lint_on_enter = 0
    let g:ale_linters_sh_shellcheck_exclusions = 'SC1090,SC2155'
    nmap <silent> <C-n> <Plug>(ale_next_wrap)
    nmap <silent> <C-N> <Plug>(ale_previous_wrap)

" Clicking v expands region
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-line'
Plug 'terryma/vim-expand-region'
	vmap v <Plug>(expand_region_expand)
	vmap <C-v> <Plug>(expand_region_shrink)<Paste>

" Insert brackets on enter.
Plug 'rstacruz/vim-closer'

" Filetype Plugins
Plug 'boeckmann/vim-freepascal'
Plug 'alfredodeza/khuno.vim'

" Show yanked region
 Plug 'machakann/vim-highlightedyank'
     let g:highlightedyank_highlight_duration = 200

" Code completion for C/C++
Plug 'zchee/deoplete-clang'

" Show results as you type
" Delete highlight after search
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'
      let g:oblique#incsearch_highlight_all = 1
      let g:oblique#clear_highlight = 1
      let g:oblique#prefix = "\\v"

" gcc to comment lines
Plug 'tpope/vim-commentary'
" repeat 'ANY' command with .
Plug 'tpope/vim-repeat'

" Async Linting
Plug 'w0rp/ale'
  let g:ale_lint_on_save = 1
  let g:ale_lint_on_text_change = 0
  let g:ale_lint_on_enter = 0
  let g:ale_linters = {
        \ 'cpp': ['cpplint', 'clang']
        \}

Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': '/install --all'}
Plug 'junegunn/fzf.vim'
	nmap <C-x> :FZF %:p:h<CR>
" gruvbox colorscheme
Plug 'morhetz/gruvbox'

call plug#end()

" }}}

" Filetypes {{{

 filetype plugin indent on

 augroup Filetypes
 	au!

       " Prevent saving files starting with ':' or ';'.
	autocmd BufWritePre [:;]* throw 'Forbidden file name: ' . expand('<afile>')

	" Syntax folding for bash
	autocmd Filetype sh let g:sh_fold_enabled=3
	autocmd Filetype sh let g:is_bash=1
	autocmd Filetype sh setlocal foldmethod=syntax

    " Compile Pascal on file save
    autocmd BufWritePost *.pas :FPC

augroup END

syntax enable
let python_highlight_all=1

" }}}

" Spaces and Tabs {{{

set tabstop=2
set shiftwidth=2

" A combination of spaces and tabs are used to simulate tab stops at a width
set softtabstop=2
set expandtab

" Show “invisible” characters
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

" Enable true color for neovim
let $NVIM_TUI_ENABLE_TRUE_COLOR = 0

" Enables cursor similar to gui programs
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

set title
set number
set noruler
set lazyredraw
set nocursorcolumn
set nocursorline

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

set bg=dark
colorscheme gruvbox

" }}}

" Key Mapping {{{


" Really simple Multi cursors
nnoremap <C-j> *Ncgn
vnoremap <C-j> <Esc>*Ncgn

" Unmap space in normal and visual modes
nnoremap <SPACE> <nop>
vnoremap <SPACE> <nop>

" Map ctrl c to escape to fix multiple cursors issue
noremap <C-c> <Esc>

" Map the capital equivalent for easier save/exit
cabbrev Wq wq
cabbrev W w
cabbrev Q q

" Map q to qa to quickly exit when using goyo
cnoreabbrev q qa

" unmap capital K
nnoremap K <nop>

" Copies what was just pasted
" Allows you to paste the same thing over and over and over and over and over and over
xnoremap p pgvy

" Cylces through splits using a double press of enter in normal mode
nnoremap <CR><CR> <C-w><C-w>
nnoremap \\ <C-w>q

" Unmaps the arrow keys
"map <Up> <nop>
"map <Down> <nop>
"map <Left> <nop>
"map <Right> <nop>

" Map ; to :
noremap ; :

" Save files with root privliges
cmap w!! w !sudo tee % >/dev/null

" Maps Tab to indent blocks of text in visual mode
vmap <TAB> >gv
vmap <BS> <gv

" use hjkl-movement between rows when soft wrapping:
nnoremap , gj
nnoremap k gk
vnoremap , gj
vnoremap k gk

noremap <S-Left> 0
vnoremap <S-Left> I
nnoremap <S-Right> A
vnoremap <S-Right> $

nnoremap <S-Down> }
nnoremap <S-Up> <S-[>

inoremap <S-Right> <Esc>$i<Right>

imap <C-v> <Esc>pi

" include the default behaviour by doing reverse mappings so you can move linewise with gj and gk:
nnoremap gj ,
nnoremap gk k

" Jumps to the bottom of Fold
nmap <Leader>b zo]z

" Moves a single space after end of line and puts me in insert mode
nnoremap L A

" Easily move to start/end of line
nnoremap H I
vnoremap H 0
vnoremap L $
nnoremap L A


" unmap a in normal mode
nmap a <nop>

" za/az toggle folds
" ezpz to spam open/close folds now
nmap az za

" Shows the highlight group of whatever's under the cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nmap <F1> :set number!<CR>

" Toggle goyo
nmap <Leader>g :Goyo<CR>

" }}}

" Temp Files {{{

" Fuck swapfiles
set noswapfile

" Set backup/undo dirs
set backupdir=~/.config/nvim/tmp/backups//
set undodir=~/.config/nvim/tmp/undo//

" Make the folders automatically if they don't already exist.
if !isdirectory(expand(&backupdir))
	call mkdir(expand(&backupdir), 'p')
endif

if !isdirectory(expand(&undodir))
	call mkdir(expand(&undodir), 'p')
endif

" Persistent Undo, Vim remembers everything even after the file is closed.
set undofile
set undolevels=500
set undoreload=500

" }}}


" Misc {{{

" Auto change dir to file directory
set autochdir

" Use the OS clipboard by default
set clipboard+=unnamedplus

" Dictionary
set dictionary=/usr/share/dict/words

" Saner backspacing
set backspace=indent,eol,start

" More natural split opening
set splitbelow
set splitright

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Better auto complete
set complete=.,w,b,u,t,i
set completeopt=longest,menu,preview

set noerrorbells

" Functions {{{

" Better Buffer Navigation {{{
" Maps <Tab> to cycle though buffers but only if they're modifiable.

function! BetterBufferNav(bcmd)
	if &modifiable == 1 || &filetype ==? 'help'
		execute a:bcmd
	endif
endfunction

" Maps Tab and Shift Tab to cycle through buffers
nmap <silent> <Tab> :call BetterBufferNav("bn") <Cr>
nmap <silent> <S-Tab> :call BetterBufferNav("bp") <Cr>

" }}}

" Fullscreen Help {{{
" Opens Help files as if any other file was opened with "e file"
" also works with completion like regular :help

" This works by opening a blank buffer and setting it's buffer type to 'help'. Now when you run 'help ...' the blank buffer will show the helpfile in fullscreen. The function then adds the buffer to the bufferlist so you can use :bn, :bp, etc.
function FullScreenHelp(helpfile)
	enew
	set buftype=help
	execute 'help ' . a:helpfile
	set buflisted
endfunction

" Open help files the same as you usually do with "help example" and they'll open in a new buffer similar to "e file"
command -nargs=1 -complete=help Help call FullScreenHelp(<f-args>)
cabbrev help Help
cabbrev h Help

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


" }}}
