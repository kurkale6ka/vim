vim.g.mapleader = ' '
vim.g.python3_host_prog = '~/py-envs/utils/bin/python'

vim.opt.termguicolors = true
vim.opt.number = true

vim.opt.writebackup = true
vim.opt.backupext = '~'
-- ?
vim.opt.backupskip = ''

vim.opt.autowrite = false
vim.opt.autowriteall = false
vim.opt.autoread = false

vim.keymap.set('n', '<leader>w', ':w<cr>')

vim.bo.undofile = true

-- nnoremap gr :later 9999<cr>

-- set history=10000
-- if !has('nvim')
--    set viminfo=!,'1000
--    execute 'set viminfo+=n'.s:vim.'/.viminfo'
-- else
--    set shada='1000
-- endif
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
require('statusline')
