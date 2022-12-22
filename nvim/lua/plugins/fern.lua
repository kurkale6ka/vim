vim.g.fern_disable_startup_warnings = true
vim.g['fern#default_exclude'] = [[\%(^\.git\|.\+\~\)$]]
vim.g['fern#hide_cursor'] = true
vim.g['fern#default_hidden'] = true
vim.g['fern#renderer'] = "nerdfont"

vim.cmd([[command! -nargs=? -complete=dir Vexplore Fern . -drawer -toggle -reveal=%]])

vim.keymap.set('n', '<leader>v', ':silent! execute "Glcd" <bar> :Vexplore<cr>')

vim.cmd('hi link FernBranchText Directory')
