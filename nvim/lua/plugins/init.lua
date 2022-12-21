return require('packer').startup(function(use)

    -- self
    use 'wbthomason/packer.nvim'

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
    if vim.fn.has('patch-8.1.0994') then
        use 'lambdalisue/fern-renderer-nerdfont.vim'
    end
    use 'lambdalisue/glyph-palette.vim'

    use 'liuchengxu/vista.vim'

    -- junegunn
    use 'junegunn/vim-easy-align'
    use 'junegunn/fzf' -- , { 'dir': '~/.fzf', 'do': './install --all' }
    use 'junegunn/fzf.vim'

    -- Autocompletion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/nvim-cmp',
        },
    }

    -- snippets
    use 'SirVer/ultisnips'
    use 'quangnguyen30192/cmp-nvim-ultisnips'
    use 'honza/vim-snippets'

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

    -- Local
    use '~/.vim/plugged/vim-pairs'
    use '~/.vim/plugged/vim-desertEX'

end)
