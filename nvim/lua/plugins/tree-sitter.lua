require('nvim-treesitter.configs').setup {

    -- A list of parser names, or "all"
    ensure_installed = {
        "bash",
        "jsonc",
        "lua",
        "perl",
        "python",
        "vim",
        "yaml",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false,

    -- List of parsers to ignore installing (for "all")
    -- ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },

        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        -- disable = function(lang, buf)
        --     local max_filesize = 100 * 1024 -- 100 KB
        --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --     if ok and stats and stats.size > max_filesize then
        --         return true
        --     end
        -- end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection    = "gnn", -- set to `false` to disable one of the mappings
            node_incremental  = "grn",
            scope_incremental = "grc",
            node_decremental  = "grm",
        },
    },
    indent = {
        enable = true
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                -- ['ia'] = '@attribute.inner',
                -- ['aa'] = '@attribute.outer',
                -- ['ib'] = '@block.inner', -- taken: alias for a(
                -- ['ab'] = '@block.outer',
                -- ['ic'] = '@call.inner',
                -- ['ac'] = '@call.outer',
                ['ic'] = '@class.inner',
                ['ac'] = '@class.outer',
                -- ['ac'] = '@comment.outer',
                ['ii'] = '@conditional.inner', -- inner if
                ['ai'] = '@conditional.outer',
                -- ['if'] = '@frame.inner', -- taken: I use 'if' for 'inner file'
                -- ['af'] = '@frame.outer',
                ['im'] = '@function.inner', -- method
                ['am'] = '@function.outer',
                ['il'] = '@loop.inner',
                ['al'] = '@loop.outer',
                ['ia'] = '@parameter.inner', -- argument
                ['aa'] = '@parameter.outer',
                -- ['is'] = '@scope.inner',
                -- ['as'] = '@statement.outer', -- taken: sentence
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                -- [']c'] = '@class.outer', -- used to jump to diffs with unimpaired
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                -- [']C'] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                -- ['[c'] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                -- ['[C'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>x'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>X'] = '@parameter.inner',
            },
        },
    },
}

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldenable = false
