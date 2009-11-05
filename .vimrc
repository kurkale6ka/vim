" Author:
"       Dimitar Dimitrov (mitkofr@yahoo.fr), kurkale6ka
"
" Notes:
"     - Use zR to unfold everything, then read :help folding
"
"     - A .vimrc is better than a vimrc because it prevents the
"       sourcing of a .exrc
" -------------------------------------------------------------

" Options {{{1

" Common util {{{2
if has('win32')

    behave xterm                                                                           " be
    se runtimepath=$HOME/vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/vim/after " rtp

endif

nmap <expr> gm Gm() . '<bar>'

function! Gm()

    exe "norm ^"
    let b:first_col = virtcol('.')
    let b:last_col  = virtcol('$') - 1

    ec (b:first_col + b:last_col) / 2

endfunction

syntax on                       " sy
filetype plugin indent on       " filet

set nocompatible                " cp

set backspace=indent,eol,start  " bs
set whichwrap=b,s,<,>,[,]       " ww (<left> & <right> also wrap around lines in normal and insert mode)
set fileformats=unix,mac,dos    " ffs
set viminfo='20,<50,s10,h,!     " vi

" C, server side includes, HTML
set include=^\\s*#\\s*include\\\|--\\s*#\\s*include\\s*virtual=\\\|href= " inc
set includeexpr=substitute(v:fname,'^/','','')                           " inex

set wildmenu                    " wmnu (menu completion in command mode on <tab>)
set wildcharm=<c-z>             " wcm (cmdline: <c-z> in a mapping acts like <tab>)

if has('folding')

    set foldmethod=marker       " fdm
    set foldmarker=~\\~,~/~     " fmr

endif

set modeline                    " ml
set modelines=5                 " mls

set fileencodings+=cp1251       " fencs

if has('multi_byte')         " If multibyte support is available and

    if &enc !~? 'utf-\=8'    " the current encoding is not Unicode,

        if empty(&tenc)      " default to
            let &tenc = &enc " using the current encoding for terminal output
        endif                " unless another terminal encoding was already set
        set enc=utf-8        " but use utf-8 for all data internally

    endif

endif

if &enc =~ '^u\(tf\|cs\)' " When running in a Unicode environment

  set list&

  " tabs = arrow + dots (▷⋅⋅⋅⋅⋅⋅⋅)
  let s:arr = nr2char(9655) " use U+25B7 for an arrow (▷) and
  let s:dot = nr2char(8901) " use U+22C5 for a  dot   (⋅)

  " lcs
  exe "set listchars=tab:"    . s:arr . s:dot
  exe "set listchars+=trail:" . s:dot
  exe "set listchars+=nbsp:"  . s:dot

  " sbr: arrow+space (↪ ) at the beginning of wrapped lines
  let &showbreak=nr2char(8618).' '

endif

" Alerts and visual feedback {{{2
set linebreak                   " lbr
set number                      " nu
set numberwidth=3               " nuw
set showmatch                   " sm (parens)
set showcmd                     " sc
set visualbell t_vb=            " vb (visual bell instead of beeping + disable the visual effect = no flashing at all)
set confirm                     " cf
set report=0                    " Commands always print changed line count
set laststatus=2                " ls
set lazyredraw                  " lz
set display+=lastline           " dy
set scrolloff=3                 " so
set virtualedit=all             " ve

" Statusline                    " stl
set statusline=%<Buf\ %n:\ %t\ %y%m%r\ %L\ lines%=%-14.(L:%l,\ C:%v%)\ %P

if has('syntax')

    set cursorline              " cul

endif

if has('mouse_xterm')

    set mouse=a

endif

" I like my cursor pointing left when selecting text (shortcut: mouses)
set mouseshape=i-r:beam,s:updown,sd:udsizing,vs:leftright,vd:lrsizing,m:no,
            \ml:up-arrow,
            \v:arrow

if !has('win32')

    " Monospaced fonts are better used by Vim        (shortcut: gfn   )
    set guifont=DejaVu\ Sans\ Mono\ 16,
                \Nimbus\ Mono\ L\ 16,
                \Andale\ Mono\ 16,
                \Liberation\ Mono\ 16,
                \Monospace\ 16

else

    set guifont=DejaVu_Sans_Mono:h12,
                \Nimbus_Mono_L:h12,
                \Andale_Mono:h12,
                \Liberation_Mono:h12,
                \Monospace:h12

endif

" backups {{{2
set backup                      " bk - Don't delete backup file after a succesful write.

if has('win32')

    set directory+=$LOCALAPPDATA\Temp " dir  - swap   files
    set backupdir+=$LOCALAPPDATA\Temp " bdir - backup files

endif

" Search {{{2
set incsearch                   " is
set ignorecase                  " ic
set smartcase                   " scs
set infercase                   " inf (try to adjust insert completions for case)
set hlsearch                    " hls

" Text formating {{{2

" c - auto-wrap comments using textwidth
" r - automatically insert the current comment leader after hitting <Enter>
" o - automatically insert the current comment leader after hitting 'o' or 'O'
" q - allow formatting of comments with "gq"
" n - when formatting text, recognize numbered lists (ai must be enabled)
set formatoptions=croqn         " fo

" Spaces and tabs {{{2
set softtabstop=4               " sts
set shiftwidth=4                " sw
set expandtab                   " et

" Tags {{{2
set completeopt-=preview        " cot
set showfulltag                 " Show more information while completing tags

" Windows and buffers {{{2
set hidden                      " hid
set diffopt+=vertical           " dip

" A split/quickfix command will switch to the right
" window/tab if the buffer is already open there)
if version < 700

    set switchbuf=useopen       " swb

else

    set switchbuf=useopen,usetab

endif

if has('gui_running')

    winpos 0 0                  " winp
    set sessionoptions+=resize  " ssop

endif
" }}}2

" Mappings {{{1

" `A...`Z {{{2
" Jump to file on last change position
nnoremap <silent> `A :silent! norm! `A`.<cr>
nnoremap <silent> `B :silent! norm! `B`.<cr>
nnoremap <silent> `C :silent! norm! `C`.<cr>
nnoremap <silent> `D :silent! norm! `D`.<cr>
nnoremap <silent> `E :silent! norm! `E`.<cr>
nnoremap <silent> `F :silent! norm! `F`.<cr>
nnoremap <silent> `G :silent! norm! `G`.<cr>
nnoremap <silent> `H :silent! norm! `H`.<cr>
nnoremap <silent> `I :silent! norm! `I`.<cr>
nnoremap <silent> `J :silent! norm! `J`.<cr>
nnoremap <silent> `K :silent! norm! `K`.<cr>
nnoremap <silent> `L :silent! norm! `L`.<cr>
nnoremap <silent> `M :silent! norm! `M`.<cr>
nnoremap <silent> `N :silent! norm! `N`.<cr>
nnoremap <silent> `O :silent! norm! `O`.<cr>
nnoremap <silent> `P :silent! norm! `P`.<cr>
nnoremap <silent> `Q :silent! norm! `Q`.<cr>
nnoremap <silent> `R :silent! norm! `R`.<cr>
nnoremap <silent> `S :silent! norm! `S`.<cr>
nnoremap <silent> `T :silent! norm! `T`.<cr>
nnoremap <silent> `U :silent! norm! `U`.<cr>
nnoremap <silent> `V :silent! norm! `V`.<cr>
nnoremap <silent> `W :silent! norm! `W`.<cr>
nnoremap <silent> `X :silent! norm! `X`.<cr>
nnoremap <silent> `Y :silent! norm! `Y`.<cr>
nnoremap <silent> `Z :silent! norm! `Z`.<cr>

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
nmap <s-f1> :h <c-r><c-w><cr>
vmap <s-f1> "*y:h <c-r>*<cr>

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
nmap <c-g> :pw<cr>

" Emacs bindings {{{2

" Moving
cnoremap <c-a> <home>

imap <c-up> <c-o>{
map <c-up> {

imap <c-down> <c-o>}
map <c-down> }

" Deletion (Insert and Command-line mode)
map! <c-bs> <c-w>

