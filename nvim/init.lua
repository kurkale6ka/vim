vim.g.mapleader = ' '

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

-- TODO: set includeexpr for gf
require('plugins')
require('mason').setup()
require('plugins/tree-sitter')
require('plugins/fern')
require('plugins/nvim-cmp')
require('plugins/ultisnips')
require('statusline')
require('autocmds')

vim.g.python3_host_prog = '~/py-envs/utils/bin/python'

vim.o.termguicolors = true
vim.cmd 'colorscheme desertEX'

-- Backups
vim.o.writebackup = true
vim.o.backupext = '~'
vim.o.backupskip = nil
vim.o.autowrite = false
vim.o.autowriteall = false
vim.o.autoread = false

vim.keymap.set('n', '<leader>w', ':w<cr>')
vim.keymap.set('n', '<leader>e', ':e')
vim.keymap.set('n', '<leader>-', '<c-^>')

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

-- \G for global
-- \S for substitute
vim.keymap.set('n', '<leader>G', ':g/<c-r><c-a>/')
vim.keymap.set('n', '<leader>S', ':%s/<c-r><c-a>//g<left><left>')

vim.cmd([[cabbrev <expr> es getcmdtype() == ':' ? 'e%:p:s/'.abbreviations#eat_char('\s') : 'es']])

vim.o.inccommand = 'nosplit'
vim.opt.path:append { vim.env.XDG_CONFIG_HOME..'/repos/**' }
vim.o.grepprg = 'rg --column --line-number --no-heading --vimgrep --smart-case --hidden'
vim.o.fileencodings = 'ucs-bom,utf-8,default,cp1251,latin1'
vim.o.fileformats = 'unix,mac,dos'
vim.opt.isfname:remove { '=' }
vim.wo.number = true
vim.wo.numberwidth = 1
vim.o.showmatch = true
vim.o.matchtime = 2
vim.opt.matchpairs:append { '<:>' }
vim.o.confirm = true
vim.o.showcmd = true
vim.o.report = 0
vim.o.shortmess = 'flmnrxoOtT'
vim.opt.display:append { 'lastline' }
vim.o.lazyredraw = true
vim.o.scrolloff = 2
vim.o.timeoutlen = 2000 -- 2s before timing out a mapping
vim.o.ttimeoutlen = 100 -- 100 ms before timing out on a keypress
vim.o.visualbell = true -- visual bell instead of beeps, but...

vim.wo.foldnestmax = 1 -- maximum nesting for indent and syntax
-- cabbrev <expr> fold getcmdtype() == ':' ? "se fdm=expr fde=getline(v\\:lnum)=~'^\\\\s*##'?'>'.(len(matchstr(getline(v\\:lnum),'###*'))-1)\\:'='".abbreviations#eat_char('\s') : 'fold'
-- cabbrev foldx se fdm=expr fde=getline(v\:lnum)=~'<'?'>1'\:'='<left><left><left><left><left><left><left><left><left><left><left><c-r>=abbreviations#eat_char('\s')<cr>

-- Print working directory
vim.keymap.set('n', '<c-g>', '2<c-g>')

vim.o.linebreak = true -- wrap at characters in 'breakat
vim.wo.breakindent = true -- respect indentation when wrapping

vim.wo.showbreak = '↪ '
vim.opt.listchars = { tab = '▷⋅', trail = '⋅', nbsp = '⋅' }

if vim.bo.readonly or not vim.bo.modifiable then
    vim.wo.list = false
else
    vim.wo.list = true
end

-- \8 to highlight text beyond the 80th column
vim.keymap.set('n', '<leader>8', ':call highlight#column()<cr>', { silent = true })
if not vim.wo.diff then
    vim.wo.cursorline = true
end

vim.o.synmaxcol = 301
vim.o.mouse = 'a'
vim.o.mousemodel = 'extend'

vim.opt.formatoptions:append('r') -- auto insert comment with <Enter>...
vim.opt.formatoptions:append('o') -- ...or o/O
vim.opt.formatoptions:append('n') -- Recognize numbered lists

vim.o.comments = vim.o.comments:gsub('fb:%-', 'b:-') -- lists with dashes
vim.o.commentstring = '#%s'

vim.keymap.set('n', 'Q', 'gqap')

vim.o.nojoinspaces = true
vim.o.autoindent = true

-- Underline
vim.api.nvim_create_user_command('Underline',
    'call underline#current(<q-args>)',
    {nargs = '?', desc = 'Underline with dashes by default'}
)

-- \z to squeeze lines
vim.keymap.set('n', '<leader>z', ':call squeeze#lines("")<cr>', { silent = true })

-- = + space to surround with empty lines
vim.keymap.set('n', '=<leader>', '[<leader>]<leader>', { remap = true })

vim.o.tabstop = 8
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.shiftround = true

vim.keymap.set('x', '<tab>', '>')
vim.keymap.set('x', '<s-tab>', '<')

-- align left
vim.keymap.set({'n', 'x'}, '<leader>0', ':left<cr>')

vim.opt.tags:append { vim.env.XDG_CONFIG_HOME..'/repos/tags' }
vim.opt.complete:remove { 't' }
vim.opt.completeopt:remove { 'preview' }
vim.o.showfulltag = true
vim.o.hidden = true

vim.opt.diffopt:append { 'vertical,iblank,iwhiteall' }

vim.o.noequalalways = true
vim.o.splitright = true
vim.o.switchbuf = 'useopen,usetab'
vim.o.showtabline = 1
vim.o.tabline = '%!tabs#MyTabLine()'
vim.o.exrc = true
vim.o.secure = true -- :autocmd, shell and write commands not allowed in CWD .exrc
vim.o.modeline = true
vim.o.modelines = 3
vim.o.backspace = 'indent,eol,start'
vim.o.virtualedit = 'block'
vim.o.whichwrap = 'b,s,<,>,[,]'
vim.o.paragraphs = nil -- no wrongly defined paragraphs for non nroff,groff filetypes
vim.o.nostartofline = true
vim.opt.nrformats:remove { 'octal' }
