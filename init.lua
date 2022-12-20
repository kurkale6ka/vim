vim.g.mapleader = ' '
vim.g.python3_host_prog = '~/py-envs/utils/bin/python'

vim.o.termguicolors = true
vim.o.number = true

vim.o.writebackup = true
vim.o.backupext = '~'
-- ?
vim.o.backupskip = ''

vim.o.autowrite = false
vim.o.autowriteall = false
vim.o.autoread = false

vim.keymap.set('n', '<leader>-', '<c-^>')
vim.keymap.set('n', '<leader>w', ':w<cr>')
vim.keymap.set('n', '<leader>e', ':e')

vim.o.undofile = true
vim.o.history = 10000
vim.o.shada = "'1000"

vim.keymap.set('n', 'gr', ':later 9999<cr>')

-- Search and replace
vim.o.incsearch  = true
vim.o.hlsearch   = true
vim.o.ignorecase = true
vim.o.smartcase  = true
vim.o.infercase  = true

-- Disable these plugins
vim.g.loaded_2html_plugin       = true
vim.g.loaded_vimballPlugin      = true
vim.g.loaded_netrwPlugin        = true
vim.g.loaded_zipPlugin          = true
vim.g.loaded_tarPlugin          = true
vim.g.loaded_getscriptPlugin    = true
vim.g.did_install_default_menus = true
vim.g.loaded_rrhelper           = true
vim.g.loaded_spellfile_plugin   = true

vim.cmd 'colorscheme desertEX'

-- TODO: set includeexpr for gf
require('plugins')
require('plugins/tree-sitter')
require('plugins/fern')
require('plugins/ultisnips')
require('plugins/fugitive')
require('statusline')

vim.o.grepprg = 'rg --column --line-number --no-heading --vimgrep --smart-case --hidden'
vim.o.fileencodings = 'ucs-bom,utf-8,default,cp1251,latin1'
vim.o.fileformats = 'unix,mac,dos'
-- vim.o.isfname-==
-- vim.o.number
-- vim.o.numberwidth=1
-- vim.o.showmatch
-- vim.o.matchtime=2
-- vim.o.matchpairs+=<:>
-- vim.o.confirm
-- vim.o.showcmd
-- vim.o.report=0
-- vim.o.shortmess=flmnrxoOtT
-- vim.o.display+=lastline
-- vim.o.lazyredraw
-- vim.o.scrolloff=2
-- vim.o.timeoutlen=2000 -- 2s before timing out a mapping
-- vim.o.ttimeoutlen=100 -- 100 ms before timing out on a keypress
-- vim.o.visualbell -- visual bell instead of beeps, but...
-- vim.o.linebreak -- wrap at characters in 'breakat
-- vim.o.synmaxcol=301
-- vim.o.mouse=a
-- vim.o.mousemodel=extend
-- vim.o.formatoptions+=r -- auto insert comment with <Enter>...
-- vim.o.formatoptions+=o -- ...or o/O
-- vim.o.formatoptions+=n -- Recognize numbered lists
-- vim.o.nojoinspaces
-- vim.o.autoindent
-- vim.o.commentstring=#%s
-- vim.o.tabstop=8
-- vim.o.softtabstop=3
-- vim.o.expandtab
-- vim.o.shiftwidth=4
-- vim.o.shiftround
-- vim.o.complete-=t
-- vim.o.completeopt-=preview
-- vim.o.showfulltag
-- vim.o.hidden
-- vim.o.noequalalways
-- vim.o.splitright
-- vim.o.wildmenu
-- vim.o.wildmode=full
-- vim.o.wildignore+=*~,*.swp,tags
-- vim.o.wildcharm=<c-z> -- cmdline: <c-z> in a mapping acts like <tab>
-- vim.o.laststatus=2
-- vim.o.showtabline=1
-- vim.o.tabline=%!tabs#MyTabLine()
-- vim.o.exrc
-- vim.o.secure -- :autocmd, shell and write commands not allowed in CWD .exrc
-- vim.o.modeline
-- vim.o.modelines=3
-- vim.o.backspace=indent,eol,start
-- vim.o.virtualedit=block
-- vim.o.whichwrap=b,s,<,>,[,]
-- vim.o.paragraphs= -- no wrongly defined paragraphs for non nroff,groff filetypes
-- vim.o.nostartofline
-- vim.o.nrformats-=octal