imap <c-del> <c-o>de
cmap <c-del> <c-f>de<c-c>

" Replaces the digraphs shortcut which I don't use too often, but
" unfortunately also breaks the dictionary completion (c-x c-k)
" imap <c-k> <c-o>D
" cmap <c-k> <c-f>D<c-c>

" Visual selection {{{2
nmap <s-up> Vk
imap <s-up> <c-o>Vk
vmap <s-up> k

nmap <s-down> Vj
imap <s-down> <c-o>Vj
vmap <s-down> j

nnoremap <s-right> v<s-right>
nnoremap <s-left> v<s-left>

inoremap <s-right> <c-o>v<s-right>
inoremap <s-left> <c-o>v<s-left>

" Increase font size {{{2
nmap <c-mousedown> :se gfn=<c-z><c-f>:s/\d\+/\=submatch(0)+1/g<cr><cr>
nmap <c-mouseup> :se gfn=<c-z><c-f>:s/\d\+/\=submatch(0)-1/g<cr><cr>

" nmap <c-+> :se gfn=<c-z><c-f>:s/\d\+/\=submatch(0)+1/g<cr><cr>
" nmap <c--> :se gfn=<c-z><c-f>:s/\d\+/\=submatch(0)-1/g<cr><cr>

imap <c-mousedown> <c-o>:se gfn=<c-z><c-f>:s/\d\+/\=submatch(0)+1/g<cr><cr>
imap <c-mouseup> <c-o>:se gfn=<c-z><c-f>:s/\d\+/\=submatch(0)-1/g<cr><cr>

" imap <c-+> <c-o>:se gfn=<c-z><c-f>:s/\d\+/\=submatch(0)+1/g<cr><cr>
" imap <c--> <c-o>:se gfn=<c-z><c-f>:s/\d\+/\=submatch(0)-1/g<cr><cr>

let g:gfn_bak = &guifont
nmap <M-0> :let &guifont = g:gfn_bak<cr>

" c-l {{{2
" Redraw the screen and remove any search highlighting
nnoremap <c-l> :noh<cr><c-l>

