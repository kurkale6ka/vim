" Author: kurkale6ka <Dimitar Dimitrov>

set all&
set nocompatible

let &runtimepath = substitute(&runtimepath, '\.\zevim', '', 'g')
call pathogen#infect('~/vim/bundle/_my/{}', '~/vim/bundle/{}')

if has('autocmd')
   filetype on
   filetype indent on
   filetype plugin on
endif

if has('syntax')
   syntax enable
endif

"" Backups
set backup
set backupskip=
set backupext=~
set noautowrite
set noautowriteall
set writebackup
set noautoread

if version >= 703
   set undofile
endif

set viminfo='20,<50,s10,h,!

nnoremap gr 999<c-r>
command! Shell silent write !sh

command! Edit  browse edit
command! Write browse write
command! WriteSudo write !sudo tee % > /dev/null

"" Search and replace
set incsearch
set hlsearch
set ignorecase
set smartcase
set infercase

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

"" Encoding
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

"" Alerts and visual feedback
set number
set numberwidth=1
set matchpairs+=<:>
set showmatch
set matchtime=2
" visual bell instead of beeps + disable the visual effect = no flashing at all
set visualbell
set t_vb=
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
nnoremap <c-g> 2<c-g>

nmap <leader>o :call options#show_values(0)<cr>
nmap <leader>O :call options#show_values(1)<cr>

if has('folding')
   set foldnestmax=1
   set foldmethod=marker
   set foldmarker={{{,}}}
endif

if &term =~ '^\(xterm\|screen\)$'
   set t_Co=256
endif

if version < 703
   colorscheme tdefault
else
   if isdirectory($HOME.'/vim/bundle/_my/desertEX') | colorscheme desertEX | endif
   set cursorline
   " Highlight text beyond the 80th column
   nmap <silent> <leader>8 :call highlight#column81()<cr>
endif
match ColorColumn /\%81v./

"" Mouse
if has('mouse_xterm')
   set mouse=a
   set ttymouse=xterm2
   set timeoutlen=2000
   set ttimeoutlen=100
   set ttyscroll=3
   if has('xterm_clipboard')
      " TODO: re-enable when not buggy
      " set clipboard^=unnamedplus " y/d/c go to "" and "+
      " vim selections available in "+ for outside apps. The GUI equivalent is go+=P
      set clipboard^=autoselectplus
   endif
   " Vim bug: Only t_te, not t_op, gets sent when leaving an alt screen
   exe 'set t_te=' . &t_te . &t_op
endif

"" Text formating
set textwidth=80 " TODO
set formatoptions=croqn
set nojoinspaces
set paragraphs=

nmap Q gqap

command! -nargs=? Underline call underline#current(<q-args>)
nmap <leader>u :Underline<cr>

nmap <silent> <leader>z :            call squeeze#lines('')<cr>
vmap <silent> <leader>z :<c-u>silent call squeeze#lines('v')<cr>

" Add empty lines
nmap =<space> [<space>]<space>
imap <s-cr>   <esc>O
imap <c-cr>   <esc>o

"" Tabs and shifting
set expandtab
set softtabstop=3
set tabstop=8
set shiftwidth=3
set shiftround

xmap   <tab>   >
xmap <s-tab>   <
nmap <leader>0 :left<cr>
xmap <leader>0 :left<cr>

"" Tags
set tags+=$HOME/github/tags
set complete-=t
set complete-=]
set completeopt-=preview
set showfulltag

"" Windows and buffers
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

"" Command line
set wildmenu
set wildmode=full
set wildignore+=*~,*.swp,tags
set wildcharm=<c-z> " cmdline: <c-z> in a mapping acts like <tab>

if version >= 703
   set wildignorecase
endif

set ruler
set laststatus=2
set history=7000 " TODO

set statusline=%<%L     " number of lines
set statusline+=\ ❬\ %t " file name (tail)
" RO, modified flag + keymap
set statusline+=%{empty(&ro)\ &&\ empty(&mod)\ &&\ empty(&kmp)?'':'\ '}%r%m%{empty(&kmp)?'':'('.b:keymap_name.')'}
set statusline+=\ ❬\ L:%l\ C:%v
" alternate file
set statusline+=%=%{expand('#:t')\ !=\ expand('%:t')\ &&\ !empty(expand('#:t'))?'#'.expand('#:t').'\ ❭\ ':''}
set statusline+=%{empty(&ft)?'[]-':'['.&ft.']-'}
set statusline+=%{&fileformat}
set statusline+=\ ❭\ %P " percentage through file

" Switch between command line commands
cmap <silent> <c-g> <c-f>:call cmdline#switch('g')<cr>

"" Tabline
set showtabline=1
set tabline=%!tabs#MyTabLine()

"" Security
set exrc
set secure
set modeline
set modelines=3

"" Copy / paste

nmap          Y             y$
xmap <silent> Y             :<c-u>call copy#selection()<cr>
nmap          <leader><c-l> :<c-r>=copy#line()<cr>

" Paste
xmap [p        "0p
nmap [P        :pu!<cr>
nmap ]P        :pu<cr>
nmap <leader>p :set invpaste paste?<cr>

" command! -nargs=? Append call register#append(<f-args>)

"" Help
nmap          <leader>h      :help <c-r><c-w><cr>
xmap          <leader>h   "*y:help <c-r>*<cr>
nmap <silent> <f1>           :help<bar>only<cr>
imap <silent> <f1>      <c-o>:help<bar>only<cr>

"" Moving around
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

nmap <silent> gm :call move#gm()<cr>
omap <silent> gm :call move#gm()<cr>

" Jump to file (A-Z marks) on last position
for nr in range(65, 90)
   " TODO: report issue: when file opened in another Vim instance, g`" not respected
   execute 'nnoremap <silent> `'.nr2char(nr).' :normal! `'.nr2char(nr).'g`"<cr>'
endfor

"" Deletion
inoremap          <c-u>   <c-g>u<c-u>
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
nmap did ^D"_dd

"" Text-object: file
xnoremap af ggVoG
onoremap af :normal vaf<cr>

xnoremap ab <esc>%v%
onoremap ab :silent normal vab<cr>

"" Visual selection
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

"" Spell check
nmap <leader>e :setlocal spell! spell?<cr>
nmap <f7>      ]s
nmap <s-f7>    [s
nmap <f6>      1z=

nmap <silent> gb :call spelllang#bg()<cr>
command! ES setlocal keymap=es
command! FR setlocal keymap=fr
command! BG setlocal keymap=bg
command! RU setlocal keymap=ru

cabbrev trp rtp
cabbrev waq wqa
cabbrev mpa map
cabbrev frm fmr

iabbrev _me Dimitar Dimitrov
iabbrev _mee mitkofr@yahoo.fr

"" In visual-block mode: } selects the current column
set nostartofline

xnoremap <expr> } mode() == '<c-v>' ? line("'}") - 1 . 'G' : '}'
xnoremap <expr> { mode() == '<c-v>' ? line("'{") + 1 . 'G' : '{'

"" [[, ]] work even if the { is not in the first column
nnoremap <silent> [[ :call search('^[^[:space:]]\@=.*{$', 'besW')<cr>
nnoremap <silent> ]] :call search('^[^[:space:]]\@=.*{$',  'esW')<cr>
onoremap <expr>   [[ (search('^[^[:space:]]\@=.*{$', 'ebsW') &&
   \ (setpos("''  ", getpos('.')) <bar><bar> 1) ? "''" : "\<esc>")
onoremap <expr>   ]] (search('^[^[:space:]]\@=.*{$',  'esW') &&
   \ (setpos("''", getpos('.')) <bar><bar> 1) ? "''" : "\<esc>")

"" Add/Subtract
nmap <silent>         <c-a> :<c-u>call number#change('a', 'f')<cr>
nmap <silent> <leader><c-a> :<c-u>call number#change('a', 'b')<cr>
nmap <silent>         <c-x> :<c-u>call number#change('s', 'f')<cr>
nmap <silent> <leader><c-x> :<c-u>call number#change('s', 'b')<cr>

"" Plugin settings
let g:UltiSnipsSnippetsDir         = '~/vim/skel/'
let g:UltiSnipsSnippetDirectories  = ["UltiSnips", "skel"]
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

"" Autocommands, commands and filetype settings
if has('autocmd')
   augroup RC_AUTOCOMMANDS
      autocmd!

      " Jump to the last spot the cursor was at in a file when reading it
      autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line('$') && &filetype != 'gitcommit' |
         \ execute 'normal! g`"' |
         \ endif

      " When reading a file, :cd to its parent directory unless it's a help
      " file. This replaces 'autochdir which doesn't work properly.
      autocmd BufEnter * if &filetype != 'help' | silent! cd %:p:h | endif

      " Delete EOL white spaces
      autocmd BufWritePre * if &ft != 'markdown' | call spaces#remove() | endif

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

command!          RemoveSpaces call  spaces#remove()
command!          Syntax       call  syntax#stack()
command! -nargs=* Ascii        call   ascii#codes(<f-args>)
command! -nargs=+ Scratch      call scratch#buffer(               <f-args>)
command! -nargs=? Scriptnames  call scratch#buffer('scriptnames', <f-args>)

command! DiffOrig vnew | set buftype=nofile | read# | silent 0delete_ |
   \ diffthis | wincmd p | diffthis

nmap <f5> :update<bar>make<cr>

"" Load business specific vimrc
if filereadable($HOME.'/.vimrc_after') | source $HOME/.vimrc_after | endif

" vim: fdm=expr fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-1)\:'='
