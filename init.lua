-- setup tab expansion
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

require('packer').startup(function(use)
  -- allow packer to manage itself
  use 'wbthomason/packer.nvim'

  use 'jiangmiao/auto-pairs'
  use 'airblade/vim-gitgutter'
  use 'benmills/vimux'
  use 'christoomey/vim-tmux-navigator'
  use 'dbakker/vim-projectroot'
  use 'ervandew/supertab'
  use 'fatih/vim-go'
  use 'hashivim/vim-hashicorp-tools'
  use 'hashivim/vim-terraform'
  use 'juliosueiras/vim-terraform-completion'
  use 'othree/xml.vim'
  use 'vim-scripts/taglist.vim'
  use 'majutsushi/tagbar'
  use 'sjl/gundo.vim'
  use 'terryma/vim-multiple-cursors'
  use 'tmhedberg/matchit'
  use 'tmux-plugins/vim-tmux'
  use 'tmux-plugins/vim-tmux-focus-events'
  use 'tpope/vim-endwise'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'szw/vim-maximizer'

  -- LSP
    use {
      'VonHeikemen/lsp-zero.nvim',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'williamboman/nvim-lsp-installer'},

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},

        -- Snippets
        {'L3MON4D3/LuaSnip'},
        {'rafamadriz/friendly-snippets'},
      }
  }
end)

-- add lsp configuration
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.nvim_workspace()
lsp.setup()

vim.cmd([[
  source ~/.config/nvim/settings/general.vim
  source ~/.config/nvim/settings/keymaps.vim
]])
