" Author: Dimitar Dimitrov: mitkofr@yahoo.fr, kurkale6ka
"
"   Note: zR to unfold everything, then :help folding
" ------------------------------------------------------

" Options {{{1

" Common util {{{2
if has('win32')

    set runtimepath=
        \$HOME/vimfiles,
        \$VIM/vimfiles,
        \$VIMRUNTIME,
        \$VIM/vimfiles/after,
        \$HOME/vimfiles/after

    set viewdir=$HOME/vimfiles/view

    behave xterm
endif

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Keep these lines after runtimepath!
syntax                 on
filetype plugin indent on

set nocompatible

set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
set matchpairs+=<:>
set fileformats=unix,mac,dos
set viminfo='20,<50,s10,h,!

" C, server side includes, HTML
set include=^\\s*#\\s*include\\\|--\\s*#\\s*include\\s*virtual=\\\|href=
set includeexpr=substitute(v:fname,'^/','','')

if has('folding')

    set foldmethod=marker
    set foldmarker=~\\~,~/~
endif

" Security restrictions
if 'root' != $USER || has('win32')

    set exrc
    set modeline
    set modelines=3
else
    set noexrc
    set nomodeline
endif

if has('multi_byte')

    if &encoding !~? 'utf-\=8'

        if empty(&termencoding)

            let &termencoding = &encoding
        endif

        set encoding=utf-8
    endif
endif

if &encoding =~ '^u\(tf\|cs\)' " When running in a Unicode environment

    " tabs = arrow + dots (▷⋅⋅⋅)
    let s:arr = nr2char(9655) " use U+25B7 for an arrow (▷) and
    let s:dot = nr2char(8901) " use U+22C5 for a  dot   (⋅)

    execute 'set listchars=tab:'    . s:arr . s:dot
    execute 'set listchars+=trail:' . s:dot
    execute 'set listchars+=nbsp:'  . s:dot

    " arrow + space (↪ ) at the beginning of wrapped lines
    let &showbreak=nr2char(8618).' '
endif

" Alerts and visual feedback {{{2
set list
set linebreak
set number
set numberwidth=3
set showmatch
set matchtime=2
set showcmd
set shortmess=flmnrxoOtT
set ruler
" visual bell instead of beeping + disable the visual effect
" = no flashing at all
set visualbell t_vb=
set confirm
set report=0
set laststatus=2
set lazyredraw
set display+=lastline
set scrolloff=3
set virtualedit=all

" Statusline & tabline
function! SlSpace()
    if exists('*GetSpaceMovement')
        let s:mov = GetSpaceMovement()
        return '' != s:mov ? ' (' . s:mov . ') ' : ''
    else
        return ''
    endif
endfunc

set statusline=%<%n:\ %t\ %y%m%r\ %L\ lines%{SlSpace()}
    \%{empty(&keymap)?'':'\ <'.b:keymap_name.'>'}
    \%=%-14.(%{'['.&fileformat.']'}\ L:%l,\ C:%v%)\ %P

set showtabline=1

set tabline=%!MyTabLine()

function! MyTabLine()

    let s = ''

    for i in range(tabpagenr('$'))

        " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif

        " set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T'

        " the label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '

    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s .= '%=%#TabLine#%999XClose[X]'
    endif

    return s

endfunction

function! MyTabLabel(n)

    let label = ''

    let buflist = tabpagebuflist(a:n)

    " Add '+' if one of the buffers in the tab page is modified
    for bufnr in buflist
        if getbufvar(bufnr, '&modified')
            let label = '+ '
            break
        endif
    endfor

    let winnr = tabpagewinnr(a:n)
    let fname = fnamemodify(bufname(buflist[winnr - 1]), ':t')

    if fname != ''

        let label .= fname
    else
        let label .= '[No Name]'
    endif

    " Append the number of windows in the tab page if more than one
    let wincount = tabpagewinnr(a:n, '$')

    if wincount > 1
        let label .= ' (' . wincount . ')'
    endif

    return label

endfunction

if has('syntax')

    set cursorline
endif

" Mouse
if has('mouse_xterm')

    set mouse=a
    set ttymouse=xterm2
    set timeoutlen=2000
    set ttimeoutlen=100
    set ttyscroll=3

    " Vim bug: Only t_te, not t_op, gets sent when leaving an alt screen
    exe 'set t_te=' . &t_te . &t_op
endif

" I like my cursor pointing left when selecting text
set mouseshape=i-r:beam,s:updown,sd:udsizing,vs:leftright,vd:lrsizing,m:no,
    \ml:up-arrow,
    \v:arrow

if 'konsole' == $TERM

    let &t_SI = "\<esc>]50;CursorShape=1\x7"
    let &t_EI = "\<esc>]50;CursorShape=0\x7"
endif

if !has('win32')

    set guifont=DejaVu\ Sans\ Mono\ 16,
        \Nimbus\ Mono\ L\ 16,
        \Andale\ Mono\ 16,
        \Liberation\ Mono\ 16,
        \Monospace\ 16
else
    set guifont=DejaVu_Sans_Mono:h13,
        \Nimbus_Mono_L:h13,
        \Andale_Mono:h13,
        \Liberation_Mono:h13,
        \Monospace:h13
endif

" backups {{{2
set noautowrite
set noautowriteall
set noautoread
set writebackup
set backup
set backupskip=
set backupext=~

if has('win32')

    set directory+=$LOCALAPPDATA\Temp " swap files
    set backupdir+=$LOCALAPPDATA\Temp
endif

" Search {{{2
set incsearch
set ignorecase
set smartcase
set infercase
set hlsearch

" Text formating {{{2
set textwidth=80
set formatoptions=croqn
set nojoinspaces

" Tabs and shifting {{{2
set shiftround
set shiftwidth=4
set softtabstop=4
set tabstop=8
set expandtab

" Tags {{{2
set complete-=t
set complete-=]
set completeopt-=preview
set showfulltag

" Windows and buffers {{{2
set hidden
set diffopt+=vertical
set noequalalways
set splitright

if version < 700

    set switchbuf=useopen
else
    set switchbuf=useopen,usetab
endif

" Command line {{{2
set wildmenu
set wildmode=full
set wildignore+=*~,*.swp
set wildcharm=<c-z> " cmdline: <c-z> in a mapping acts like <tab>
set history=1000
" }}}2

" Mappings {{{1

" gm improved {{{2
function! s:Gm()

    execute 'normal ^'

    let first_col = virtcol('.')

    call search('[^[:space:]]\ze[[:space:]]*$', 'c', line('.'))

    let last_col  = virtcol('.')

    execute 'normal ' . (first_col + last_col) / 2 . '|'

endfunction

nmap <silent> gm :call <sid>Gm()<cr>

" `A...`Z {{{2
" Jump to file on last change position
nnoremap <silent> `A :silent! normal! `A`.<cr>
nnoremap <silent> `B :silent! normal! `B`.<cr>
nnoremap <silent> `C :silent! normal! `C`.<cr>
nnoremap <silent> `D :silent! normal! `D`.<cr>
nnoremap <silent> `E :silent! normal! `E`.<cr>
nnoremap <silent> `F :silent! normal! `F`.<cr>
nnoremap <silent> `G :silent! normal! `G`.<cr>
nnoremap <silent> `H :silent! normal! `H`.<cr>
nnoremap <silent> `I :silent! normal! `I`.<cr>
nnoremap <silent> `J :silent! normal! `J`.<cr>
nnoremap <silent> `K :silent! normal! `K`.<cr>
nnoremap <silent> `L :silent! normal! `L`.<cr>
nnoremap <silent> `M :silent! normal! `M`.<cr>
nnoremap <silent> `N :silent! normal! `N`.<cr>
nnoremap <silent> `O :silent! normal! `O`.<cr>
nnoremap <silent> `P :silent! normal! `P`.<cr>
nnoremap <silent> `Q :silent! normal! `Q`.<cr>
nnoremap <silent> `R :silent! normal! `R`.<cr>
nnoremap <silent> `S :silent! normal! `S`.<cr>
nnoremap <silent> `T :silent! normal! `T`.<cr>
nnoremap <silent> `U :silent! normal! `U`.<cr>
nnoremap <silent> `V :silent! normal! `V`.<cr>
nnoremap <silent> `W :silent! normal! `W`.<cr>
nnoremap <silent> `X :silent! normal! `X`.<cr>
nnoremap <silent> `Y :silent! normal! `Y`.<cr>
nnoremap <silent> `Z :silent! normal! `Z`.<cr>

" Y {{{2
" copies to the EOL
nmap Y y$

" <leader>v {{{2
" selects to the EOL excluded
nmap <leader>v v$h

" Backspace {{{2
" deletes leftwards
nnoremap <bs>  "_X

" \h {{{2
" Help on current word
nmap <leader>h :help    <c-r><c-w><cr>
vmap <leader>h "*y:help <c-r>*<cr>

" alt-i {{{2
" Re-indent the whole file
nmap <m-i> gg=G``

" zM {{{2
" Fold everything & go to line 1
nnoremap zM zMgg0

" c-tab {{{2
" Switch to the alternate file
nnoremap <c-tab> <c-^>

" c-g {{{2
" Print the working directory
nmap <c-g> :echo expand('%:p:h')<cr>

" Moving and deletion {{{2

" Moving
cnoremap <c-a>  <home>
cnoremap <esc>b <s-left>
cnoremap <esc>f <s-right>
cnoremap <m-b>  <s-left>
cnoremap <m-f>  <s-right>

imap <c-up> <c-o>{
map  <c-up>      {

imap <c-down> <c-o>}
map  <c-down>      }

" Deletion
map!     <c-bs>    <c-w>
cnoremap <esc><bs> <c-w>
cnoremap <m-bs>    <c-w>

imap     <c-del>    <c-o>de
cmap     <c-del>    <c-f>de<c-c>
cnoremap <esc><del> <c-f>de<c-c>
cnoremap <m-del>    <c-f>de<c-c>

" Visual selection {{{2
nmap <s-up>      Vk
imap <s-up> <c-o>Vk
vmap <s-up>       k

nmap <s-down>      Vj
imap <s-down> <c-o>Vj
vmap <s-down>       j

nnoremap <s-right> v<s-right>
nnoremap <s-left>  v<s-left>

inoremap <s-right> <c-o>v<s-right>
inoremap <s-left>  <c-o>v<s-left>

" Increase font size {{{2
nmap <c-mousedown> :set guifont=<c-z><c-f>
    \:substitute/\d\+/\=submatch(0)+1/g<cr><cr>
nmap <c-mouseup>   :set guifont=<c-z><c-f>
    \:substitute/\d\+/\=submatch(0)-1/g<cr><cr>

imap <c-mousedown> <c-o>:set guifont=<c-z><c-f>
    \:substitute/\d\+/\=submatch(0)+1/g<cr><cr>
imap <c-mouseup>   <c-o>:set guifont=<c-z><c-f>
    \:substitute/\d\+/\=submatch(0)-1/g<cr><cr>

let g:gfn_bak = &guifont
nmap <M-0> :let &guifont = g:gfn_bak<cr>

" c-l {{{2
" Redraw the screen and remove any search highlighting
nnoremap <c-l> :nohlsearch<cr><c-l>

