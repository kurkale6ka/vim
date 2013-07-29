" Author: Dimitar Dimitrov: mitkofr@yahoo.fr, kurkale6ka
"
" Note: zR to unfold everything, then :help folding
" ------------------------------------------------------

" Options {{{1
set nocompatible
call pathogen#infect()

" Backups {{{2
set backup backupskip= backupext=~
set noautowrite noautowriteall
set writebackup
set noautoread
if version >= 703 | set undofile | endif
set viminfo='20,<50,s10,h,!

" Search {{{2
set incsearch hlsearch
set ignorecase smartcase infercase

nmap <leader>g     :global/<c-r><c-w>/
xmap <leader>g  "*y:global/<c-r>*<cr>
nmap <leader>bg  :Bgrep/<c-r><c-w>/<cr>

" Encoding {{{2
if has('multi_byte')
   if &encoding !~? 'utf-\=8'
      if empty(&termencoding)
         let &termencoding = &encoding
      endif
      set encoding=utf-8
   endif
endif
set fileencodings=ucs-bom,utf-8,default,cp1251,latin1
set fileformats=unix,mac,dos

if &encoding =~ '^u\(tf\|cs\)' " When running in a Unicode environment

   " tabs = arrow + dots (▷⋅⋅⋅)
   let s:arr = nr2char(9655) " use U+25B7 for an arrow (▷) and
   let s:dot = nr2char(8901) " use U+22C5 for a  dot   (⋅)

   execute 'set listchars=tab:'    . s:arr . s:dot
   execute 'set listchars+=trail:' . s:dot
   execute 'set listchars+=nbsp:'  . s:dot

   set linebreak
   " arrow + space (↪ ) at the beginning of wrapped lines
   let &showbreak=nr2char(8618).' '
   set list
   nmap <leader><tab> :setlocal invlist list?<cr>
endif

" Alerts and visual feedback {{{2
set number numberwidth=3
set matchpairs+=<:>
set showmatch matchtime=2
" visual bell instead of beeps + disable the visual effect = no flashing at all
set visualbell t_vb=
set confirm
set lazyredraw
set display+=lastline
set scrolloff=2
set virtualedit=all
set whichwrap=b,s,<,>,[,]
set backspace=indent,eol,start
set shortmess=flmnrxoOtT
set showcmd
set report=0

let did_install_default_menus = 1

" Print working directory
nmap <c-g> :echo expand('%:p:h')<cr>

if has('folding') | set foldmethod=marker foldmarker={{{,}}} | endif

" Mouse {{{2
if has('mouse_xterm')
   set mouse=a
   set ttymouse=xterm2
   set timeoutlen=2000 ttimeoutlen=100
   set ttyscroll=3
   if has('xterm_clipboard')
     " TODO: " yank/delete... operations go to "+ in addition to ""
     " set clipboard^=unnamedplus
     " TODO: set clipboard^=autoselectplus (present in 7.3.597 + go+=P)
     " Vim bug: Only t_te, not t_op, gets sent when leaving an alt screen
   endif
   exe 'set t_te=' . &t_te . &t_op
endif

" Text formating {{{2
set textwidth=80
set formatoptions=croqn
set nojoinspaces

nmap Q gqap

" Tabs and shifting {{{2
set expandtab
set softtabstop=3 tabstop=8
set shiftwidth=3 shiftround

xmap   <tab> >
xmap <s-tab> <
nmap <leader>0 :left<cr>
xmap <leader>0 :left<cr>

" Tags {{{2
set complete-=t complete-=]
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

cabbrev vsb vertical sbuffer
cabbrev svb vertical sbuffer

noremap           <silent> <leader>l      :BufExplorer<cr>
nmap              <c-pageup>              :bprevious<cr>
nmap              <c-pagedown>            :bnext<cr>
imap              <c-pageup>         <c-o>:bprevious<cr>
imap              <c-pagedown>       <c-o>:bnext<cr>
nmap              <c-space>               :b<space>
nnoremap          <c-tab>                 <c-^>
nmap     <silent> <c-w><c-w>              :wincmd p<cr>
nmap     <silent> <c-w>N                  :enew<cr>
nmap     <silent> <c-w>t                  :tabnew<cr>
nmap     <silent> <c-w>e                  :WinFullScreen<cr>
nmap     <silent> <c-w><c-e>              :WinFullScreen<cr>

" Command line {{{2
set wildmenu wildmode=full
set wildignore+=*~,*.swp
if version >= 703 | set wildignorecase | endif
set wildcharm=<c-z> " cmdline: <c-z> in a mapping acts like <tab>
set ruler
set laststatus=2
set history=1000

set statusline=%<%L.\ %t,\ L:%l\ C:%v
   \%{empty(&keymap)?'':'\ <'.b:keymap_name.'>'}\ %r%m
   \%=\%{empty(&filetype)?'':'['.&filetype.']-'}
   \%{&fileformat}\ %P

" Tabline {{{2
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

" Mappings {{{1
" Copy {{{2
function! s:BlockCopy()
   if "\<c-v>" == visualmode()
      normal! gv$y
   else
      normal! gvVy
   endif
endfunction

nmap          Y y$
xmap <silent> Y :<c-u>call <sid>BlockCopy()<cr>

function! s:LineCopy()
   let line =
      \substitute(getline('.'), '^[[:space:]:]\+\|[[:space:]]\+$', '', '')
   call histadd(':', line)
   return line
endfunction

nmap <leader><c-l> :<c-r>=<sid>LineCopy()<cr>

" Help {{{2
nmap          <leader>h      :help <c-r><c-w><cr>
xmap          <leader>h   "*y:help <c-r>*<cr>
nmap <silent> <f1>           :help<bar>only<cr>
imap <silent> <f1>      <c-o>:help<bar>only<cr>

" Moving around {{{2
cnoremap <c-a>         <home>
cnoremap <esc>b        <s-left>
cnoremap <esc>f        <s-right>
cnoremap <m-b>         <s-left>
cnoremap <m-f>         <s-right>
map      <home>        ^
imap     <home>   <c-o>I
imap     <c-up>   <c-o>{
map      <c-up>        {
imap     <c-down> <c-o>}
map      <c-down>      }

" Deletion {{{2
nnoremap <bs>            "_X
map!     <c-bs>          <c-w>
imap     <c-k>      <c-o>D
cmap     <c-k>      <c-f>D<c-c>
cnoremap <esc><bs>       <c-w>
cnoremap <m-bs>          <c-w>
nmap     dl              :%substitute/\_s*\%$<cr>``
imap     <c-del>    <c-o>de
cmap     <c-del>    <c-f>de<c-c>
cnoremap <esc><del> <c-f>de<c-c>
cnoremap <m-del>    <c-f>de<c-c>

" Text-object: file {{{2
nmap          daf :%d<cr>
nmap          yaf :%y<cr>
nmap          caf :%d<cr>i
nmap          vaf ggVG
nmap <silent> =af :Indent<cr>

" Visual selection {{{2
nmap <leader>v      v$h
nmap gV             gvV
nmap g<c-v>         gv<c-v>
nmap <s-up>         Vk
imap <s-up>    <c-o>Vk
vmap <s-up>          k
nmap <s-down>       Vj
imap <s-down>  <c-o>Vj
vmap <s-down>        j
nmap <s-right>      vE
imap <s-right> <c-o>vE
vmap <s-right>       E
nmap <s-left>       vB
imap <s-left>  <c-o>vB
vmap <s-left>        B

" Spell/syntax check {{{2
nmap <f7>   ]s
nmap <s-f7> [s
nmap <f6>   1z=
nmap <f5>   :update<bar>make<cr>

nmap <leader>e   :setlocal spell!   spell?<cr>
nmap <leader>dg  :set      digraph! digraph?<cr>
nmap <leader>kbg :setlocal keymap=bg<cr>
nmap <leader>kfr :setlocal keymap=fr<cr>
nmap <leader>kes :setlocal keymap=es<cr>
nmap <leader>ken :setlocal keymap& spelllang&<cr>

cabbrev trp rtp
cabbrev waq wqa
cabbrev mpa map
cabbrev frm fmr

" In visual-block mode: } selects the current column {{{2
set nostartofline

vnoremap <expr> } mode() == nr2char(22) ? line("'}") - 1 . 'G' : '}'
vnoremap <expr> { mode() == nr2char(22) ? line("'{") + 1 . 'G' : '{'

" [[, ]] work even if the { is not in the first column {{{2
nnoremap <silent> [[ :call search('^[^[:space:]]\@=.*{$', 'besW')<cr>
nnoremap <silent> ]] :call search('^[^[:space:]]\@=.*{$',  'esW')<cr>
onoremap <expr>   [[ (search('^[^[:space:]]\@=.*{$', 'ebsW') &&
   \ (setpos("''  ", getpos('.')) <bar><bar> 1) ? "''" : "\<esc>")
onoremap <expr>   ]] (search('^[^[:space:]]\@=.*{$',  'esW') &&
   \ (setpos("''", getpos('.')) <bar><bar> 1) ? "''" : "\<esc>")

" Filetypes {{{2
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

" Plugin settings {{{1
filetype plugin indent on
syntax enable

let g:UltiSnipsSnippetsDir         = '~/vimfiles/snippets/'
let g:UltiSnipsSnippetDirectories  = ["UltiSnips", "snippets"]
let g:UltiSnipsListSnippets        = "<c-r><tab>"
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let NERDCommentWholeLinesInVMode = 1
let NERDSpaceDelims = 1
map <leader><leader> <plug>NERDCommenterToggle

let g:CSApprox_verbose_level = 1

if &term =~ '^\(xterm\|screen\)$'
   set t_Co=256
endif

set cursorline

colorscheme desertEX

let vim_indent_cont = &shiftwidth

" Disable/enable plugins!
" There seems not to be a way to disable tohtml.vim
let g:loaded_vimballPlugin   = 0
let g:loaded_netrwPlugin     = 1
let g:loaded_zipPlugin       = 1
let g:loaded_tarPlugin       = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_ZoomWin         = 1
let g:loaded_flatfoot        = 1
let loaded_rrhelper          = 1
let loaded_spellfile_plugin  = 1

" Functions {{{1
" Transformations {{{2
" TODO: move to autoload + the 'no lines compressed' doesn't show
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

" Redraw the screen and stop highlighting, remove extra white spaces at EOLs
nnoremap <silent> <c-l> :nohlsearch<bar>
   \call <sid>TransformLines ('del_EOL_spaces')<cr><c-l>

" Squeeze empty lines
nmap <leader>z :call <sid>TransformLines ('squeeze')<cr>

" Paste
xmap [p        "0p
nmap [P        :pu!<cr>
nmap ]P        :pu<cr>
nmap <leader>p :set invpaste paste?<cr>

" Exchange first and last line in a visual area
xmap  <cr> <esc>'<dd'>[pjdd`<P==
xmap ]<cr> <esc>'<dd'>p==
xmap [<cr> <esc>'>dd'<p==
xmap ]t    <esc>'<yy'>p==
xmap [t    <esc>'>yy'<p==

nmap <leader>s :%substitute/<c-r><c-w>//gc<left><left><left>
nmap =<space>  [<space>]<space>
imap <s-cr>    <esc>O
imap <c-cr>    <esc>o

" Scriptnames {{{2
function! s:Scriptnames (filter)
   redir => lines
   let saveMore = &more
   set nomore
   scriptnames
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

command! -nargs=1 Scriptnames call <sid>Scriptnames (<q-args>)

" Ascii {{{2
function! s:Ascii (...)

   if a:0 == 0
      view $HOME/config/vimfiles/ascii
      return
   endif

   let codes =
      \{0:'^@', 9:'^I', 10:'^J (^@)', 13:'^M', 32:'<space>', 127:'<del>',
      \160:'&nbsp'}

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

command! -nargs=* Ascii call <sid>Ascii (<f-args>)
" gm {{{2
function! s:Gm()
   execute 'normal! ^'
   let first_col = virtcol('.')
   execute 'normal! g_'
   let last_col  = virtcol('.')
   execute 'normal! ' . (first_col + last_col) / 2 . '|'
endfunction

nmap <silent> gm :call <sid>Gm()<cr>
omap <silent> gm :call <sid>Gm()<cr>

" Underline {{{2
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

command! -nargs=? Underline call <sid>Underline(<q-args>)
nmap <leader>u :Underline<cr>

" Indent {{{2
function! s:Indent(amount) range

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

command! -nargs=? -range Indent <line1>,<line2> call <sid>Indent(<q-args>)

" Add/Subtract {{{2
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

" Show options {{{2
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

" Highlight text beyond the 80th column {{{2
if version >= 703
   function! s:Toggle_colorcolumn ()
      if empty(&colorcolumn)
         if empty(&textwidth)
            setlocal colorcolumn=81
         else
            setlocal colorcolumn=+1
         endif
         let @/ = '\%81v.*'
      else
         setlocal colorcolumn=
         let @/ = ''
      endif
   endfunction
   nmap <silent> <leader>8 :call <sid>Toggle_colorcolumn()<cr>
endif

" Insert completion {{{2
function! s:Toggle_Longest_Preview(key)
   if a:key == 'f12'
      if &completeopt =~ 'longest'
         set   completeopt-=longest
         set   showfulltag
         echo 'completeopt - longest (User_Account)'
      else
         set   completeopt+=longest
         set   noshowfulltag
         echo 'completeopt + longest (User_)'
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

" Preview window: toggle completeopt's preview
nmap <f4>      :call <sid>Toggle_Longest_Preview('f4')<cr>
imap <f4> <c-o>:call <sid>Toggle_Longest_Preview('f4')<cr>

" Toggle completeopt's longest
nmap <f12>      :call <sid>Toggle_Longest_Preview('f12')<cr>
imap <f12> <c-o>:call <sid>Toggle_Longest_Preview('f12')<cr>

" Commands and autocommands {{{1
if has('autocmd')
   augroup vimrcGrp

      autocmd!

      " Jump to the last spot the cursor was at in a file when reading it
      autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line('$') |
         \ execute 'normal! g`"' |
         \ endif

      " When reading a file, :cd to its parent directory unless it's a help
      " file. This replaces 'autochdir which doesn't work properly.
      autocmd BufEnter * if &filetype != 'help' | silent! cd %:p:h | endif

      " Wrap automatically at 80 chars for plain text files
      autocmd FileType txt,text,svn setlocal formatoptions+=t
         \ autoindent smartindent

   augroup END
endif

command! WriteSudo write !sudo tee % > /dev/null
command! DiffOrig vnew | set buftype=nofile | read# | silent 0delete_ |
   \ diffthis | wincmd p | diffthis

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

nmap <space> :

set exrc
set secure
if version >= 703 | set cryptmethod=blowfish | endif
set modeline
set modelines=3

if filereadable($HOME.'/.vimrc_after') | source $HOME/.vimrc_after | endif

" vim: set foldmethod=marker foldmarker={{{,}}}:
