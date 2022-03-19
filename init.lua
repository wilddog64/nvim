-- setup tab expansion
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

require('packer').startup(function(use)
  -- allow packer to manage itself
  use 'wbthomason/packer.nvim'

  -- colorscheme
  use 'joshdick/onedark.vim'

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

-- vim.opt.signcolumn = 'yes'
-- vim.opt.termguicolors = true
-- pcall(vim.cmd, 'colorscheme onedark')

-- add lsp configuration
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.nvim_workspace()
lsp.setup()

vim.cmd([[
  source ~/.config/nvim/settings/general.vim
]])
