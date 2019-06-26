" Author: kurkale6ka <Dimitar Dimitrov>

" Don't reset &runtimepath, if re-sourcing my vimrc
if !exists('g:loaded_plug')
   " TODO. Fix needed: https://github.com/neovim/neovim/issues/5783
   if !&loadplugins
      if &diff
         set all& noloadplugins diff
      else
         set all& noloadplugins
      endif
   elseif &diff
      set all& diff
   else
      set all&
   endif
endif

set nocompatible

"" Setup
if !empty($REPOS_BASE)
   let s:vim = $REPOS_BASE.'/vim'
   execute 'let &runtimepath = substitute(&runtimepath, expand("~")."/\\.vim", "'.s:vim.'", "g")'
elseif has('nvim')
   let s:vim = $XDG_CONFIG_HOME.'/nvim'
else
   let s:vim = '~/.vim'
endif

if has('nvim')
   let $MYVIMRC = s:vim.'/init.vim'
else
   let $MYVIMRC = s:vim.'/.vimrc'
endif

if empty($SSH_CONNECTION)
   call system("who | 'grep' -q '([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\})'")
   if v:shell_error
      let s:local_vim = 1
   endif
endif

let mapleader = "\<space>"

"" Filetype + syntax
" filetype ... on and syntax enable get auto executed by vim-plug
" filetype plugin indent on
" syntax enable

" Syntax based omni completion
if has('autocmd') && exists('+omnifunc')
   autocmd Filetype *
      \ if empty(&omnifunc)                          |
      \    setlocal omnifunc=syntaxcomplete#Complete |
      \ endif
endif

"" Plugins
if version >= 703 && (!exists('+termguicolors') || $TERM =~ '^screen\%($\|\.[^s]\)') && $TERM !~ 'linux'
   let s:csapprox_needed = 1
endif

silent! call plug#begin(s:vim.'/plugged')
execute "Plug '".s:vim."/plugged/bufgrep', { 'on': 'Bgrep' }"
execute "Plug '".s:vim."/plugged/unicodename', { 'on': 'UnicodeName' }"
execute "Plug '".s:vim."/plugged/vsearch'"
execute "Plug '".s:vim."/plugged/win_full_screen', { 'on': 'WinFullScreen' }"
let g:plug_url_format = 'git@github.com:%s.git'
Plug 'kurkale6ka/vim-blockinsert'
Plug 'kurkale6ka/vim-chess'
Plug 'kurkale6ka/vim-desertEX'
Plug 'kurkale6ka/vim-pairs'
Plug 'kurkale6ka/vim-swap'
unlet g:plug_url_format
Plug 'tpope/vim-abolish' ", { 'on': ['Abolish', 'Subvert', 'S'] }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
if exists('s:csapprox_needed')
Plug 'godlygeek/csapprox'
endif
Plug 'pearofducks/ansible-vim'
Plug 'rodjek/vim-puppet'
Plug 'justinmk/vim-dirvish'
Plug 'terceiro/vim-foswiki'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/iptables'
Plug 'elzr/vim-json'
Plug 'bfredl/nvim-miniyank', has('nvim') ? {} : { 'on': [] }
Plug 'neomake/neomake'
Plug 'vim-scripts/nginx.vim'
Plug 'StanAngeloff/php.vim'
Plug 'tmux-plugins/vim-tmux'
if $TERM !~ 'linux' " disable in the vconsole
Plug 'jszakmeister/vim-togglecursor'
endif
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

let did_install_default_menus = 1

let g:UltiSnipsEnableSnipMate      = 0
let g:UltiSnipsSnippetsDir         = s:vim.'/ulti_snippets/'
let g:UltiSnipsSnippetDirectories  = ['ulti_snippets', 'UltiSnips']
let g:UltiSnipsListSnippets        = '<c-r><tab>'
let g:UltiSnipsExpandTrigger       = '<tab>'
let g:UltiSnipsJumpForwardTrigger  = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

let g:sleuth_automatic = 0

if exists('s:csapprox_needed')
   let g:CSApprox_verbose_level = 0
endif

let g:gitgutter_signs = 0

" Disable these plugins
let g:loaded_2html_plugin    = 1
let g:loaded_vimballPlugin   = 1
let g:loaded_netrwPlugin     = 1
let g:loaded_zipPlugin       = 1
let g:loaded_tarPlugin       = 1
let g:loaded_getscriptPlugin = 1
let loaded_rrhelper          = 1
let loaded_spellfile_plugin  = 1

" Load matchit.vim, but only if the user hasn't installed a newer version
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
   runtime! macros/matchit.vim
endif

" Neomake
let g:neomake_warning_sign = { 'text': 'W', 'texthl': 'WarningMsg' }
let g:neomake_error_sign   = { 'text': 'E', 'texthl': 'ErrorMsg'   }

let g:neomake_puppet_puppetlint_maker = {
   \ 'exe': 'puppet-lint',
   \ 'args': ['--log-format', '"%{path}:%{line}:%{column}:%{kind}:[%{check}] %{message}"', '--no-variables_not_enclosed-check', '--no-2sp_soft_tabs-check', '--no-only_variable_string-check', '--no-80chars-check'],
   \ 'errorformat': '"%f:%l:%c:%t%*[a-zA-Z]:%m"',
   \ }

let g:vim_json_syntax_conceal = 0
let g:ansible_attribute_highlight = "ab"

"" Backups
if exists('s:local_vim')
   set backup
elseif has('writebackup')
   set writebackup
endif
set backupext=~
set backupskip=

set noautowrite
set noautowriteall
set noautoread

if exists('s:local_vim') && has('persistent_undo')
   set undofile
endif

nnoremap gr :later 9999<cr>

set history=10000
if !has('nvim')
   set viminfo=!,'1000
   execute 'set viminfo+=n'.s:vim.'/.viminfo'
else
   set shada='1000
endif

"" Search and replace
set incsearch
set hlsearch

set ignorecase
set smartcase
set infercase

" \g for global
nmap <leader>g    :g/<c-r><c-w>/
xmap <leader>g "*y:g/<c-r>*<cr>

" \s for substitute
nmap <leader>s :%s/<c-r><c-w>//g<left><left>

" \* and \g* for search highlighting without jumping to the next occurrence
nmap <silent> <leader>* :<c-u>let @/ = '\<'.expand('<cword>').'\>'<bar>set hlsearch<c-m>
xmap <silent> <leader>* :<c-u>let @/ = getreg('*')<bar>set hlsearch<c-m>

nmap <silent> g<leader>* :<c-u>let @/ = expand('<cword>')<bar>set hlsearch<c-m>

if exists('+inccommand')
   set inccommand=nosplit
endif

cabbrev <expr> es getcmdtype() == ':' ? 'e%:p:s/'.abbreviations#eat_char('\s') : 'es'

" Grepping
set grepprg=command\ grep\ -niE\ --exclude='*~'\ --exclude\ tags\ $*\ /dev/null

" Finding
if !empty($REPOS_BASE)
   execute 'set path+='.$REPOS_BASE.'/**'
endif
if !empty($XDG_CONFIG_HOME)
   execute 'set path+='.$XDG_CONFIG_HOME.'/zsh/**'
endif

command! -nargs=+ Find call find#files(<f-args>)

"" Encoding and file formats
if !has('nvim')
   if has('multi_byte') && &encoding !~? 'utf-\=8'
      if empty(&termencoding)
         let &termencoding = &encoding
      endif
      set encoding=utf-8
   endif
endif

set fileencodings=ucs-bom,utf-8,default,cp1251,latin1
set fileformats=unix,mac,dos

set isfname-==

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

set lazyredraw
set scrolloff=2
if !has('nvim')
   set ttyscroll=3
endif

set timeoutlen=2000 " 2s before timing out a mapping
set ttimeoutlen=100 " 100 ms before timing out on a keypress

" No flashing
set visualbell " visual bell instead of beeps, but...
if !has('nvim')
   set t_vb= " ...disable the visual effect :)
endif

if has('folding')
   set foldnestmax=1 " maximum nesting for indent and syntax
   cabbrev <expr> fold getcmdtype() == ':' ? "se fdm=expr fde=getline(v\\:lnum)=~'^\\\\s*##'?'>'.(len(matchstr(getline(v\\:lnum),'###*'))-1)\\:'='".abbreviations#eat_char('\s') : 'fold'
   cabbrev foldx se fdm=expr fde=getline(v\:lnum)=~'<'?'>1'\:'='<left><left><left><left><left><left><left><left><left><left><left><c-r>=abbreviations#eat_char('\s')<cr>
endif

" Ctrl + l: stop highlighting and redraw the screen
nnoremap <silent> <c-l> :nohlsearch<cr><c-l>

" Print working directory
nnoremap <c-g> 2<c-g>

" \o for showing options
nmap <leader>o :call options#show_values(0)<cr>
nmap <leader>O :call options#show_values(1)<cr>

set linebreak " wrap at characters in 'breakat
if v:version > 704 || v:version == 704 && has('patch338')
   set breakindent " respect indentation when wrapping
endif

" When to enable unicode characters
if ($TERM !~ 'linux' &&
 \    (has('nvim') ||
 \       (&enc =~? '^u\(tf\|cs\)' &&
 \          (empty(&tenc) || &tenc ==? &enc || &tenc ==? 'macroman')
 \       )
 \    )
 \ ) || has('gui_running')
   let s:unicode_chars = 1
endif

if exists('s:unicode_chars')

   let &showbreak = nr2char(8618).' ' " U+21AA ↪

   let s:arr = nr2char(9655) " U+25B7: ▷
   let s:dot = nr2char(8901) " U+22C5: ⋅

   " Show tabs as ▷⋅⋅⋅ and spaces as ⋅ in list view
   execute 'set listchars=tab:'    .s:arr.s:dot
   execute 'set listchars+=trail:' .s:dot
   execute 'set listchars+=nbsp:'  .s:dot
else
   let &showbreak = '\ '
   set listchars=tab:>-,trail:-,nbsp:-
endif

if exists('s:local_vim')
   if &readonly || !&modifiable
      setlocal nolist
   else
      setlocal list
   endif
endif

"" Colors and highlighting
if !has('nvim') && $TERM !~ 'linux' && &term =~ '^\(xterm\|screen\)$'
   set t_Co=256
endif

if exists('+termguicolors') && $TERM !~ 'linux\|^screen\%($\|\.[^s]\)' && $TERM_PROGRAM != 'Apple_Terminal'
   " tmux Vim-specific sequences for RGB colors
   if !has('nvim')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
   endif
   set termguicolors
endif

if version < 703
   colorscheme tdefault
else
   colorscheme desertEX

   " \8 to highlight text beyond the 80th column
   nmap <silent> <leader>8 :call highlight#column()<cr>
endif

if !&diff
   set cursorline
endif

if has('autocmd') && !&diff
   autocmd BufEnter,FileType *
      \ if expand('<afile>:e') != 'log'                              |
      \    if empty(&textwidth)                                      |
      \       match ColorColumn /\%81v./                             |
      \    else                                                      |
      \       execute 'match ColorColumn /\%'.(&textwidth + 1).'v./' |
      \    endif                                                     |
      \ endif
endif

command! Syntax call syntax#stack()

set synmaxcol=301

"" Terminal options (including mouse support)
set mouse=a
if !has('nvim')
   set ttymouse=xterm2
endif

