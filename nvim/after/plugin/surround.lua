if not vim.fn.exists("g:loaded_surround")
then
    vim.fn.finish()
end

vim.keymap.set('x', 's', '<Plug>VSurround')