" [I {{{2
" Searches using [I in visual mode
vmap [I "*y:g/<c-r>*<cr>

" Q {{{2
" Format paragraphs
nmap Q gqap

" F5, F8, F9 {{{2
" Debugging:
nmap <f5> :update<bar>make<cr>

nmap <f8> :cp<cr>

nmap <f9> :cn<cr>

" F6, F7, s-F7 {{{2
" Spell check
nmap <f7> ]s
nmap <s-f7> [s
nmap <f6> 1z=

" F4 {{{2
" Toggle between cot+=preview and cot-=preview
" mnemo - 'same' behaviour as F4 used in Dolphin KDE
nmap <f4> :call Toggle_Longest_Preview('f4')<cr>
imap <f4> <c-o>:call Toggle_Longest_Preview('f4')<cr>

" F12 {{{2
" Toggle between cot+=longest and cot-=longest
nmap <f12> :call Toggle_Longest_Preview('f12')<cr>
imap <f12> <c-o>:call Toggle_Longest_Preview('f12')<cr>

function! Toggle_Longest_Preview(key)

    if a:key == 'f12'

        if &cot =~ 'longest'

            set completeopt-=longest
            echo 'completeopt - longest (Zend_Acl)'

        else

            set completeopt+=longest
            echo 'completeopt + longest (Zend_)'

        endif

    elseif a:key == 'f4'

        if &cot =~ 'preview'

            set completeopt-=preview
            echo 'completeopt - preview'

        else

            set completeopt+=preview
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
nmap <c-s> :up<cr>
imap <c-s> <c-o>:up<cr>

" write all files
nmap <c-s><c-a> :wa<cr>
imap <c-s><c-a> <c-o>:wa<cr>

nmap <c-s>a :wa<cr>
imap <c-s>a <c-o>:wa<cr>

" } {{{2
" In vblock-mode: } selects only the current column
" these mappings work correctly if 'nosol is set
set nostartofline " nosol

vnoremap <expr> } mode() == nr2char(22) ? line("'}") - 1 . 'G' : '}'
vnoremap <expr> { mode() == nr2char(22) ? line("'{") + 1 . 'G' : '{'

" [[, ]] {{{2
" work even if the { is not in the first column
nnoremap <silent> [[ :call search('^\S\@=.*{$', 'besW')<CR>
nnoremap <silent> ]] :call search('^\S\@=.*{$', 'esW')<CR>
onoremap <expr> [[ (search('^\S\@=.*{$', 'ebsW') && (setpos("''", getpos('.'))
            \ <bar><bar> 1) ? "''" : "\<ESC>")
onoremap <expr> ]] (search('^\S\@=.*{$', 'esW') && (setpos("''", getpos('.'))
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
nmap <leader>eol :%s/\s\+$<cr>``

" \gq {{{2
" Highlight text beyond the 80th column (\gq)
nmap <leader>gq /\%81v.*<cr>``

" \sq {{{2
" Squeeze empty lines (\sq)
nmap <leader>sq :v/\S/,/\S/-j<bar>noh<cr>``

" \' {{{2
" Replace all " by '
nmap <leader>' :s/"/'/g<cr>``
" }}}2

" Plugin settings {{{1

" Man
if !has('win32')

    runtime! ftplugin/man.vim " ru

endif

if has('gui_running')

    let g:CSApprox_loaded = 1

else

    " CSApprox
    if &term == 'xterm'

        " On my machine, I use Konsole with 256 color support
        set t_Co=256
        let g:CSApprox_konsole = 1

    endif

endif

" Netrw: don't display files starting with dot
let g:netrw_list_hide = '^\.[^.]'

" PHP syntax folding

" 1: for folding classes and functions
" 2: for folding all { } regions
" 3: for folding only functions (latest version)
let php_folding = 3

let php_large_file = 0

" Disable all those plugins!

let loaded_rrhelper          = 1
let g:loaded_zipPlugin       = 1
let g:loaded_vimballPlugin   = 1
let g:loaded_tarPlugin       = 1
let g:loaded_getscriptPlugin = 1
let loaded_gzip              = 1
let loaded_spellfile_plugin  = 1

" There seems not to be a way to disable tohtml.vim

" Commands {{{1

" Show the short version of an :ex command
if !exists(':HelpEx')

    com -nargs=1 -complete=command HelpEx
                \ :h <args>|norm k/[^:]\[<cr>
                \l"*y0
                \:noh|q|redr|ec "<c-r>*"<cr>

endif

command! WriteSudo w !sudo tee % > /dev/null

" Autocommands  - :au[tocmd] {{{1

if has("autocmd")

    augroup vimrcGrp

        " Remove all autocommands for the current group
        au!

        " Try to jump to the last spot the cursor was at in a file when reading it
        au BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \ exe "normal g`\"" |
                    \ endif

        " When reading a file, :cd to its parent directory unless it's a help file
        " It reproduces the behaviour of autochdir (acd) which doesn't work properly
        au BufEnter * if &ft != 'help' | silent! cd %:p:h | endif

        " Wrap automatically at 80 chars for plain text files
        " textwidth     (tw)
        " formatoptions (fo)
        " autoindent    (ai) - copy indent from current line when starting a new line
        " smartindent   (si) - limited C-like autoindenting
        au FileType text,svn setlocal tw=80 fo+=t ai si

        " Useful for class aware omnicompletion with php
        au FileType php,phtml let @v="\<esc>yiwO/* @var $\<esc>pa Zend_ */\<left>\<left>\<left>"

        " Use :mak[e] to check a script {{{2

        " Perl (to be improved)
        au FileType perl set makeprg=perl\ -c\ %\ $* errorformat=%m\ at\ %f\ line\ %l.

        " PHP
        au FileType php set makeprg=php\ -l\ %\ $* errorformat=%E%m\ in\ %f\ on\ line\ %l,%Z%m
        " }}}2

    augroup END

endif

" Abbreviations - :ia[bbrev] {{{1

" vim: se fdm=marker fmr& fenc=utf-8 cul hls ic is scs nu et sts=4 sw=4 lbr:
