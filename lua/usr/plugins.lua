local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
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
  use 'corntrace/bufexplorer'
  use 'shougo/deoplete-lsp'
  use {  'shougo/deoplete.nvim', run = ':UpdateRemotePlugins' }
  use 'neovim/nvim-lspconfig'
  use 'rhysd/clever-f.vim'
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "lewis6991/impatient.nvim" -- cache plugins, make nvim start faster
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use  'ojroques/vim-oscyank'
  use 'mfussenegger/nvim-dap'
  use  'mfussenegger/nvim-dap-python'
  use 'nvim-lualine/lualine.nvim'
  use 'antoinemadec/FixCursorHold.nvim'
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "akinsho/toggleterm.nvim"
  use "rktjmp/lush.nvim"
  use "nvim-telescope/telescope.nvim"

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons'
    },
    config = function() require 'nvim-tree'.setup {} end
  }

  use {
    'ojroques/nvim-lspfuzzy',
    requires = {
      {'junegunn/fzf'},
      {'junegunn/fzf.vim'},
    }
  }

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

      -- Treesitter
      use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
      },
      use "JoosepAlviste/nvim-ts-context-commentstring",
      use 'folke/lsp-colors.nvim',
    }
  }

  use {
    'romgrk/nvim-treesitter-context',
    after = { 'nvim-treesitter' },
    config = function()
      require('treesitter-context').setup( {
        enable = true,
        throttle = true
      } )
    end
  }

  use {
    'nvim-treesitter/playground',
    after = { 'nvim-treesitter' },
    run = ":TSInstall query"
  }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
