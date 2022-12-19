local o = vim.o
local bo = vim.bo
local wo = vim.wo

---- Wild menu & status line
o.wildmenu = true
o.wildmode = 'full'
o.wildignore = o.wildignore .. '*~,*.swp,tags'
-- o.wildcharm = '<c-z>' -- cmdline: <c-z> in a mapping acts like <tab>

-- if exists('+wildignorecase')
--    o.wildignorecase
-- endif

-- -- Status line
-- if exists('s:unicode_chars')
--    o.statusline=%!statusline#init('❬',\ '❭')
-- else
--    o.statusline=%!statusline#init('<',\ '>')
-- endif

o.laststatus = 2
