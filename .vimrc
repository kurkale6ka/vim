" Author: kurkale6ka <Dimitar Dimitrov>

" Don't reset &runtimepath, if re-sourcing my vimrc
if exists('g:loaded_pathogen') == 0
   set all&
endif

set nocompatible

let &runtimepath = substitute(&runtimepath, '\.\zevim', '', 'g')

execute pathogen#infect('.bundle/{}', 'bundle/{}')

set runtimepath+=~/.fzf

"" Filetype + syntax
filetype on
filetype indent on
filetype plugin on

syntax enable

"" Backups
if empty($SSH_CONNECTION)
   set backup
endif
set backupext=~
set backupskip=

set noautowrite
set noautowriteall
set noautoread

set writebackup

if version >= 703 && empty($SSH_CONNECTION)
   set undofile
endif

nnoremap gr 999<c-r>

set viminfo^=! " save uppercase global variables

"" Search and replace
set incsearch
set hlsearch

set ignorecase
set smartcase
set infercase

" \g for global
nmap <leader>g    :global/<c-r><c-w>/
xmap <leader>g "*y:global/<c-r>*<cr>

" \s for substitute
nmap <leader>s :%substitute/<c-r><c-w>//gc<left><left><left>

" \* and \g* for search highlighting without jumping to the next occurrence
nmap <silent> <leader>* :<c-u>let @/ = '\<'.expand('<cword>').'\>'<bar>set hlsearch<c-m>
xmap <silent> <leader>* :<c-u>let @/ = getreg('*')<bar>set hlsearch<c-m>

nmap <silent> g<leader>* :<c-u>let @/ = expand('<cword>')<bar>set hlsearch<c-m>

" Grepping
set grepprg=command\ grep\ -niE\ --exclude='*~'\ --exclude\ tags\ $*\ /dev/null

" \bg for grepping in buffers
nmap <leader>bg :Bgrep/<c-r><c-w>/<cr>

