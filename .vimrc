" Author: Dimitar Dimitrov
"         mitkofr@yahoo.fr
"         kurkale6ka

set nocompatible
call pathogen#infect()
filetype plugin indent on
syntax enable

" Options {{{1
" Backups {{{2
set backup backupskip= backupext=~
set noautowrite noautowriteall
set writebackup
set noautoread
if version >= 703 | set undofile | endif
set viminfo='20,<50,s10,h,!

command! WriteSudo write !sudo tee % > /dev/null

" Search and replace {{{2
set incsearch hlsearch
set ignorecase smartcase infercase

" Stop highlighting and redraw the screen
nnoremap <silent> <c-l> :nohlsearch<cr><c-l>

nmap <leader>g     :global/<c-r><c-w>/
xmap <leader>g  "*y:global/<c-r>*<cr>
nmap <leader>bg    :Bgrep/<c-r><c-w>/<cr>

nmap <leader>s :%substitute/<c-r><c-w>//gc<left><left><left>
nmap gc *Ncgn
nmap gC #ncgn

set grepprg=command\ grep\ -niE\ --exclude='*~'\ --exclude\ tags\ $*\ /dev/null
set path+=$HOME/github/**

command! -nargs=+ Find call find#files(<f-args>)

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
set number numberwidth=1
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

if has('folding')
   set foldnestmax=1
   set foldmethod=marker foldmarker={{{,}}}
endif

if &term =~ '^\(xterm\|screen\)$'
   set t_Co=256
endif

if version < 703
   colorscheme tdefault
else
   if isdirectory($HOME.'/.vim/bundle/desertEx') | colorscheme desertEX | endif
   set cursorline
endif

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
set textwidth=80 " TODO
set formatoptions=croqn
set nojoinspaces
set paragraphs=

nmap Q gqap

" Tabs and shifting {{{2
set expandtab
set softtabstop=3 tabstop=8
set shiftwidth=3 shiftround

xmap   <tab>   >
xmap <s-tab>   <
nmap <leader>0 :left<cr>
xmap <leader>0 :left<cr>

" Tags {{{2
set tags+=$HOME/github/tags
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
nmap              <c-space>               :ls<cr>:buffer<space>
nnoremap          <c-tab>                 <c-^>
nmap     <silent> <c-w><c-w>              :wincmd p<cr>
nmap     <silent> <c-w>N                  :enew<cr>
nmap     <silent> <c-w>t                  :tabnew<cr>
nmap     <silent> <c-w>e                  :WinFullScreen<cr>
nmap     <silent> <c-w><c-e>              :WinFullScreen<cr>

" Command line {{{2
set wildmenu wildmode=full
set wildignore+=*~,*.swp,tags
if version >= 703 | set wildignorecase | endif
set wildcharm=<c-z> " cmdline: <c-z> in a mapping acts like <tab>
set ruler
set laststatus=2
set history=11111 " TODO

set statusline=%<%L.\ %t,\ L:%l\ C:%v
   \%{empty(&keymap)?'':'\ <'.b:keymap_name.'>'}\ %r%m
   \%=\%{empty(&filetype)?'':'['.&filetype.']-'}
   \%{&fileformat}\ %P

" Switch between command line commands
" Note: switch is not functional yet, all it does is copy the pattern in "*
function! s:cmd_switch(c)
   normal! 0
   " Copy the pattern of a :s/pattern or :g/pattern
   if search('^\s*\%(g\%[lobal]\|s\%[ubstitute]\)/[^/]', 'e', line('.'))
      if search('/', 'n', line('.'))
         execute 'normal! "*yt/'
      else
         execute 'normal! "*y$'
      endif
   " Copy the pattern of a /
   else
      execute 'normal! "*y$'
   endif
   quit
   " Scenarios: /regex<c-g>      => I intended to use :g/regex   Vs a search
   "            :g/regex<c-r>    => I intended to use :s/regex// Vs :g/regex
   "            :s/old/new/<c-/> => I intended to use /regex     Vs a substitute
   " if a:c == 'g'
   "    " execute 'global/'.getreg('*')
   " elseif a:c == 'r'
   "    " execute 'substitute/'.getreg('*')."//gc\<left>\<left>\<left>"
   " else
   "    " let @/ = getreg('*')
   "    " execute '/'.getreg('*')
   " endif
endfunction
cmap <silent> <c-g> <c-f>:call <sid>cmd_switch('g')<cr>
" cmap <silent> <c-s> <c-f>:call <sid>cmd_switch('r')<cr>
" cmap <silent> <c-/> <c-f>:call <sid>cmd_switch('s')<cr>

" Tabline {{{2
set showtabline=1
set tabline=%!tabs#MyTabLine()

" Security {{{2
set exrc
set secure
if version >= 703 | set cryptmethod=blowfish | endif
set modeline
set modelines=3

" Mappings {{{1
" Copy / paste {{{2

nmap          Y y$
xmap <silent> Y :<c-u>call copy#selection()<cr>

nmap <leader><c-l> :<c-r>=copy#line()<cr>

" Paste
xmap [p        "0p
nmap [P        :pu!<cr>
nmap ]P        :pu<cr>
nmap <leader>p :set invpaste paste?<cr>

" Help {{{2
nmap          <leader>h      :help <c-r><c-w><cr>
xmap          <leader>h   "*y:help <c-r>*<cr>
nmap <silent> <f1>           :help<bar>only<cr>
imap <silent> <f1>      <c-o>:help<bar>only<cr>

" Moving around {{{2
noremap! <m-b>         <s-left>
noremap! <m-f>         <s-right>
noremap! <m-left>      <s-left>
noremap! <m-right>     <s-right>
map      <home>        ^
imap     <home>   <c-o>I
cmap     <home>   <c-f>^<c-c>
cnoremap <c-a>         <home>
imap     <c-up>   <c-o>{
imap     <m-up>   <c-o>{
map      <c-up>        {
map      <m-up>        {
imap     <c-down> <c-o>}
imap     <m-down> <c-o>}
map      <c-down>      }
map      <m-down>      }

nnoremap j      gj
nnoremap <Down> gj
nnoremap k      gk
nnoremap <up>   gk
nnoremap gr 999<c-r>

" Jump to file (A-Z marks) on last position
for nr in range(65, 90)
   " TODO: report issue: when file open elsewhere, g`" not respected
   execute 'nnoremap <silent> `'.nr2char(nr).' :normal! `'.nr2char(nr).'g`"<cr>'
endfor

" Deletion {{{2
inoremap          <c-w>   <c-o>dB
cnoremap          <c-w>   <c-f>dB<c-c>
nnoremap          <bs>         "_X
noremap!          <c-bs>  <c-w>
noremap!          <m-bs>  <c-w>
imap              <c-k>   <c-o>D
cmap              <c-k>   <c-f>D<c-c>
nmap     <silent> dl           :%substitute/\_s*\%$//<bar>nohlsearch<cr>``
imap              <c-del> <c-o>de
imap              <m-del> <c-o>de
cmap              <c-del> <c-f>de<c-c>
cmap              <m-del> <c-f>de<c-c>

" Text-object: file {{{2
xnoremap af ggVoG
onoremap af :normal vaf<cr>

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

" Exchange first and last line in a visual area
xmap  <cr> <esc>'<dd'>[pjdd`<P==
xmap ]<cr> <esc>'<dd'>p==
xmap [<cr> <esc>'>dd'<p==
xmap ]t    <esc>'<yy'>p==
xmap [t    <esc>'>yy'<p==

" Spell check {{{2
nmap <leader>e :setlocal spell! spell?<cr>
nmap <f7>      ]s
nmap <s-f7>    [s
nmap <f6>      1z=

nmap <leader>dg :set digraph! digraph?<cr>

nmap <silent> gb :call spelllang#bg()<cr>
command! ES setlocal keymap=es
command! FR setlocal keymap=fr
command! BG setlocal keymap=bg
command! RU setlocal keymap=ru

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

" Plugin settings {{{1
let g:UltiSnipsSnippetsDir         = '~/vim/snippets/'
let g:UltiSnipsSnippetDirectories  = ["UltiSnips", "snippets"]
let g:UltiSnipsListSnippets        = "<c-r><tab>"
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let NERDSpaceDelims = 1
let NERDCommentWholeLinesInVMode = 1
map <leader><leader> <plug>NERDCommenterToggle

if version < 703 | let g:CSApprox_verbose_level = 0 | endif

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
" Squeeze empty lines (TODO: remove entries from / history) {{{2
function! s:Squeeze()
   let save_cursor = getpos('.')
   " empty lines at BOF|EOF
   silent  %substitute/\%^\_s*\n\|\_s*\%$//
   " empty line clusters
   silent   global/^\%(\s*$\n\)\{2,}/delete
   silent! %substitute/\s\+$//e
   call setpos('.', save_cursor)
endfunction

nmap <silent> <leader>z :call <sid>Squeeze()<cr>

" Add empty lines
nmap =<space> [<space>]<space>
imap <s-cr>   <esc>O
imap <c-cr>   <esc>o

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

" Autocommands, commands and filetype settings {{{1
if has('autocmd')
   augroup POSITION
      autocmd!
      " Jump to the last spot the cursor was at in a file when reading it
      autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line('$') && &filetype != 'gitcommit' |
         \ execute 'normal! g`"' |
         \ endif

      " When reading a file, :cd to its parent directory unless it's a help
      " file. This replaces 'autochdir which doesn't work properly.
      autocmd BufEnter * if &filetype != 'help' | silent! cd %:p:h | endif
   augroup END
   augroup FILETYPE
      autocmd!
      " Wrap automatically at 80 chars for plain text files
      autocmd FileType txt,text,svn setlocal formatoptions+=t autoindent smartindent
      autocmd FileType nroff,groff setlocal paragraphs='IPLPPPQPP TPHPLIPpLpItpplpipbp'
      autocmd FileType gitcommit execute 'goto|setlocal spell foldmethod&|startinsert'
      autocmd FileType vim setlocal keywordprg=:help
      autocmd FileType json command -range=% -nargs=* Tidy <line1>,<line2>! python -mjson.tool
      autocmd FileType html,xml command -range=% -nargs=* Tidy <line1>,<line2>! xmllint --format --recover - 2>/dev/null
   augroup END
endif

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

let vim_indent_cont = &shiftwidth

command! -nargs=? Underline call underline#current(<q-args>)
nmap <leader>u :Underline<cr>

command! -nargs=+ Scratch     call scratch#buffer(               <f-args>)
command! -nargs=? Scriptnames call scratch#buffer('scriptnames', <f-args>)

nmap <f5> :update<bar>make<cr>

command! -nargs=* Ascii call ascii#codes(<f-args>)

command! DiffOrig vnew | set buftype=nofile | read# | silent 0delete_ |
   \ diffthis | wincmd p | diffthis

" Load business specific vimrc }}}1
if filereadable($HOME.'/.vimrc_after') | source $HOME/.vimrc_after | endif

" vim: set foldmethod=marker foldmarker={{{,}}}:
