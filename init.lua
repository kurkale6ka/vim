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

vim.keymap.set('n', 'gr', ':later 9999<cr>')

vim.o.history = 10000
vim.o.shada = "'1000"

-- Disable these plugins
vim.g.loaded_2html_plugin    = true
vim.g.loaded_vimballPlugin   = true
vim.g.loaded_netrwPlugin     = true
vim.g.loaded_zipPlugin       = true
vim.g.loaded_tarPlugin       = true
vim.g.loaded_getscriptPlugin = true

-- let did_install_default_menus = 1
-- let loaded_rrhelper          = 1
-- let loaded_spellfile_plugin  = 1

vim.cmd 'colorscheme desertEX'

require('plugins')
require('plugin-configs/tree-sitter')
require('plugin-configs/fern')
require('plugin-configs/ultisnips')
require('statusline')
