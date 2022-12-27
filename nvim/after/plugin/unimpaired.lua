if not vim.fn.exists("g:loaded_unimpaired")
then
    vim.fn.finish()
end

-- remove
vim.keymap.del('n', '[p')
vim.keymap.del('n', ']p')

-- add
vim.keymap.set('n', 'yov', ":se <C-R>=(&ve != 'all') ? 've=all' : 've=block'<CR><CR>")