" Finding
set path+=$HOME/github/**,~/github/zsh/.zsh/**

command! -nargs=+ Find call find#files(<f-args>)

"" Encoding and file formats
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

"" Alerts and visual feedback
set number
set numberwidth=1

set showmatch
set matchtime=2
set matchpairs+=<:>

set confirm
set showcmd
set report=0
set shortmess=flmnrxoOtT
set display+=lastline
set history=7000

set lazyredraw
set scrolloff=2
if ! has('nvim')
   set ttyscroll=3
endif

set timeoutlen=2000 " 2s before timing out a mapping
set ttimeoutlen=100 " 100 ms before timing out on a keypress

" No flashing
set visualbell " visual bell instead of beeps, but...
set t_vb=      " ...disable the visual effect :)

if has('folding')
   set foldnestmax=1 " maximum nesting for indent and syntax
endif

" Ctrl + l: stop highlighting and redraw the screen
nnoremap <silent> <c-l> :nohlsearch<cr><c-l>

" Print working directory
nnoremap <c-g> 2<c-g>

" \o for showing options
nmap <leader>o :call options#show_values(0)<cr>
nmap <leader>O :call options#show_values(1)<cr>

" List view + text wrapping symbols
if &encoding =~ '^u\(tf\|cs\)' " unicode

   let s:arr = nr2char(9655) " U+25B7: ▷
   let s:dot = nr2char(8901) " U+22C5: ⋅

   " ▷⋅⋅⋅ tabs = arrow + dots
   execute 'set listchars=tab:'    .s:arr.s:dot
   execute 'set listchars+=trail:' .s:dot
   execute 'set listchars+=nbsp:'  .s:dot

   set linebreak

   " ↪ at the beginning of wrapped lines
   let &showbreak = nr2char(8618).' '

   set list

   " \<tab> to toggle list display
   nmap <leader><tab> :setlocal invlist list?<cr>
endif

"" Colors and highlighting
if &term =~ '^\(xterm\|screen\)$'
   set t_Co=256
endif

if version < 703
   colorscheme tdefault
else
   if isdirectory($HOME.'/vim/.bundle/desertEX')
      colorscheme desertEX
   endif

   " \8 to highlight text beyond the 80th column
   nmap <silent> <leader>8 :call highlight#column()<cr>
endif

set cursorline

if has('autocmd')
   augroup AUTOCMD_CC
      autocmd!
      autocmd BufEnter,FileType *
         \ if empty(&textwidth) |
         \    match ColorColumn /\%81v./ |
         \ else |
         \    execute 'match ColorColumn /\%'.(&textwidth + 1).'v./' |
         \ endif
   augroup END
endif

command! Syntax call syntax#stack()

set synmaxcol=301

"" Terminal options (including mouse support)
set mouse=a
if ! has('nvim')
   set ttymouse=xterm2
endif

" Bug: Only t_te, not t_op, gets sent when leaving an alt screen
exe 'set t_te=' . &t_te . &t_op

"" Text formating
set formatoptions+=r " auto insert comment with <Enter>...
set formatoptions+=o " ...or o/O
set formatoptions+=n " Recognize numbered lists

if v:version > 703 || v:version == 703 && has("patch541")
   set formatoptions+=j " Delete comment when joining commented lines
endif

nmap Q gqap

set nojoinspaces
set autoindent

" Underline with ---s
command! -nargs=? Underline call underline#current(<q-args>)

" \u to underline
nmap <leader>u :Underline<cr>

" \z to squeeze lines
nmap <silent> <leader>z :            call squeeze#lines('')<cr>
vmap <silent> <leader>z :<c-u>silent call squeeze#lines('v')<cr>

" = + space to surround with empty lines
nmap =<space> [<space>]<space>

" Ctrl + Enter to open a line below in INSERT mode
imap <c-cr> <esc>o
imap <s-cr> <esc>O

"" Tabs and shifting
set tabstop=8
set softtabstop=3
set expandtab

set shiftwidth=3
set shiftround

xmap   <tab> >
xmap <s-tab> <

" \0 to align left
nmap <leader>0 :left<cr>
xmap <leader>0 :left<cr>

"" Tags
set tags+=$HOME/github/tags
set complete-=t
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

" \l for the buffer explorer
noremap <silent> <leader>l :BufExplorer<cr>

" Ctrl + PageUp to go to the previous buffer
nmap <c-pageup>        :bprevious<cr>
nmap <c-pagedown>      :bnext<cr>
imap <c-pageup>   <c-o>:bprevious<cr>
imap <c-pagedown> <c-o>:bnext<cr>

" Ctrl + space to get a listing of buffers
nmap <c-@>     :Buffers<cr>
nmap <c-space> :Buffers<cr>

" Ctrl + tab to switch to the alternate file
nnoremap <c-tab> <c-^>

" Ctrl + w twice to go to the last accessed window
nmap <silent> <c-w><c-w> :wincmd p<cr>

" Ctrl + w, N to create a new buffer over the current one
nmap <silent> <c-w>N :leftabove vnew<cr>

" Ctrl + w, t to create a new tab
nmap <silent> <c-w>t :tabnew<cr>

" Ctrl + w, e to expand the current buffer full screen
nmap <silent> <c-w>e     :WinFullScreen<cr>
nmap <silent> <c-w><c-e> :WinFullScreen<cr>

"" Wild menu & status line
set wildmenu
set wildmode=full
set wildignore+=*~,*.swp,tags
set wildcharm=<c-z> " cmdline: <c-z> in a mapping acts like <tab>

if version >= 703
   set wildignorecase
endif

" Status line
set statusline=%<%L     " number of lines
set statusline+=\ ❬\ %t " file name (tail)

" RO, modified + keymap
set statusline+=%{empty(&ro)\ &&\ empty(&mod)\ &&\ empty(&kmp)?'':'\ '}%r%m%{empty(&kmp)?'':'('.b:keymap_name.')'}

set statusline+=\ ❬\ L:%l\ C:%v " Line:-- Column:--

" alternate file
set statusline+=%=%{expand('#:t')\ !=\ expand('%:t')\ &&\ !empty(expand('#:t'))?'#'.expand('#:t').'\ ❭\ ':''}

set statusline+=%{empty(&ft)?'[]-':'['.&ft.']-'} " ft
set statusline+=%{&fileformat}                   " ff
set statusline+=\ ❭\ %P                          " percentage through file

set laststatus=2

"" Tabline
set showtabline=1
set tabline=%!tabs#MyTabLine()

"" Security
set exrc
set secure " :autocmd, shell and write commands not allowed in CWD .exrc

set modeline
set modelines=3

"" Copy / paste
nmap Y y$
xmap <silent> Y :<c-u>call copy#selection()<cr>

" copy whole line to the command line
cmap <c-r><c-l> <c-r>=copy#line()<cr>

" ^g to copy pattern to "* (:g/pattern -> /pattern...)
cmap <silent> <c-g> <c-f>:call cmdline#switch('g')<cr>

if has('xterm_clipboard')
   " Selections available in "+ for outside apps. The GUI equivalent is go+=P
   set clipboard^=autoselectplus
endif

" TODO: re-enable when not buggy
" if has('xterm_clipboard') || has('gui_running')
"    set clipboard^=unnamedplus " y/d/c go to "" and "+
" endif

" paste over selected text using the previous yank
xmap [p "0p

" paste above/below for small (non whole lines) yanks
nmap [P :pu!<cr>
nmap ]P :pu<cr>

" \p to toggle 'paste
nmap <leader>p :set invpaste paste?<cr>

"" Deletions
nnoremap <bs> "_X

set backspace=indent,eol,start

" \u
inoremap <c-u> <c-g>u<c-u>

" \w
inoremap <c-w> <c-o>dB
cnoremap <c-w> <c-f>dB<c-c>

" Alt + backspace
noremap! <m-bs> <c-w>

" Alt + d
inoremap <m-d> <c-o>de
cnoremap <m-d> <c-f>de<c-c>

" Ctrl + k
imap <c-k> <c-o>D
cmap <c-k> <c-f>D<c-c>

" Delete EOF empty lines
nmap <silent> dl :%substitute/\_s*\%$//<bar>nohlsearch<cr>``

" Delete a whole line to the small register (and "" of course)
nmap did ^D"_dd

command! RemoveSpaces call spaces#remove()

"" Moving around
set virtualedit=all
set whichwrap=b,s,<,>,[,]
set paragraphs= " no wrongly defined paragraphs for non nroff,groff filetypes

cnoremap <c-a> <home>

" <Home> to move to the first char on the line
map  <home> ^
imap <home> <c-o>I
cmap <home> <c-f>^<c-c>

" Ctrl + Up to go backwards by a paragraph
imap <c-up> <c-o>{
map  <c-up>      {

imap <c-down> <c-o>}
map  <c-down>      }

" Enhanced gm
nmap <silent> gm :call move#gm()<cr>
omap <silent> gm :call move#gm()<cr>

" Jump to file (A-Z marks) on last position
for nr in range(65, 90)
   " TODO: report issue: when file opened in another Vim instance, g`" not respected
   execute 'nnoremap <silent> `'.nr2char(nr).' :normal! `'.nr2char(nr).'g`"<cr>'
endfor

" Let [[, ]] work even if the { is not in the first column
nnoremap <silent> [[ :call search('^[^[:space:]]\@=.*{$', 'besW')<cr>
nnoremap <silent> ]] :call search('^[^[:space:]]\@=.*{$',  'esW')<cr>

onoremap <expr> [[
   \ (search('^[^[:space:]]\@=.*{$', 'besW') &&
   \ (setpos("''", getpos('.')) <bar><bar> 1) ? "''" : "\<esc>")

onoremap <expr> ]]
   \ (search('^[^[:space:]]\@=.*{$',  'esW') &&
   \ (setpos("''", getpos('.')) <bar><bar> 1) ? "''" : "\<esc>")

"" Text-object: file
xnoremap af ggVoG
onoremap af :normal vaf<cr>

xnoremap ab <esc>%v%
onoremap ab :silent normal vab<cr>

"" Visual selection
" \v to select to EOL
nmap <leader>v v$h

nmap gV     gvV
nmap g<c-v> gv<c-v>

" Shift + arrows to visually select stuff
nmap <s-up>      Vk
imap <s-up> <c-o>Vk
vmap <s-up>       k

nmap <s-down>      Vj
imap <s-down> <c-o>Vj
vmap <s-down>       j

nmap <s-left>      vB
imap <s-left> <c-o>vB
vmap <s-left>       B

nmap <s-right>      vE
imap <s-right> <c-o>vE
vmap <s-right>       E

" Exchange first and last line in a visual area
xmap <cr> <esc>'<dd'>[pjdd`<P==

" Move the top line of the selection under the bottom one
xmap ]<cr> <esc>'<dd'>p==
xmap [<cr> <esc>'>dd'<p==

" Copy the top line of the selection under the bottom one
xmap ]t <esc>'<yy'>p==
xmap [t <esc>'>yy'<p==

" Let } select the current column only when in visual-block mode
set nostartofline

xnoremap <expr> } mode() == '<c-v>' ? line("'}") - 1 . 'G' : '}'
xnoremap <expr> { mode() == '<c-v>' ? line("'{") + 1 . 'G' : '{'

"" Spell check
" \e to toggle spell errors
nmap <leader>e :setlocal spell! spell?<cr>

nmap <leader>1 1z=
nmap <leader>2 2z=
nmap <leader>3 3z=

nmap <silent> gb :call spelllang#bg()<cr>
command! ES setlocal keymap=es
command! FR setlocal keymap=fr
command! BG setlocal keymap=bg
command! RU setlocal keymap=ru

cabbrev trp rtp
cabbrev waq wqa
cabbrev mpa map
cabbrev frm fmr

iabbrev :me: Dimitar Dimitrov
iabbrev :smirk: ¬_¬
iabbrev :shrug: ¯\_(ツ)_/¯

"" Add/Subtract
nmap <silent>         <c-a> :<c-u>call number#change('a', 'f')<cr>
nmap <silent> <leader><c-a> :<c-u>call number#change('a', 'b')<cr>
nmap <silent>         <c-x> :<c-u>call number#change('s', 'f')<cr>
nmap <silent> <leader><c-x> :<c-u>call number#change('s', 'b')<cr>

set nrformats-=octal

"" Plugin settings
let did_install_default_menus = 1

let g:UltiSnipsSnippetsDir         = '~/vim/ulti_snippets/'
let g:UltiSnipsSnippetDirectories  = ['UltiSnips', 'ulti_snippets']
let g:UltiSnipsListSnippets        = '<c-r><tab>'
let g:UltiSnipsExpandTrigger       = '<tab>'
let g:UltiSnipsJumpForwardTrigger  = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" \\ to toggle comments
map <leader><leader> gcc

if version < 703
   let g:CSApprox_verbose_level = 0
endif

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

" Load matchit.vim, but only if the user hasn't installed a newer version
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
   runtime! macros/matchit.vim
endif

" Disable support for nvim till the next tui upgrade
let g:togglecursor_disable_neovim = 1

if system('grep -zo pangoterm /proc/"$(xdotool getwindowpid "$(xdotool getactivewindow)")"/cmdline') != ''
   let g:togglecursor_force = 'xterm'
endif

"" Autocommands, filetype settings and commands
if has('autocmd')
   augroup AUTOCMDS_ALL
      autocmd!

      " Jump to the last spot the cursor was at in a file when reading it
      autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line('$') && &filetype != 'gitcommit' |
         \    execute 'normal! g`"' |
         \ endif

      " When reading a file, :cd to its parent directory unless it's a help
      " file. This replaces 'autochdir which doesn't work properly.
      autocmd BufEnter *
         \ if &filetype != 'help' |
         \    silent! cd %:p:h |
         \ endif

      " Delete EOL white spaces
      autocmd BufWritePre *
         \ if &filetype != 'markdown' |
         \    call spaces#remove() |
         \ endif

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
nmap <leader>fz :set filetype=zsh<cr>
nmap <leader>fc :set filetype=c<cr>
nmap <leader>fr :set filetype=ruby<cr>

command! -nargs=* Ascii call ascii#codes(<f-args>)
command! NonAscii /[^\d0-\d127]

command! -nargs=1 Count exe('%s/'.<q-args>.'//gn')

command! -nargs=+ Scratch     call scratch#buffer(               <f-args>)
command! -nargs=? Scriptnames call scratch#buffer('scriptnames', <f-args>)

" View changes (not yet saved) to a file since editing it (d_ deletes to "_)
command! DiffOrig
   \ vnew | set bt=nofile | r# | silent 0d_ | diffthis | wincmd p | diffthis

"" Edit and write commands
command! Edit  browse edit
command! Write browse write

command! WriteSudo write !sudo tee % > /dev/null

command! Shell silent write !sh

"" Help
" \h to get help for the word under the cursor
nmap <leader>h    :help <c-r><c-w><cr>
xmap <leader>h "*y:help <c-r>*<cr>

" F1 to get a full screen help window
nmap <silent> <f1>      :help<bar>only<cr>
imap <silent> <f1> <c-o>:help<bar>only<cr>

"" Load business specific vimrc
if filereadable($HOME.'/.vimrc_after')
   source $HOME/.vimrc_after
endif

" vim: fdm=expr fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'"""*')-1)\:'='
