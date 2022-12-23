vim.g.fern_disable_startup_warnings = true
vim.g['fern#default_exclude'] = [[\%(^\.git\|.\+\~\)$]]
vim.g['fern#hide_cursor'] = true
vim.g['fern#default_hidden'] = true
vim.g['fern#renderer'] = "nerdfont"

-- Override netrw's Vexplore with Fern
vim.api.nvim_create_user_command('Vexplore',
    'Fern . -drawer -toggle -reveal=%',
    {nargs = '?', complete = 'dir', desc = 'Fern explorer'}
)

vim.keymap.set('n', '<leader>v', ':silent! Glcd <bar> Vexplore<cr>', { silent = true })
