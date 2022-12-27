if not vim.fn.exists("did_plugin_ultisnips")
then
    vim.fn.finish()
end

vim.keymap.set('x', '<tab>', '>')