if !has('nvim')
   " TODO. Bug: Only t_te, not t_op, gets sent when leaving an alt screen
   exe 'set t_te=' . &t_te . &t_op
endif

"" Text formating
set formatoptions+=r " auto insert comment with <Enter>...
set formatoptions+=o " ...or o/O
set formatoptions+=n " Recognize numbered lists

if v:version > 703 || v:version == 703 && has('patch541')
   set formatoptions+=j " Delete comment when joining commented lines
endif

nmap Q gqap

set nojoinspaces
set autoindent
set commentstring=#%s

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
if !empty($REPOS_BASE)
   execute 'set tags+='.$REPOS_BASE.'/tags'
endif
set complete-=t
set completeopt-=preview
set showfulltag

" list autoload tags
nmap <leader>t :ta *\#<c-d>

"" Windows and buffers
set hidden
set diffopt+=vertical,iblank,iwhiteall
set noequalalways
set splitright

if version < 700
   set switchbuf=useopen
else
   set switchbuf=useopen,usetab
endif

cabbrev vsb vertical sbuffer
cabbrev svb vertical sbuffer

" Ctrl + PageUp to go to the previous buffer
nmap <c-pageup>        :bprevious<cr>
nmap <c-pagedown>      :bnext<cr>
imap <c-pageup>   <c-o>:bprevious<cr>
imap <c-pagedown> <c-o>:bnext<cr>

" List buffers
nmap <leader>b :ls<cr>:b<space>

" Recently edited files
nmap <expr> <leader>r ':filter /'.input('Hist> ').'/ oldfiles<cr>'

" Ctrl + tab or space to switch to the alternate file
nnoremap <c-tab> <c-^>
nnoremap <space>- <c-^>

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

if exists('+wildignorecase')
   set wildignorecase
endif

" Status line
if exists('s:unicode_chars')
   set statusline=%!statusline#init('❬',\ '❭')
else
   set statusline=%!statusline#init('<',\ '>')
endif

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

" Ctrl + g to copy pattern to "* (:g/pattern -> /pattern...)
cmap <silent> <c-g> <c-f>:call cmdline#switch('g')<cr>

" has('nvim') || " TODO. Still in development
if has('xterm_clipboard')
   " Selection available for pasting with <c-v> outside of vim (GUI's go+=P)
   set clipboard^=autoselectplus
endif

if has('nvim') || has('xterm_clipboard') || has('gui_running')
   " y/d/c available for pasting with <c-v> outside of vim
   set clipboard^=unnamedplus
endif

