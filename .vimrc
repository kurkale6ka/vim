" Author: Dimitar Dimitrov: mitkofr@yahoo.fr, kurkale6ka
"
"   Note: zR to unfold everything, then :help folding
" ------------------------------------------------------

" Options {{{1

set nocompatible

" Common util {{{2
if has('win32')

   set runtimepath=
      \$HOME/config/vimfiles,
      \$VIM/vimfiles,
      \$VIMRUNTIME,
      \$VIM/vimfiles/after,
      \$HOME/config/vimfiles/after

   set viewdir=$HOME/config/vimfiles/view

   behave xterm
endif

call pathogen#infect()

set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
set matchpairs+=<:>
set fileformats=unix,mac,dos
set viminfo='20,<50,s10,h,!

" C, server side includes, HTML
set include=^\\s*#\\s*include\\\|--\\s*#\\s*include\\s*virtual=\\\|href=
set includeexpr=substitute(v:fname,'^/','','')
set isfname-==

if has('folding')

   set foldmethod=marker
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

   set list
endif

" Alerts and visual feedback {{{2
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
set scrolloff=2
set virtualedit=all

" Statusline & tabline: %{SlSpace()}
function! SlSpace()
   if exists('*GetSpaceMovement')
      let s:mov = GetSpaceMovement()
      return '' != s:mov ? ' (' . s:mov . ') ' : ''
   else
      return ''
   endif
endfunc

hi User1 term=bold ctermbg=black ctermfg=Yellow gui=bold guibg=black guifg=Yellow

set statusline=%<%n.\ %1*%t%*,\ L:%l/%1*%L%*\ C:%v
   \%{empty(&keymap)?'':'\ <'.b:keymap_name.'>'}\ %r%m
   \%=%1*%{expand('%:p:~:h')}%*,\ \%{empty(&filetype)?'':'['.&filetype.']-'}%{&fileformat}\ %P

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

   set guifont=DejaVu\ Sans\ Mono\ 14,
      \Nimbus\ Mono\ L\ 14,
      \Andale\ Mono\ 14,
      \Liberation\ Mono\ 14,
      \Monospace\ 14
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
set shiftwidth=3
set softtabstop=3
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

   execute 'normal! ^'

   let first_col = virtcol('.')

   execute 'normal! g_'

   let last_col  = virtcol('.')

   execute 'normal! ' . (first_col + last_col) / 2 . '|'

endfunction

nmap <silent> gm :call <sid>Gm()<cr>
omap <silent> gm :call <sid>Gm()<cr>
" xmap <silent> gm :call <sid>Gm()<cr>

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
xmap <silent> Y :<c-u>call <sid>BlockCopy()<cr>
nmap gV     gvV
nmap g<c-v> gv<c-v>

function! s:LineCopy()

   let line =
      \substitute(getline('.'), '^[[:space:]:]\+\|[[:space:]]\+$', '', '')

   call histadd(':', line)

   return line

endfunction

nmap <leader><c-l> :<c-r>=<sid>LineCopy()<cr>

function! s:BlockCopy()

   if "\<c-v>" == visualmode()

      normal! gv$y
   else
      normal! gvVy
   endif
endfunction

nmap <leader>s :%substitute/<c-r><c-w>//gc<left><left><left>
nmap <leader>g :global/<c-r><c-w>/
nmap <leader>5 :%substitute///gc<left><left><left><left>
nmap <leader>bg :Bgrep/<c-r><c-w>/<cr>

nmap <c-pageup>        :bprevious<cr>
nmap <c-pagedown>      :bnext<cr>
imap <c-pageup>   <c-o>:bprevious<cr>
imap <c-pagedown> <c-o>:bnext<cr>

" <leader>v {{{2
" selects to the EOL excluded
nmap <leader>v v$h

" Backspace {{{2
" deletes leftwards
nnoremap <bs>  "_X

" \h {{{2
" Help on current word
nmap <leader>h :help    <c-r><c-w><cr>
xmap <leader>h "*y:help <c-r>*<cr>
nmap <silent> <f1>      :help<bar>only<cr>
imap <silent> <f1> <c-o>:help<bar>only<cr>

" alt-i {{{2
" Re-indent the whole file
nmap <silent> <m-i> :Indentation<cr>

" zM {{{2
" Fold everything & go to line 1
nnoremap zM :let wv = winsaveview()<cr>zM:call winrestview(wv)<cr>
" nnoremap zM zMgg0

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
map <home> ^
imap <home> <c-o>I

imap <c-up> <c-o>{
map  <c-up>      {

imap <c-down> <c-o>}
map  <c-down>      }

" Deletion
map!     <c-bs>    <c-w>
imap     <c-k>     <c-o>D
cmap     <c-k>     <c-f>D<c-c>
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

nmap <s-right>      vE
imap <s-right> <c-o>vE
vmap <s-right>       E

nmap <s-left>       vB
imap <s-left>  <c-o>vB
vmap <s-left>        B

" Increase font size {{{2
nmap <c-mousedown> :set guifont=<c-z><c-f>
   \:substitute/[[:digit:]]\+/\=submatch(0)+1/g<cr><cr>
nmap <c-mouseup>   :set guifont=<c-z><c-f>
   \:substitute/[[:digit:]]\+/\=submatch(0)-1/g<cr><cr>

imap <c-mousedown> <c-o>:set guifont=<c-z><c-f>
   \:substitute/[[:digit:]]\+/\=submatch(0)+1/g<cr><cr>
imap <c-mouseup>   <c-o>:set guifont=<c-z><c-f>
   \:substitute/[[:digit:]]\+/\=submatch(0)-1/g<cr><cr>

let g:gfn_bak = &guifont
nmap <M-0> :let &guifont = g:gfn_bak<cr>

" [I {{{2
" Searches using [I in visual mode
xmap [I "*y:global/<c-r>*<cr>

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
imap <c-cr> <esc>o

" Text-object: file
nmap yaf :%y<cr>
nmap daf :%d<cr>
nmap caf :%d<cr>i
nmap vaf ggVG
nmap <silent> =af :Indentation<cr>
nmap dl :$d<cr>``

" c-s, c-s a {{{2
" Saving:

" write this file
nmap <c-s>s      :update<cr>
imap <c-s>s <c-o>:update<cr>
nmap <c-s><c-s>      :update<cr>
imap <c-s><c-s> <c-o>:update<cr>

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
nnoremap <silent> [[ :call search('^[^[:space:]]\@=.*{$', 'besW')<CR>
nnoremap <silent> ]] :call search('^[^[:space:]]\@=.*{$',  'esW')<CR>
onoremap <expr> [[ (search('^[^[:space:]]\@=.*{$', 'ebsW') && (setpos("''", getpos('.'))
   \ <bar><bar> 1) ? "''" : "\<esc>")
onoremap <expr> ]] (search('^[^[:space:]]\@=.*{$',  'esW') && (setpos("''", getpos('.'))
   \ <bar><bar> 1) ? "''" : "\<esc>")

" c-l {{{2
" Redraw the screen and remove any search highlighting
" Remove superfluous white spaces towards the EOL
nnoremap <silent> <c-l> :nohlsearch<bar>
   \call <sid>TransformLines ('del_EOL_spaces')<cr><c-l>

" <leader>sq {{{2
" Squeeze empty lines (<leader>sq)
nmap <leader>z :call <sid>TransformLines ('squeeze')<cr>

" todo: move to autoload
"       the 'no lines compressed' doesn't show
function! s:TransformLines (operation)

   let last_search = histget('search', -1)

   try
      let save_cursor = getpos(".")

      if 'squeeze' == a:operation

         global/^\%([[:space:]]*$\n\)\{2,}/delete

      elseif 'del_EOL_spaces' == a:operation

         silent! %substitute/[[:space:]]\+$//e
      endif

      call setpos('.', save_cursor)

   catch /E486/

      echohl ErrorMsg

      if 'squeeze' == a:operation

         echo 'No lines compressed'

      elseif 'del_EOL_spaces' == a:operation

         " echo 'No superfluous EOL whitespaces'
      endif

      echohl NONE

   finally

      if histget('search', -1) != last_search

         call histdel('search', -1)
      endif
   endtry

endfunction

vnoremap <leader>box <ESC>:call <SID>BoxIn()<CR>gvlolo

function! s:BoxIn()
   let mode = visualmode()
   if mode == ""
      return
   endif
   let vesave = &ve
   let &ve = "all"
   exe "norm! ix\<BS>\<ESC>"
   if line("'<") > line("'>")
      undoj | exe "norm! gvo\<ESC>"
   endif
   if mode != "\<C-v>"
      let len = max(map(range(line("'<"), line("'>")), "virtcol([v:val, '$'])"))
      undoj | exe "norm! gv\<C-v>o0o0" . (len-2?string(len-2):'') . "l\<esc>"
   endif
   let diff = virtcol("'>") - virtcol("'<")
   if diff < 0
      let diff = -diff
   endif
   let horizm = "+" . repeat('-', diff+1) . "+"
   if mode == "\<C-v>"
      undoj | exe "norm! `<O".horizm."\<ESC>"
   else
      undoj | exe line("'<")."put! ='".horizm."'" | norm! `<k
   endif
   undoj | exe "norm! yygvA|\<ESC>gvI|\<ESC>`>p"
   let &ve = vesave
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

   new

   setlocal buftype=nofile bufhidden=hide noswapfile

   put=lines

   execute 'vglobal/' . a:filter . '/delete'
   %substitute#^[[:space:]]*[[:digit:]]\+:[[:space:]]*##e

   0

endfunction

command! -nargs=1 Scriptnames call <sid>Filter_lines ('scriptnames', <q-args>)
command! -nargs=1 Version call <sid>Filter_lines ('version', <q-args>)
command! -nargs=* Ascii call <sid>Ascii (<f-args>)

function! s:Ascii (...)

   if a:0 == 0
      view $HOME/config/vimfiles/ascii
      return
   endif

   let codes =
      \{0:'^@', 9:'^I', 10:'^J (^@)', 13:'^M', 32:'<space>', 127:'<del>', 160:'&nbsp'}

   if a:0 != 2

      for code in a:000

         echon '['. code .' '
         echohl Comment

         if has_key(codes, code)
            echon codes[code]
         else
            echon  nr2char(code)
         endif

         echohl Normal
         echon  '] '
      endfor
   else
      for code in range(a:1, a:2)

         echon '['. code .' '
         echohl Comment

         if has_key(codes, code)
            echon codes[code]
         else
            echon  nr2char(code)
         endif

         echohl Normal
         echon  '] '
      endfor
   endif

endfunction

" Windows {{{2
nmap <silent> <c-w><c-w> :wincmd p<cr>
nmap <silent> <c-w>e     :WinFullScreen<cr>
nmap <silent> <c-w><c-e> :WinFullScreen<cr>

xmap   <tab> >
xmap <s-tab> <
nmap <leader>0 :left<cr>
xmap <leader>0 :left<cr>
nmap <leader>l :ls<cr>
map <leader>< :substitute/>\zs[[:space:]]*\ze</\r/g<cr>
map <leader>> :substitute/>\zs[[:space:]]*\ze</\r/g<cr>

xmap [p "0p
nmap [P :pu!<cr>
nmap ]P :pu<cr>

" Exchange first and last line in a visual area
xmap  <cr> <esc>'<dd'>[pjdd`<P==
xmap ]<cr> <esc>'<dd'>p==
xmap [<cr> <esc>'>dd'<p==
xmap ]t <esc>'<yy'>p==
xmap [t <esc>'>yy'<p==

if version >= 703
   set cryptmethod=blowfish
   set wildignorecase
   set undofile
endif

" Plugin settings {{{1

" Keep these lines after runtimepath!
filetype on
filetype indent on
filetype plugin on
syntax on

let g:snips_author = 'Dimitar Dimitrov'

" NERD_commenter
" let NERDLPlace='/*'
" let NERDRPlace='*/'
let NERDCommentWholeLinesInVMode = 1
let NERDSpaceDelims = 1
map <leader><leader> <plug>NERDCommenterToggle

" Surround
let g:surround_{char2nr('w')} = "\\<\r\\>"
let g:surround_{char2nr("\<c-cr>")} = "http://www.\r.com"
let g:surround_{char2nr('c')} = "http://www.\r.com"

let apache_version = '2.2'
let g:is_bash = 1

" Man
if !has('win32')

   runtime! ftplugin/man.vim
endif

let g:CSApprox_verbose_level = 1

if &term =~ '^\(xterm\|screen\)$' && $COLORTERM == 'gnome-terminal'
   set t_Co=256
endif

" PHP
let php_folding = 3
let php_large_file = 0

let vim_indent_cont = &shiftwidth

let g:SuperTabDefaultCompletionType = "context"

function! YRRunAfterMaps()
   nnoremap <silent> Y :YRYankCount 'y$'<cr>
endfunction

" Disable all these plugins!

if version < 702
   let g:space_loaded = 1
endif

let g:loaded_netrwPlugin     = 1
let g:loaded_zipPlugin       = 1
let g:loaded_vimballPlugin   = 0
let g:loaded_tarPlugin       = 1
let g:loaded_getscriptPlugin = 1
let loaded_rrhelper          = 1
let loaded_spellfile_plugin  = 1
let g:loaded_ZoomWin         = 1
let g:loaded_flatfoot        = 1

" There seems not to be a way to disable tohtml.vim

function! s:Underline(chars)

   let chars = empty(a:chars) ? '-' : a:chars

   let nb_columns = virtcol('$') - 1
   let nb_chars = strlen(chars)

   if has('float')
      let nb_insertions = floor(nb_columns / str2float(nb_chars))
      let remainder = nb_columns % nb_chars
   else
      let nb_insertions = nb_columns / nb_chars
   endif

   let saveFormatoptions = &formatoptions
   set formatoptions-=o

   execute "normal! o\<esc>"

   let &formatoptions = saveFormatoptions

   if has('float')
      execute 'normal! ' . float2nr(nb_insertions) . 'i' . chars . "\<esc>"

      if !empty(remainder)
         execute 'normal! A' . strpart(chars, 0, remainder) . "\<esc>"
      endif
   else
      execute 'normal! ' . nb_insertions . 'i' . chars . "\<esc>"
   endif

endfunction

function! s:Indentation(amount) range

   let save_shiftwidth = &shiftwidth

   if !empty(a:amount)
      let &shiftwidth = a:amount
   endif

   if a:firstline == a:lastline

      let save_cursor = getpos(".")
      normal! gg=G
      call setpos('.', save_cursor)
   else
      execute a:firstline . ',' . a:lastline . ' normal!=='
   endif

   let &shiftwidth = save_shiftwidth

endfunction

function! AddSubtract(operation, direction)

   if &nrformats =~ 'alpha'

      let pattern = '[[:alpha:][:digit:]]'
   else
      let pattern = '[[:digit:]]'
   endif

   if 'b' == a:direction

      call search(pattern, 'bcw')
   else
      call search(pattern, 'cw')
   endif

   if 'a' == a:operation

      execute 'normal! ' . v:count1 . "\<c-a>"
      silent! call
         \ repeat#set(":\<c-u>call AddSubtract('a', '" .a:direction. "')\<cr>")
   else
      execute 'normal! ' . v:count1 . "\<c-x>"
      silent! call
         \ repeat#set(":\<c-u>call AddSubtract('s', '" .a:direction. "')\<cr>")
   endif

endfunction

nmap <silent>         <c-a> :<c-u>call AddSubtract('a', 'f')<cr>
nmap <silent> <leader><c-a> :<c-u>call AddSubtract('a', 'b')<cr>
nmap <silent>         <c-x> :<c-u>call AddSubtract('s', 'f')<cr>
nmap <silent> <leader><c-x> :<c-u>call AddSubtract('s', 'b')<cr>

function! s:ShowOptionsValues(verb)

   let options = input('Options? ', '', 'option')

   if !empty(options)

      let optionsArr = split(options)

      if 1 != a:verb && len(optionsArr) == 1

         let command = 'set ' . join(optionsArr, '? ') . '?'
         execute command
      else
         let command = 'verbose set ' . join(optionsArr, '? ') . '?'
         execute command
      endif

      call histadd(':', command)
   else
      set
   endif

endfunction

nmap <leader>o :call <sid>ShowOptionsValues(0)<cr>
nmap <leader>O :call <sid>ShowOptionsValues(1)<cr>

" Commands {{{1

command! -nargs=? Underline call <sid>Underline(<q-args>)
command! -nargs=? -range Indentation
   \ <line1>,<line2> call <sid>Indentation(<q-args>)
command! DeleteTags %substitute:<[?%![:space:]]\@!/\=\_.\{-1,}[-?%]\@<!>::gc
command! WriteSudo write !sudo tee % > /dev/null
command! DiffOrig vnew | set buftype=nofile | read# | silent 0delete_ |
   \ diffthis | wincmd p | diffthis
command! Translate call setline(line('.'), tr(getline('.'),
   \'ABVGDEWZIJKLMNOPRSTUYFHXC$^&}{!|Qabvgdewzijklmnoprstuyfhxc467][1\q',
   \'АБВГДЕЖЗИЙКЛМНОПРСТУYФХXЦЧШЩЪЬЮЮЯабвгдежзийклмнопрстуyфхxцчшщъьююя'))

" Autocommands {{{1

if has('autocmd')

   augroup vimrcGrp

      autocmd!

      " Jump to the last spot the cursor was at in a file when reading it
      autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line('$') |
         \ execute 'normal! g`"' |
         \ endif

      " When reading a file, :cd to its parent directory unless it's a help
      " file. It reproduces the behaviour of autochdir which doesn't work
      " properly
      autocmd BufEnter * if &filetype != 'help' | silent! cd %:p:h | endif

      " Wrap automatically at 80 chars for plain text files
      autocmd FileType txt,text,svn setlocal formatoptions+=t
         \ autoindent smartindent

      " Useful for class aware omnicompletion with php
      autocmd FileType php,phtml
         \ let @v="\<esc>yiwO/* @var $\<esc>pa Zend_ */\<left>\<left>\<left>"

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

nmap <leader>ft :set filetype=
nmap <leader>fa :set filetype=awk<cr>
nmap <leader>fs :set filetype=scheme<cr>
nmap <leader>fp :set filetype=perl<cr>
nmap <leader>fh :set filetype=html<cr>
nmap <leader>fj :set filetype=javascript<cr>
nmap <leader>fx :set filetype=xml<cr>
nmap <leader>fv :set filetype=vim<cr>
nmap <leader>fl :set filetype=tex<cr>
nmap <leader>fb :set filetype=sh<cr>
nmap <leader>fc :set filetype=c<cr>
nmap <leader>fr :set filetype=ruby<cr>

nmap <leader>kbg :setlocal keymap=bg<cr>
nmap <leader>kfr :setlocal keymap=fr<cr>
nmap <leader>kes :setlocal keymap=es<cr>
nmap <leader>ken :setlocal keymap& spelllang&<cr>

cabbrev vsb vertical sbuffer
cabbrev svb vertical sbuffer

cabbrev trp rtp
cabbrev waq wqa
cabbrev mpa map
cabbrev frm fmr

iabbrev :n      [[:alnum:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :N     [^[:alnum:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :a      [[:alpha:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :A     [^[:alpha:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :k      [[:blank:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :K     [^[:blank:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :c      [[:cntrl:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :C     [^[:cntrl:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :d      [[:digit:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :D     [^[:digit:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :g      [[:graph:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :G     [^[:graph:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :l      [[:lower:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :L     [^[:lower:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :i      [[:print:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :I     [^[:print:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :p      [[:punct:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :P     [^[:punct:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :s      [[:space:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :S     [^[:space:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :u      [[:upper:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :U     [^[:upper:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :x     [[:xdigit:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :X    [^[:xdigit:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :r     [[:return:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :R    [^[:return:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :t        [[:tab:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :T       [^[:tab:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :e     [[:escape:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :E    [^[:escape:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :b  [[:backspace:]]<c-r>=EatChar('[[:space:]]')<cr>
iabbrev :B [^[:backspace:]]<c-r>=EatChar('[[:space:]]')<cr>

" function! s:IfCopy()

"    let start = search('\<if.*$\n\%([[:space:]]*{\)\=\_[[:space:]]\+\zs', 'bn')
"    let end   = search('[^[:space:]][[:space:]]*$\n\ze\_[[:space:]]\+\%([[:space:]]*}[[:space:]]*\)\=else', 'bn')

"    return getline(start, end)

" endfunction

" inoreabbrev else else<cr><c-r>=<sid>IfCopy()<cr><c-r>=EatChar('$')<cr>

iabbrev latex LaTeX
iabbrev _t <c-r>=strftime('%d %B %Y, %H:%M %Z (%A)')<cr>
   \<c-r>=EatChar('[[:space:]]')<cr>
iabbrev www http://www.<c-r>=EatChar('[[:space:]]')<cr>

" vim: set foldmethod=marker foldmarker&:
