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

  use 'junegunn/vim-easy-align'
  use 'junegunn/fzf' -- , { 'dir': '~/.fzf', 'do': './install --all' }
  use 'junegunn/fzf.vim'

  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

  -- Local
  use '~/.vim/plugged/vim-pairs'
  use '~/.vim/plugged/vim-desertEX'

end)
