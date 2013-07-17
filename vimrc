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
syntax on

" #####################################################################

" Here are a bunch of vanilla set options
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set number        " always show line numbers
set ruler         " show line/column number of cursor at bottom
set laststatus=2  " always show the status line
set backspace=indent,eol,start
" allow backspacing over everything in insert mode
set list          " show unprintable characters
set listchars=tab:▸\ ,trail:-,nbsp:%
" only set the tab unprintable character
set title         " change the terminal's title
set wildmenu      " turn on enhanced auto complete
set hidden        " put modified buffers in background
set noswf         " turn off swap files for now, it gets annoying when continuous compilation compiles swap files

" Tabstops are 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

" #####################################################################
" Set up key mappings
" #####################################################################
let mapleader=','

" set up a command line mappint %% to current file directory
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
" map <leader>ew :e %%
" map <leader>es :sp %%
" map <leader>ev :vsp %%
" map <leader>et :tabe %%

" Quickly edit/source the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <leader>so :so %<CR>

" quickly save file
nmap <leader>sv :w<CR>
" nmap <silent> <leader>sv :so $MYVIMRC<CR>
" nmap <silent> <C-s> :w<CR>

" open the current file in marked application
nmap <silent> <leader>md  :!open -a Marked.app '%'<cr><cr>

" toggle hls
" nmap <silent> <leader>n :set hls!<CR>:set hls?<CR>
nmap <silent> <leader>n :nohlsearch<CR>

" toggle list hidden chars
nmap <silent> <leader>l :set list!<CR>

" toggle paste
nmap <silent> <leader>p :set paste!<CR>:set paste?<CR>

" map a scala file format
nmap <silent> <leader>fs gggqG<C-o><C-o>

" #####################################################################
" quickfix window stuff
" #####################################################################
nnoremap <silent> go <CR>:copen<CR>
" nnoremap <silent> <C-j> :copen<CR>:cnext<CR>
" nnoremap <silent> <C-k> :copen<CR>:cprevious<CR>

" #####################################################################
" Set up netrw
" #####################################################################
let g:netrw_browse_split=4
let g:netrw_preview=1
"let g:netrw_liststyle=3
let g:netrw_winsize=15

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
au BufEnter *.scala setl formatprg=java\ -jar\ /Users/sayreblades/Programs/scala/scalariform-1.0/scalariform.jar\ --stdin\ --stdout
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
