---- Wild menu & status line
vim.opt.wildoptions:remove { 'pum' }
vim.o.wildmenu = true
vim.o.wildmode = 'full'
vim.o.wildignore = vim.o.wildignore .. '*~,*.swp,tags'
-- vim.o.wildcharm = '<c-z>' -- cmdline: <c-z> in a mapping acts like <tab>

-- if exists('+wildignorecase')
--    vim.o.wildignorecase
-- endif

-- -- Status line
-- if exists('s:unicode_chars')
--    vim.o.statusline=%!statusline#init('❬',\ '❭')
-- else
--    vim.o.statusline=%!statusline#init('<',\ '>')
-- endif

vim.o.laststatus = 2
