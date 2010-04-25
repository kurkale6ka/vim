" Author: Dimitar Dimitrov: mitkofr@yahoo.fr, kurkale6ka
"
"   Note: zR to unfold everything, then :help folding
" ------------------------------------------------------

" Options {{{1

" Common util {{{2
if has('win32')

    set runtimepath=
                \~/vimfiles,
                \$VIM/vimfiles,
                \$VIMRUNTIME,
                \$VIM/vimfiles/after,
                \~/vimfiles/after

    set viewdir=~/vimfiles/view

    behave xterm

endif

" Keep these lines after runtimepath!
syntax on
filetype plugin indent on

set nocompatible

set exrc
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
set matchpairs+=<:>
set fileformats=unix,mac,dos
set viminfo='20,<50,s10,h,!

" C, server side includes, HTML
set include=^\\s*#\\s*include\\\|--\\s*#\\s*include\\s*virtual=\\\|href=
set includeexpr=substitute(v:fname,'^/','','')

set wildmenu
set wildignore+=*~
set wildcharm=<c-z> " cmdline: <c-z> in a mapping acts like <tab>

if has('folding')

    set foldmethod=marker
    set foldmarker=~\\~,~/~

endif

set modeline
set modelines=3

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

    execute "set listchars=tab:"    . s:arr . s:dot
    execute "set listchars+=trail:" . s:dot
    execute "set listchars+=nbsp:"  . s:dot

    " arrow + space (↪ ) at the beginning of wrapped lines
    let &showbreak=nr2char(8618).' '

endif

" Alerts and visual feedback {{{2
set list
set linebreak
set number
set numberwidth=3
set showmatch
set showcmd
" visual bell instead of beeping + disable the visual effect = no flashing at all
set visualbell t_vb=
set confirm
set report=0
set laststatus=2
set lazyredraw
set display+=lastline
set scrolloff=3
set virtualedit=all

" Statusline
set statusline=%<buf\ %n:\ %t\ %y%m%r\ %L\ lines%{empty(&keymap)?'':'\ <'.b:keymap_name.'>'}%=%-14.(L:%l,\ C:%v%)\ %P

if has('syntax')

    set cursorline

endif

if has('mouse_xterm')

    set mouse=a

endif

" I like my cursor pointing left when selecting text
set mouseshape=i-r:beam,s:updown,sd:udsizing,vs:leftright,vd:lrsizing,m:no,
            \ml:up-arrow,
            \v:arrow

" For konsole
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

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
set backup

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
set formatoptions=croqn
set nojoinspaces

" Spaces and tabs {{{2
set softtabstop=4
set shiftwidth=4
set expandtab

" Tags {{{2
set complete-=t
set complete-=]
set completeopt-=preview
set showfulltag

" Windows and buffers {{{2
set hidden
set diffopt+=vertical
set splitright

if version < 700

    set switchbuf=useopen

else

    set switchbuf=useopen,usetab

endif
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

" \v {{{2
" selects to the EOL excluded
nmap \v v$h

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

" Emacs bindings {{{2

" Moving
cnoremap <c-a> <home>

imap <c-up> <c-o>{
map  <c-up>      {

imap <c-down> <c-o>}
map  <c-down>      }

" Deletion (Insert and Command-line mode)
map! <c-bs> <c-w>

imap <c-del> <c-o>de
cmap <c-del> <c-f>de<c-c>

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
nmap <c-mousedown> :set guifont=<c-z><c-f>:substitute/\d\+/\=submatch(0)+1/g<cr><cr>
nmap <c-mouseup>   :set guifont=<c-z><c-f>:substitute/\d\+/\=submatch(0)-1/g<cr><cr>

imap <c-mousedown> <c-o>:set guifont=<c-z><c-f>:substitute/\d\+/\=submatch(0)+1/g<cr><cr>
imap <c-mouseup>   <c-o>:set guifont=<c-z><c-f>:substitute/\d\+/\=submatch(0)-1/g<cr><cr>

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
            \ <bar><bar> 1) ? "''" : "\<ESC>")
onoremap <expr> ]] (search('^\S\@=.*{$',  'esW') && (setpos("''", getpos('.'))
            \ <bar><bar> 1) ? "''" : "\<ESC>")

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

" \eol {{{2
" Remove superfluous white spaces towards the EOL (\eol)
nmap <leader>eol :%substitute/\s\+$<cr>``

" \gq {{{2
" Highlight text beyond the 80th column (\gq)
nmap <leader>gq /\%81v.*<cr>``

" \sq {{{2
" Squeeze empty lines (\sq)
nmap <leader>sq :vglobal/\S/,/\S/-j<bar>noh<cr>``

" \' {{{2
" Replace all " by '
nmap <leader>' :substitute/"/'/g<cr>``
" }}}2

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

" Disable all those plugins!

let g:loaded_netrwPlugin     = 1
let loaded_rrhelper          = 1
let g:loaded_zipPlugin       = 1
let g:loaded_vimballPlugin   = 1
let g:loaded_tarPlugin       = 1
let g:loaded_getscriptPlugin = 1
let loaded_gzip              = 1
let loaded_spellfile_plugin  = 1

" There seems not to be a way to disable tohtml.vim

" Commands {{{1

command! WriteSudo write !sudo tee % > /dev/null
command! DiffOrig vnew | set buftype=nofile | read# | silent 0delete_ | diffthis | wincmd p | diffthis

" Autocommands {{{1

if has("autocmd")

    augroup vimrcGrp

        autocmd!

        " Try to jump to the last spot the cursor was at in a file when reading it
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \ execute "normal g`\"" |
                    \ endif

        " When reading a file, :cd to its parent directory unless it's a help file
        " It reproduces the behaviour of autochdir which doesn't work properly
        autocmd BufEnter * if &filetype != 'help' | silent! cd %:p:h | endif

        " Wrap automatically at 80 chars for plain text files
        autocmd FileType text,svn setlocal textwidth=80 formatoptions+=t autoindent smartindent

        " Useful for class aware omnicompletion with php
        autocmd FileType php,phtml let @v="\<esc>yiwO/* @var $\<esc>pa Zend_ */\<left>\<left>\<left>"

        " Use :make to check a script {{{2

        " Perl (to be improved)
        autocmd FileType perl set makeprg=perl\ -c\ %\ $* errorformat=%m\ at\ %f\ line\ %l.

        " PHP
        autocmd FileType php set makeprg=php\ -l\ %\ $* errorformat=%E%m\ in\ %f\ on\ line\ %l,%Z%m
        " }}}2

    augroup END

endif

" Abbreviations {{{1

cabbrev vsb vertical sbuffer
cabbrev svb vertical sbuffer
cabbrev bs s:\\:/:g

cabbrev kmp&    keymap&\|set spelllang&
cabbrev keymap& keymap&\|set spelllang&
cabbrev kmp=    keymap&\|set spelllang&
cabbrev keymap= keymap&\|set spelllang&

iabbrev fu function
iabbrev sw switch(
iabbrev ec echo
iabbrev ar array(

" vim: se fdm=marker fmr& fenc=utf-8 cul hls ic is scs nu et sts=4 sw=4 lbr:
