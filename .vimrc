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

" Keep these lines after runtimepath!
syntax on
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
            \%=%-14.(L:%l,\ C:%v%)\ %P

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
function! Gm()

    execute 'normal ^'

    let b:first_col = virtcol('.')
    let b:last_col  = virtcol('$') - 1

    execute 'normal ' . (b:first_col + b:last_col) / 2 . '|'

endfunction

nmap gm :call Gm()<cr>

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
nnoremap <bs> "_X

" s-f1 {{{2
" Help on current word
nmap <s-f1> :help    <c-r><c-w><cr>
vmap <s-f1> "*y:help <c-r>*<cr>

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
nmap <c-g> :pwd<cr>

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

" F4 {{{2
" Toggle between completeopt+=preview and completeopt-=preview
" mnemo - 'same' behaviour as F4 used in Dolphin KDE
nmap <f4>      :call Toggle_Longest_Preview('f4')<cr>
imap <f4> <c-o>:call Toggle_Longest_Preview('f4')<cr>

" F12 {{{2
" Toggle between completeopt+=longest and completeopt-=longest
nmap <f12>      :call Toggle_Longest_Preview('f12')<cr>
imap <f12> <c-o>:call Toggle_Longest_Preview('f12')<cr>

function! Toggle_Longest_Preview(key)

    if a:key == 'f12'

        if &completeopt =~ 'longest'

            set   completeopt-=longest
            set   showfulltag
            echo 'completeopt - longest (Zend_Acl)'
        else
            set   completeopt+=longest
            set   noshowfulltag
            echo 'completeopt + longest (Zend_)'
        endif

    elseif a:key == 'f4'

        if &completeopt =~ 'preview'

            set   completeopt-=preview
            echo 'completeopt - preview'
        else

            set   completeopt+=preview
            echo 'completeopt + preview window'
        endif
    endif
endfunction

" c-space {{{2
" Help switching between buffers
nmap <c-space> :b<space>

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

" "" instead of ci" and ci' {{{2
nmap <silent> "" :call CI_quotes()<cr>

function! CI_quotes()

    let [qq_line, qq_col] = searchpos('"', 'cnW')
    let [q_line , q_col ] = searchpos("'", 'cnW')

    let curr_line = line('.')

    if qq_line == curr_line || q_line == curr_line

        if qq_line == curr_line && q_line == curr_line

            if qq_col < q_col

                normal ci"
            else
                normal ci'
            endif

        elseif qq_line == curr_line

            normal ci"
        else
            normal ci'
        endif

        normal l
        startinsert
    endif

endfunction

" <leader>l {{{2
" Remove superfluous white spaces towards the EOL (<leader>l)
nmap <leader>l :%substitute/\s\+$<cr>``

" <leader>c {{{2
" Highlight text beyond the 80th column (<leader>c)
nmap <leader>c :call Toggle_colorcolumn()<cr>

function! Toggle_colorcolumn ()

    if empty(&colorcolumn)

        set colorcolumn=+1
        let @/ = '\%81v.*'
    else
        set colorcolumn=
        let @/ = ''
    endif

endfunction

" <leader>sq {{{2
" Squeeze empty lines (<leader>sq)
nmap <leader>z :global/^\%([[:space:]]*$\n\)\{2,}/delete<cr>``

function! Toggle_quotes () range

    if a:firstline != a:lastline

        let endline = a:lastline - a:firstline + 1
    else
        let endline = v:count1
    endif

    for i in range(1, endline)

        if -1 != match(getline('.'), '"')

            substitute/"/'/ge
        else
            substitute/'/"/ge
        endif
        +
    endfor

    let virtualedit_bak = &virtualedit
    set virtualedit=

    silent! call repeat#set(":call Toggle_quotes()\<cr>")

    let &virtualedit = virtualedit_bak

endfunction

" <leader>' {{{2
" Replace all " by '
nmap <leader>' :call Toggle_quotes()<cr>
vmap <leader>' :call Toggle_quotes()<cr>

" Windows {{{2
nmap <c-w><c-w> :wincmd p<cr>

" q= {{{2
nmap q= @=<c-f>
" }}}2

map <leader>b :ls<cr>
map <leader>s :set spell! spell?<cr>
map <leader>p :set invpaste paste?<cr>
map <leader>\ :s:\\:/:g<cr>
map <leader>/ :s:\\:/:g<cr>
map <leader>< :s/>\zs\s*\ze</\r/g<cr>
map <leader>> :s/>\zs\s*\ze</\r/g<cr>

vmap [p "0p

if version >= 703

    function! Toggle_number()

        if !&relativenumber

            set relativenumber relativenumber?
        else
            set number number?
        endif

    endfunction

    map <leader>n :call Toggle_number()<cr>

    set relativenumber

    set cryptmethod=blowfish

    set undofile

endif

" Plugin settings {{{1

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

let g:SuperTabDefaultCompletionType = "context"

function! YRRunAfterMaps()
    nnoremap Y :YRYankCount 'y$'<cr>
endfunction

map tt <plug>(smarttill-t)
map TT <plug>(smarttill-T)
map ff <plug>(smarttill-f)
map FF <plug>(smarttill-F)

vmap <leader>i  <plug>blockinsert-i
vmap <leader>a  <plug>blockinsert-a
vmap <leader>qi <plug>blockinsert-qi
vmap <leader>qa <plug>blockinsert-qa

nmap <leader>i  <plug>blockinsert-i
nmap <leader>a  <plug>blockinsert-a
nmap <leader>qi <plug>blockinsert-qi
nmap <leader>qa <plug>blockinsert-qa

vmap <leader>[]  <plug>blockinsert-b
vmap <leader>[[  <plug>blockinsert-ub
vmap <leader>]]  <plug>blockinsert-ub
vmap <leader>q[] <plug>blockinsert-qb
vmap <leader>q[[ <plug>blockinsert-uqb
vmap <leader>q]] <plug>blockinsert-uqb

nmap <leader>[]  <plug>blockinsert-b
nmap <leader>[[  <plug>blockinsert-ub
nmap <leader>]]  <plug>blockinsert-ub
nmap <leader>q[] <plug>blockinsert-qb
nmap <leader>q[[ <plug>blockinsert-uqb
nmap <leader>q]] <plug>blockinsert-uqb

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

" There seems not to be a way to disable tohtml.vim

" Commands {{{1

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
        autocmd FileType text,svn setlocal formatoptions+=t
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
cabbrev <> s/>\zs\s*\ze</\r/g
cabbrev >< s/>\zs\s*\ze</\r/g

cabbrev ftt set filetype=<c-r>=EatChar('\s')<cr>
cabbrev fft set filetype=<c-r>=EatChar('\s')<cr>
cabbrev tt  set filetype=<c-r>=EatChar('\s')<cr>

cabbrev kmp&    keymap&\|set spelllang&
cabbrev keymap& keymap&\|set spelllang&
cabbrev kmp=    keymap&\|set spelllang&
cabbrev keymap= keymap&\|set spelllang&

iabbrev _t <c-r>=strftime('%d %B %Y, %H:%M %Z (%A)')<cr><c-r>=EatChar('\s')<cr>

" vim: set foldmethod=marker foldmarker&:
