vim.keymap.set('n', '<leader>f', ':Files<cr>')
vim.keymap.set('n', '<leader>t', ':Filetypes<cr>') -- Set 'ft
vim.keymap.set('n', '<leader>b', ':Buffers<cr>')
vim.keymap.set('n', '<leader>r', ':History<cr>') -- Recently edited files

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

-- " Scriptnames
-- command! -nargs=? Scriptnames call fzf#run(fzf#wrap({
--    \ 'source': split(execute('scriptnames'), '\n'),
--    \ 'sink': {script -> execute('edit'.substitute(script, '^\s*\d\+:\s\+', '', ''))},
--    \ 'options': '-1 +m -q "'.<q-args>.'" --prompt "Scriptnames> "'
--    \ }))

-- Fuzzy /
vim.keymap.set('n', '<leader>/', ':BLines<cr>')
-- nmap <leader>G    :BLines <c-r><c-a>
-- xmap <leader>G "*y:BLines <c-r>*<cr>

-- " Custom help files
-- if !empty($REPOS_BASE)
--    nmap <expr> <leader>h ':Files '.$REPOS_BASE.'/help<cr>'
-- endif

-- ripgrep
vim.api.nvim_create_user_command('Rg',
    function(input)
        vim.call('fzf#vim#grep',
            'rg --column --line-number --no-heading --color=always --smart-case --hidden -- ' .. vim.call('shellescape', input.args),
            1, -- was --column passed?
            vim.call('fzf#vim#with_preview'),
            input.bang -- fullscreen?
        )
    end,
    {bang = true, nargs = '*', desc = 'ripgrep'}
)
