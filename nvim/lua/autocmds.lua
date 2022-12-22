local generic = vim.api.nvim_create_augroup("Generic", { clear = true })

-- Jump to the last spot the cursor was at in a file when reading it
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    command = [[
        if line("'\"") > 0 && line("'\"") <= line('$') && &filetype != 'gitcommit'
            execute 'normal! g`"'                                                 
        endif
    ]],
    group = generic
})

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
