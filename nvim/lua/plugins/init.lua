local packer = vim.api.nvim_create_augroup('Packer', { clear = true })

-- Automatically source and packer compile on save
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerCompile',
    pattern = vim.fn.expand('%:p'),
    group = packer,
})

return require('packer').startup(function(use)

    -- Self
    use 'wbthomason/packer.nvim'

    -- TODO
    -- execute "Plug '".s:vim."/plugged/unicodename', { 'on': 'UnicodeName' }"
    -- execute "Plug '".s:vim."/plugged/win_full_screen', { 'on': 'WinFullScreen' }"
    -- execute "Plug '".s:vim."/plugged/vim-chess'"
    -- Plug 'bfredl/nvim-miniyank', has('nvim') ? {} : { 'on': [] } " ???
    -- Plug 'airblade/vim-gitgutter' + config
    -- Plug 'pearofducks/ansible-vim'
    -- Plug 'rodjek/vim-puppet'
    -- Plug 'terceiro/vim-foswiki'
    -- Plug 'vim-scripts/iptables'
    -- Plug 'vim-scripts/nginx.vim'
    -- Plug 'StanAngeloff/php.vim'
    -- Plug 'tmux-plugins/vim-tmux'
    -- Plug 'norcalli/nvim-colorizer.lua' " ???
    -- Plug 'jvirtanen/vim-hcl'

    -- Tpope
    use 'tpope/vim-abolish'
    use 'tpope/vim-commentary'
    use 'tpope/vim-endwise'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-markdown'
    use 'tpope/vim-repeat'
    use 'tpope/vim-sleuth'
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-projectionist'

    -- Fern
    use 'lambdalisue/fern.vim'
    use 'lambdalisue/fern-hijack.vim'
    use 'lambdalisue/nerdfont.vim'
    use 'lambdalisue/fern-renderer-nerdfont.vim'
    use 'lambdalisue/glyph-palette.vim'

    use 'liuchengxu/vista.vim'
    use { 'dstein64/vim-startuptime', opt = true, cmd = 'StartupTime' }

    -- Junegunn: TODO
    use 'junegunn/vim-easy-align'
    use { 'junegunn/fzf', run = function() vim.call('fzf#install') end }
    use 'junegunn/fzf.vim'

    -- LSP
    use { 'neovim/nvim-lspconfig',
        requires = {
            'williamboman/mason.nvim', -- automatically install LSPs to stdpath for neovim
            'williamboman/mason-lspconfig.nvim',
            'j-hui/fidget.nvim', -- useful status updates for LSP
            'folke/neodev.nvim', -- additional lua configuration, makes nvim stuff amazing
        },
    }

    -- Autocompletion
    use { 'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
        },
    }

    -- Snippets
    use 'SirVer/ultisnips'
    use 'quangnguyen30192/cmp-nvim-ultisnips'
    use 'honza/vim-snippets'

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

    -- Own
    use 'kurkale6ka/vim-pairs'
    use 'kurkale6ka/vim-desertEX'

end)