" [I {{{2
" Searches using [I in visual mode
vmap [I "*y:global/<c-r>*<cr>

" Q {{{2
" Format paragraphs
nmap Q gqap

" F5, F8, F9 {{{2
" Debugging:
nmap <f5> :update<bar>make<cr>

nmap <f8> :cprevious<cr>
nmap <f9> :cnext<cr>

" F6, F7, s-F7 {{{2
" Spell check
nmap <f7>   ]s
nmap <s-f7> [s
nmap <f6>   1z=

" c-space {{{2
" Help switching between buffers
nmap <c-space> :b<space>
imap <c-cr> <esc>o<cr>

" c-s, c-s a {{{2
" Saving:

" write this file
nmap <c-s>      :update<cr>
imap <c-s> <c-o>:update<cr>

" write all files
nmap <c-s><c-a>      :wall<cr>
imap <c-s><c-a> <c-o>:wall<cr>

nmap <c-s>a      :wall<cr>
imap <c-s>a <c-o>:wall<cr>

" } {{{2
" In visual-block mode: } selects the current column
" these mappings work correctly only if 'nostartofline is set
set nostartofline

vnoremap <expr> } mode() == nr2char(22) ? line("'}") - 1 . 'G' : '}'
vnoremap <expr> { mode() == nr2char(22) ? line("'{") + 1 . 'G' : '{'

" [[, ]] {{{2
" work even if the { is not in the first column
nnoremap <silent> [[ :call search('^\S\@=.*{$', 'besW')<CR>
nnoremap <silent> ]] :call search('^\S\@=.*{$',  'esW')<CR>
onoremap <expr> [[ (search('^\S\@=.*{$', 'ebsW') && (setpos("''", getpos('.'))
    \ <bar><bar> 1) ? "''" : "\<esc>")
onoremap <expr> ]] (search('^\S\@=.*{$',  'esW') && (setpos("''", getpos('.'))
    \ <bar><bar> 1) ? "''" : "\<esc>")

" <leader>l {{{2
" Remove superfluous white spaces towards the EOL (<leader>l)
nmap <leader>l :call <sid>TransformLines ('del_EOL_spaces')<cr>

" <leader>sq {{{2
" Squeeze empty lines (<leader>sq)
nmap <leader>z :call <sid>TransformLines ('squeeze')<cr>

" todo: move to autoload
"       the 'no lines compressed' doesn't show
function! s:TransformLines (operation)

    let last_search = histget('search', -1)

    try
        if 'squeeze' == a:operation

            global/^\%([[:space:]]*$\n\)\{2,}/delete

        elseif 'del_EOL_spaces' == a:operation

            %substitute/\s\+$
        endif

        normal ``

    catch /E486/

        echohl ErrorMsg

        if 'squeeze' == a:operation

            echo 'No lines compressed'

        elseif 'del_EOL_spaces' == a:operation

            echo 'No superfluous EOL whitespaces'
        endif

        echohl NONE

    finally

        if histget('search', -1) != last_search

            call histdel('search', -1)
        endif
    endtry

endfunction

" todo: nofilter + Version: -> echo '+feature'
function! s:Filter_lines (cmd, filter)

    redir => lines

    let saveMore = &more
    set nomore

    execute a:cmd

    redir END

    let &more = saveMore

    call feedkeys("\<cr>")

    wincmd n

    set buftype=nofile

    execute 'normal insert' . lines . "\<cr>"

    execute 'vglobal/' . a:filter . '/delete'
    %substitute#^\s*\d\+:\s*##eg

    0

endfunction

command! -nargs=1 Scriptnames call <sid>Filter_lines ('scriptnames', <q-args>)
command! -nargs=1 Version call <sid>Filter_lines ('version', <q-args>)

" Windows {{{2
nmap <c-w><c-w> :wincmd p<cr>

" q= {{{2
nmap q= @=<c-f>
" }}}2

map <leader>b :ls<cr>
map <leader>< :substitute/>\zs\s*\ze</\r/g<cr>
map <leader>> :substitute/>\zs\s*\ze</\r/g<cr>

vmap [p "0p

if version >= 703

    set relativenumber

    set cryptmethod=blowfish

    set undofile

endif

" Plugin settings {{{1

let g:snips_author = 'Dimitar Dimitrov'

" NERD_commenter
" let NERDLPlace='/*'
" let NERDRPlace='*/'
let NERDCommentWholeLinesInVMode = 1
let NERDSpaceDelims = 1

" Man
if !has('win32')

    runtime! ftplugin/man.vim
endif

if !has('gui_running')

    if &term == 'xterm'

        " Note: konsole has 256 color support
        set t_Co=256
        let g:CSApprox_konsole = 1
    endif
endif

" PHP syntax folding

" 1: for folding classes and functions
" 2: for folding all { } regions
" 3: for folding only functions (latest version)
let php_folding = 3

let php_large_file = 0

let vim_indent_cont = 4

let g:SuperTabDefaultCompletionType = "context"

function! YRRunAfterMaps()
    nnoremap <silent> Y :YRYankCount 'y$'<cr>
endfunction

" Disable all those plugins!

if version < 702
    let g:space_loaded = 1
endif

let g:loaded_netrwPlugin     = 1
let g:loaded_zipPlugin       = 1
let g:loaded_vimballPlugin   = 1
let g:loaded_tarPlugin       = 1
let g:loaded_getscriptPlugin = 1
let loaded_rrhelper          = 1
let loaded_spellfile_plugin  = 1
let g:loaded_ZoomWin         = 1

" There seems not to be a way to disable tohtml.vim

function s:Underline(chars)

    let chars = empty(a:chars) ? '-' : a:chars

    let nb_columns = virtcol('$') - 1
    let nb_chars = strlen(chars)

    if has('float')
        let nb_insertions = floor(nb_columns / str2float(nb_chars))
        let remainder = nb_columns % nb_chars
    else
        let nb_insertions = nb_columns / nb_chars
    endif

    execute "normal o\<esc>"

    if has('float')
        execute 'normal ' . float2nr(nb_insertions) . 'i' . chars . "\<esc>"

        if !empty(remainder)
            execute 'normal A' . strpart(chars, 0, remainder) . "\<esc>"
        endif
    else
        execute 'normal ' . nb_insertions . 'i' . chars . "\<esc>"
    endif

endfunction
" Commands {{{1

command! DeleteTags %substitute:<[?%![:space:]]\@!/\=\_.\{-1,}[-?%]\@<!>::gc
command! -nargs=? Underline call <sid>Underline(<q-args>)
command! WriteSudo write !sudo tee % > /dev/null
command! DiffOrig vnew | set buftype=nofile | read# | silent 0delete_ |
    \ diffthis | wincmd p | diffthis

" Autocommands {{{1

if has('autocmd')

    augroup vimrcGrp

        autocmd!

        " Jump to the last spot the cursor was at in a file when reading it
        autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line('$') |
            \ execute 'normal g`"' |
            \ endif

        " When reading a file, :cd to its parent directory unless it's a help
        " file. It reproduces the behaviour of autochdir which doesn't work
        " properly
        autocmd BufEnter * if &filetype != 'help' | silent! cd %:p:h | endif

        " Wrap automatically at 80 chars for plain text files
        autocmd FileType txt,text,svn setlocal formatoptions+=t
            \ autoindent smartindent

        " Useful for class aware omnicompletion with php
        autocmd FileType php,phtml let @v="\<esc>yiwO/* @var $\<esc>pa Zend_ */\<left>\<left>\<left>"

        " Use :make to check a script {{{2

        " Perl (to be improved)
        autocmd FileType perl set makeprg=perl\ -c\ %\ $*
            \ errorformat=%m\ at\ %f\ line\ %l.

        " PHP
        autocmd FileType php set makeprg=php\ -l\ %\ $*
            \ errorformat=%E%m\ in\ %f\ on\ line\ %l,%Z%m
        " }}}2

    augroup END
endif

" Abbreviations {{{1

function! EatChar(pat)

    let char = nr2char(getchar(0))
    return (char =~ a:pat) ? '' : char
endfunc

cabbrev vsb vertical sbuffer
cabbrev svb vertical sbuffer
cabbrev <> substitute/>\zs\s*\ze</\r/g
cabbrev >< substitute/>\zs\s*\ze</\r/g

nmap <leader>f :set filetype=

cabbrev kmp&    keymap&\|set spelllang&
cabbrev keymap& keymap&\|set spelllang&
cabbrev kmp=    keymap&\|set spelllang&
cabbrev keymap= keymap&\|set spelllang&

cabbrev waq wqa
cabbrev mpa map
cabbrev frm fmr

iabbrev latex LaTeX
iabbrev _t <c-r>=strftime('%d %B %Y, %H:%M %Z (%A)')<cr><c-r>=EatChar('\s')<cr>

" vim: set foldmethod=marker foldmarker&:
