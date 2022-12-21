local generic = vim.api.nvim_create_augroup("Generic", { clear = true })

-- When reading a file, :cd to its parent directory.
-- this replaces 'autochdir which doesn't work properly.
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    command = [[
        if &filetype != 'help'
            silent! cd %:p:h   
        endif
    ]],
    group = generic
})
