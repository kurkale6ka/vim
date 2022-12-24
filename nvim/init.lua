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
vim.keymap.set('n', '<leader>-', '<c-^>') -- switch to the alternate file

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

-- Ctrl + w twice to go to the last accessed window
vim.keymap.set('n', '<c-w><c-w>', ':wincmd p<cr>', { silent = true })

-- Ctrl + w, N to create a new buffer over the current one
vim.keymap.set('n', '<c-w>N', ':leftabove vnew<cr>', { silent = true })

vim.o.showtabline = 1
vim.o.tabline = '%!tabs#MyTabLine()'
vim.o.exrc = true
vim.o.secure = true -- :autocmd, shell and write commands not allowed in CWD .exrc
vim.o.modeline = true
vim.o.modelines = 3

vim.o.clipboard = 'unnamed,unnamedplus'

-- paste above/below for small (non whole lines) yanks
vim.keymap.set('n', '[P', ':pu!<cr>')
vim.keymap.set('n', ']P', ':pu<cr>')

-- Swap first and last line in a visual area
vim.keymap.set('x', '<cr>', "<esc>'<dd'>[pjdd`<P==")

-- Backspace
vim.keymap.set('n', '<bs>', '"_X')
vim.o.backspace = 'indent,eol,start'

-- Ctrl + u
vim.keymap.set('i', '<c-u>', '<c-g>u<c-u>')

-- Ctrl + w
vim.keymap.set('c', '<c-w>', '<c-\\>ecmdline#ctrl_w()<cr>')
vim.keymap.set('i', '<c-w>', '<c-o>dB')

-- Alt + backspace
vim.keymap.set({'i', 'c'}, '<m-bs>', '<c-w>')

-- Alt + d
vim.keymap.set('c', '<m-d>', '<c-\\>ecmdline#alt_d()<cr>')
vim.keymap.set('i', '<m-d>', '<c-o>de')

-- Ctrl + k
vim.keymap.set('c', '<c-k>', '<c-\\>estrpart(getcmdline(), 0, getcmdpos() - 1)<cr>')
vim.keymap.set('i', '<c-k>', '<c-o>D')

-- Delete EOF empty lines
vim.keymap.set('n', 'dl', ':call spaces#remove_eof()<cr>', { silent = true })

-- Remove eol spaces
vim.api.nvim_create_user_command('RemoveSpaces',
    ':call spaces#remove()',
    {desc = 'Remove eol spaces'}
)

vim.o.virtualedit = 'block'
vim.o.whichwrap = 'b,s,<,>,[,]'
vim.o.paragraphs = nil -- no wrongly defined paragraphs for non nroff,groff filetypes

-- use alt + h,j,k,l to navigate windows from any mode
vim.keymap.set({'t','i'}, '<a-h>', '<c-\\><c-n><c-w>h')
vim.keymap.set({'t','i'}, '<a-j>', '<c-\\><c-n><c-w>j')
vim.keymap.set({'t','i'}, '<a-k>', '<c-\\><c-n><c-w>k')
vim.keymap.set({'t','i'}, '<a-l>', '<c-\\><c-n><c-w>l')
vim.keymap.set('n', '<a-h>', '<c-w>h')
vim.keymap.set('n', '<a-j>', '<c-w>j')
vim.keymap.set('n', '<a-k>', '<c-w>k')
vim.keymap.set('n', '<a-l>', '<c-w>l')

-- Goto ^ and $ with Ctrl + /
vim.keymap.set('n', '<c-left>', '^')
vim.keymap.set('n', '<c-right>', '$')
vim.keymap.set('i', '<c-left>', '<c-o>^')
vim.keymap.set('i', '<c-right>', '<c-o>$')

-- <Home> to move to the first char on the line
vim.keymap.set({'n','v','o'}, '<home>', '^')
vim.keymap.set('i', '<home>', '<c-o>I')
vim.keymap.set('c', '<c-a>', '<home>')

-- Ctrl +  to go up by a paragraph
vim.keymap.set('i', '<c-up>', '<c-o>{')
vim.keymap.set({'n','v','o'}, '<c-up>', '{')

-- Ctrl +  to go down by a paragraph
vim.keymap.set('i', '<c-down>', '<c-o>}')
vim.keymap.set({'n','v','o'}, '<c-down>', '}')

vim.o.nostartofline = true
vim.opt.nrformats:remove { 'octal' }
