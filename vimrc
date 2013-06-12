" no backwards vi behavior 
set nocompatible

" set up pathogen
call pathogen#infect()

" Get that filetype stuff happening
filetype on
filetype plugin on
filetype indent on

" Turn on syntax highlighting
syntax on

" Here are a bunch of vanilla set options
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set number        " always show line numbers
set ruler         " show line/column number of cursor at bottom
set laststatus=2  " always show the status line
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set list          " show unprintable characters
set listchars=tab:\|\ ,trail:-
                  " only set the tab unprintable character
set title         " change the terminal's title
set wildmenu      " turn on enhanced auto complete


" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" open the current file in marked application
nmap <silent> <leader>m  :!open -a Marked.app '%'<cr><cr>

