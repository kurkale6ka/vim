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

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

  -- Local
  use '~/.config/nvim/plugged/vim-pairs'
  use '~/.config/nvim/plugged/vim-desertEX'

end)