" paste over selected text using the previous yank
xmap [p "0p

" paste above/below for small (non whole lines) yanks
nmap [P :pu!<cr>
nmap ]P :pu<cr>

"" Visual swap/move/copy
" Exchange first and last line in a visual area
xmap <cr> <esc>'<dd'>[pjdd`<P==

" Move the top line of the selection under the bottom one
xmap ]<cr> <esc>'<dd'>p==
xmap [<cr> <esc>'>dd'<p==

" Copy the top line of the selection under the bottom one
xmap ]t <esc>'<yy'>p==
xmap [t <esc>'>yy'<p==

"" Deletions
nnoremap <bs> "_X

set backspace=indent,eol,start

" Ctrl + u
inoremap <c-u> <c-g>u<c-u>

" Ctrl + w
cnoremap <c-w> <c-\>ecmdline#ctrl_w()<cr>
inoremap <c-w> <c-o>dB

" Alt + backspace
noremap! <m-bs> <c-w>

" Alt + d
if has('nvim') || has('gui_running')
   cnoremap <m-d> <c-\>ecmdline#alt_d()<cr>
   inoremap <m-d> <c-o>de
endif

" Ctrl + k
imap <c-k> <c-o>D
cmap <c-k> <c-\>estrpart(getcmdline(), 0, getcmdpos() - 1)<cr>

" Delete EOF empty lines
nmap <silent> dl :call spaces#remove_eof()<cr>

" Delete a whole line to the small register (and "" of course)
nmap did ^D"_dd

command! RemoveSpaces call spaces#remove()

"" Moving around
set virtualedit=block

set whichwrap=b,s,<,>,[,]
set paragraphs= " no wrongly defined paragraphs for non nroff,groff filetypes

cnoremap <c-a> <home>

" <Home> to move to the first char on the line
map  <home> ^
imap <home> <c-o>I

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

" Let } select the current column only when in visual-block mode
set nostartofline

xnoremap <expr> } mode() == '<c-v>' ? line("'}") - 1 . 'G' : '}'
xnoremap <expr> { mode() == '<c-v>' ? line("'{") + 1 . 'G' : '{'

"" Spell check
nmap <leader>1 1z=
nmap <leader>2 2z=

nmap <leader>l :setlocal keymap=

cabbrev trp rtp
cabbrev waq wqa
cabbrev frm fmr

iabbrev _me Dimitar Dimitrov<c-r>=abbreviations#eat_char('\s')<cr>
iabbrev _date <c-r>=strftime('%a, %d %b %Y')<cr><c-r>=abbreviations#eat_char('\s')<cr>

"" Add/Subtract
nmap <silent>         <c-a> :<c-u>call number#change('a', 'f')<cr>
nmap <silent> <leader><c-a> :<c-u>call number#change('a', 'b')<cr>
nmap <silent>         <c-x> :<c-u>call number#change('s', 'f')<cr>
nmap <silent> <leader><c-x> :<c-u>call number#change('s', 'b')<cr>

set nrformats-=octal

"" Autocommands, filetype settings and commands
if has('autocmd')
   " Jump to the last spot the cursor was at in a file when reading it
   autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line('$') && &filetype != 'gitcommit' |
      \    execute 'normal! g`"'                                                   |
      \ endif

   " When reading a file, :cd to its parent directory unless it's a help
   " file. This replaces 'autochdir which doesn't work properly.
   autocmd BufEnter *
      \ if &filetype != 'help' |
      \    silent! cd %:p:h    |
      \ endif

   if exists('s:local_vim')
      " Delete EOL white spaces
      autocmd BufWritePre *
         \ if &filetype != 'markdown' |
         \    call spaces#remove()    |
         \ endif
   endif
endif

" Set 'ft
nmap <leader>f :se ft=

command! -nargs=* Ascii call ascii#codes(<f-args>)
command! NonAscii /[^\d0-\d127]

command! -nargs=1 Count exe('%s/'.<q-args>.'//gn')

command! -nargs=+ Scratch     call scratch#buffer(               <f-args>)
command! -nargs=? Scriptnames call scratch#buffer('scriptnames', <f-args>)

" View changes (not yet saved) to a file since editing it (d_ deletes to "_)
command! DiffOrig
   \ vnew | set bt=nofile | r# | silent 0d_ | diffthis | wincmd p | diffthis

"" Edit and write commands
nmap <leader>e :e
cabbrev <expr> eh getcmdtype() == ':' ? 'e~/'.abbreviations#eat_char('\s') : 'eh'

command! Edit  browse edit
command! Write browse write

" TODO. Still in development
command! WriteSudo write !sudo tee % >/dev/null

command! Shell silent write !sh

"" Help
if !empty($REPOS_BASE)
   " \h to access custom documentation
   nmap <expr> <leader>h ':e'.fnamemodify($REPOS_BASE.'/help/', ':~')
endif

" F1 to get a full screen help window
nmap <silent> <f1>      :h<bar>only<cr>
imap <silent> <f1> <c-o>:h<bar>only<cr>

"" Load business specific vimrc
if filereadable(expand(s:vim.'/.vimrc_after'))
   execute 'source '.s:vim.'/.vimrc_after'
endif

" vim: fdm=expr fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'"""*')-1)\:'='
