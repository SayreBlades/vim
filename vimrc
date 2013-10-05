call pathogen#infect()

" Get that filetype stuff happening
filetype on
filetype plugin on
filetype indent on

" #####################################################################
" Turn on colors
" #####################################################################
syntax on
" highlight LineNr ctermfg=444444
colorscheme solarized

" #####################################################################
" make better tmux cursor shapes for insert mode
" #####################################################################
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" #####################################################################
" set behaviours of vim
" #####################################################################
" Here are a bunch of vanilla set options
set statusline=%f%=%{fugitive#statusline()}\ %l/%L "set the status line
set cursorline    " highlights the current line
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set number        " always show line numbers
set relativenumber " set the relative number
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
set background=light " default background to dark

" Dealing with tabs
set tabstop=4     " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=4  " Number of spaces to use for each step of (auto)indent.  Used for |'cindent'|, |>>|, |<<|, etc
set softtabstop=4 " Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>.
set expandtab     " tabs are spaces
set autoindent    " new lines are indented the same as the previous line
" set relativenumber " use relative numbers to navigate file


" #####################################################################
" set up abbreviations
" #####################################################################
iabbrev adn and
iabbrev waht what
iabbrev tehn then
iabbrev {{ {}O<bs>

" #####################################################################
" Set up key mappings
" #####################################################################
let mapleader=','
let maplocalleader=',,'

" remap escape key to do nothing
" noremap <esc> <nop>
" inoremap <esc> <nop>
" vnoremap <esc> <nop>
" nnoremap <esc> <nop>
" nnoremap <c-c> <nop>

" create uppercase map for insert mode
inoremap <c-u> <esc>gUiwea
" nnoremap <c-u> mmgUiw`m

" set up mapping to trigger autocomplete
inoremap <c-o> <c-p><c-n>

" set up mapping to vertical split with the last buffer
noremap <leader>vs :vsp<cr><c-^><c-w>p
noremap <leader>sp :rightbelow vsplit #<cr>

" set up a quick easy motion map
nnoremap <leader>ef H:call EasyMotion#F(0, 0)<cr>
nnoremap <leader>ew H:call EasyMotion#WB(0, 0)<cr>

" kill the window
nnoremap <silent> K :bd<cr>

" set up a command line mappint %% to current file directory
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

" add bettern pane navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" toggle bacground between dark and light
nnoremap <leader>b :call ToggleBackground()<cr>

function! ToggleBackground()
    if(&background==#"dark")
        set background=light
    else
        set background=dark
    endif
endfunction

" ctag mapping
nnoremap <leader>ct :!ctags -R<cr><cr>

" create intermediate directories
nnoremap <leader>mk :!mkdir -p %:h<cr><cr>:echom "created path: " . expand('%:h')<cr>

" Quickly edit/source the vimrc file
nnoremap <leader>ec :e $MYVIMRC<CR>
nnoremap <silent> <leader>so :w<CR>:so %<CR>:echom "saved and sourced: " . expand('%:p')<CR>

" quickly save file
noremap <leader>sv :w<CR>:echom "saved"<cr>

" open the current file in marked application
nnoremap <leader>md :!open -a Marked.app '%'<cr><cr>

" open the current file in chrome
nnoremap <leader>ch :!chrome '%'<cr><cr>

" cursorline doesnt work very well in tmux; set up toggle
nnoremap <leader>cl :set cursorline!<CR>:set cursorline?<CR>

" toggle number
nnoremap <leader>n :call <SID>SetNumber()<CR>
vnoremap <leader>n :<c-u>call <SID>SetNumber()<CR>
function! s:SetNumber()
    if !&number && !&relativenumber
        let &number = 1
        let &relativenumber = 0
        echo "number"
    elseif &number && !&relativenumber
        let &number = 0
        let &relativenumber = 1
        echo "relativenumber"
    else
        let &number = 0
        let &relativenumber = 0
        echo "nonumber"
    endif
endfunction

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
nnoremap <leader>F mmgggqG`m

" set up some nerd tree bindings
nnoremap <leader>tt :NERDTreeToggle<cr>
nnoremap <leader>to :NERDTree<cr>
nnoremap <leader>tc :NERDTreeClose<cr>
" nnoremap <leader>tf :NERDTreeFind<cr><c-w>p
nnoremap <leader>tf :NERDTreeFind<cr>

" set up a line text object
vnoremap il :<c-u>silent! normal! ^v$g_<cr>

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
" set up autocommands
" #####################################################################
" set the folding strategy for vim files
" Vimscript file settings           -------------{{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" test html autocommand
augroup filetype_html
    autocmd!
    autocmd FileType html nnoremap <buffer> <localleader>g Vatzf
augroup END

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


" #####################################################################
" NERDTree
" #####################################################################
let NERDTreeWinPos="left"
let NERDTreeWinSize=35
let NERDTreeIgnore=['target[[dir]]']
let NERDTreeShowHidden=0
