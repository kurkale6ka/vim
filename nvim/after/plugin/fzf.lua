vim.keymap.set('n', '<leader>sg', ':GFiles<cr>')   -- search git files
vim.keymap.set('n', '<leader>sf', ':Files<cr>')    -- search fzf files
vim.keymap.set('n', '<leader>sh', ':History<cr>')  -- search history (recently edited files)
vim.keymap.set('n', '<leader>ss', ':Snippets<cr>') -- search snippets
vim.keymap.set('n', '<leader>st', ':Tags<cr>')     -- search tags
vim.keymap.set('n', '<leader>sc', ':Commands<cr>') -- search commands
vim.keymap.set('n', '<leader>sm', ':Maps<cr>')     -- search maps
vim.keymap.set('n', '<leader>t', ':Filetypes<cr>') -- set 'ft
vim.keymap.set('n', '<leader>b', ':Buffers<cr>')
vim.keymap.set('n', '<leader>/', ':BLines<cr>') -- fuzzy /
vim.keymap.set('n', '<leader>G', ':BLines <c-r><c-a>') -- fuzzy :g/
vim.keymap.set('n', '<leader>g', ':silent! Glcd <bar> exe "Rg ".input("ripgrep> ")<cr>') -- ripgrep

-- Custom help files
vim.keymap.set('n', '<leader>h', ':Files '..vim.env.XDG_CONFIG_HOME..'/repos/help<cr>')

-- " TODO: separate function, to emulate vf()
-- command! -nargs=+ VF call fzf#run(fzf#wrap({
--    \ 'source': 'locate -0 / | grep -zv "/\.\(git\|svn\|hg\)\(/\|$\)\|~$"',
--    \ 'options': '--read0 -0 -1 -m -q"'.<q-args>.'" --prompt "VF> "'
--    \ }))
-- nmap <s-space> :VF<space>

-- " Keymaps
-- command! -nargs=? Lang call fzf#run(fzf#wrap({
--    \ 'source': map(split(globpath(&rtp, 'keymap/*.vim')),
--    \              'fnamemodify(v:val, ":t:r")'),
--    \ 'sink': {keymap -> execute('setlocal keymap='.keymap)},
--    \ 'options': '-1 +m -q "'.<q-args>.'" --prompt "Keymap> "'
--    \ }))
-- nmap <leader>l :Lang<cr>

-- Rg: ripgrep
vim.api.nvim_create_user_command('Rg',
    function(input)
        vim.call('fzf#vim#grep',
            'rg --column --line-number --no-heading --color=always --smart-case --hidden -- ' .. vim.fn.shellescape(input.args),
            1, -- was --column passed?
            vim.call('fzf#vim#with_preview'),
            input.bang -- fullscreen?
        )
    end,
    {bang = true, nargs = '*', desc = 'ripgrep'}
)
