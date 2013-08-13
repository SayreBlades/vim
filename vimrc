" no backwards vi behavior 
set nocompatible

" set up pathogen
call pathogen#infect()

" Get that filetype stuff happening
filetype on
filetype plugin on
filetype indent on

" #####################################################################
" Turn on colors
" #####################################################################
syntax on
highlight LineNr ctermfg=444444

" #####################################################################
" set behaviours of vim
" #####################################################################
" Here are a bunch of vanilla set options
set statusline=%f%=%{fugitive#statusline()}\ %l/%L "set the status line
set cursorline    " highlights the current line
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set number        " always show line numbers
set ruler         " show line/column number of cursor at bottom
set laststatus=2  " always show the status line
set backspace=indent,eol,start
" allow backspacing over everything in insert mode
set whichwrap=b,s,h,l " allow these character movements to wrap lines
set list          " show unprintable characters
set listchars=tab:▸\ ,trail:-,nbsp:%
" only set the tab unprintable character
set title         " change the terminal's title
set wildmenu      " turn on enhanced auto complete
" set wildmode=list " bash shell style menu mode
set hidden        " put modified buffers in background
set noswf         " turn off swap files for now, it gets annoying when continuous compilation compiles swap files
set nowrap        " turn off the line wrapping
set history=100   " increase command line history from 20

" Dealing with tabs
set tabstop=4     " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=4  " Number of spaces to use for each step of (auto)indent.  Used for |'cindent'|, |>>|, |<<|, etc
set softtabstop=4 " Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>.
set expandtab     " tabs are spaces
set autoindent    " new lines are indented the same as the previous line
" set relativenumber " use relative numbers to navigate file


" #####################################################################
" set up autocommands
" #####################################################################
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END


" #####################################################################
" set up abbreviations
" #####################################################################
iabbrev adn and
iabbrev waht what
iabbrev tehn then

" #####################################################################
" Set up key mappings
" #####################################################################
let mapleader=','
let localleader=',,'

noremap <buffer> <localleader>n :echo "lln"<cr>:sleep 500m<cr>:echo "done"<cr>

" map jk to escape
" inoremap <s-space> <esc>`^
" cnoremap <s-space> <esc>`^
" nnoremap <s-space> <nop>
" vnoremap <s-space> <esc>`^
" noremap <esc> <nop>
" noremap <Up> <nop>
" noremap <Down> <nop>
" noremap <Left> <nop>
" noremap <Right> <nop>

" kill the window
nnoremap <silent> K :bd<cr>

" set up a command line mappint %% to current file directory
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
" map <leader>ew :e %%
" map <leader>es :sp %%
" map <leader>ev :vsp %%
" map <leader>et :tabe %%

" add bettern pane navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" create intermediate directories
nnoremap <leader>mk :!mkdir -p %:h<CR>

" Quickly edit/source the vimrc file
nnoremap <leader>ec :e $MYVIMRC<CR>
nnoremap <leader>so :w<CR>:so %<CR>:echom "saved and sourced"<CR>

" quickly save file
nnoremap <leader>sv :w<CR>:echom "saved"<cr>

" open the current file in marked application
nnoremap <leader>md  :!open -a Marked.app '%'<cr><cr>

" cursorline doesnt work very well in tmux; set up toggle
nnoremap <leader>cl :set cursorline!<CR>:set cursorline?<CR>

" toggle number
nnoremap <leader>n :set number!<CR>:set number?<CR>

" toggle hls
" nnoremap <leader>n :set hls!<CR>:set hls?<CR>
nnoremap <leader>h :nohlsearch<CR>

" toggle list hidden chars
nnoremap <leader>l :set list!<CR>:set list?<cr>

" toggle paste
nnoremap <leader>p :set paste!<CR>:set paste?<CR>

" toggle paste
nnoremap <leader>w :set wrap!<CR>:set wrap?<CR>

" map a scala file format
nnoremap <leader>fs mmgggqG`m

" Maps Alt-[h,j,k,l] to resizing a window split
if bufwinnr(1)
  nnoremap _ <C-W>-
  nnoremap + <C-W>+
  nnoremap [ <C-W><
  nnoremap ] <C-W>>
endif

" #####################################################################
" quickfix window stuff
" #####################################################################
" nnoremap go <CR>:copen<CR>
" nnoremap <C-j> :copen<CR>:cnext<CR>
" nnoremap <C-k> :copen<CR>:cprevious<CR>

" #####################################################################
" Set up netrw
" #####################################################################
" let g:netrw_browse_split=4
" let g:netrw_preview=1
" "let g:netrw_liststyle=3
" let g:netrw_winsize=20

" #####################################################################
" Set up autocommands
" #####################################################################
" read .json files as javascript
autocmd BufNewFile,BufRead *.json set ft=javascript


" #####################################################################
" javascript plugin
" #####################################################################
let g:html_indent_inctags = "body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"


" #####################################################################
" sclariform
" #####################################################################
au BufEnter *.scala setl formatprg=java\ -jar\ ~/bin/scalariform.jar\ --stdin\ --stdout
" au BufEnter *.scala setl formatprg=scala\ -cp\ ~/Programs/scala/scalariform-1.0/scalariform.jar\ scalariform.commandline.Main\ --forceOutput


" #####################################################################
" ctrl-p configuration
" #####################################################################
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/](\.git|\.hg|\.svn|target)$',
            \ 'file' : '\v\.(class)$',
            \}
let g:ctrlp_working_path_mode = 'rc'


" #####################################################################
" search current highlight
" #####################################################################
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR> 
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g') 
    let @s = temp
endfunction
