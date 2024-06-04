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

  use {
    'lewis6991/impatient.nvim',
    config = function() require 'impatient' end
  }  -- cache plugins, make nvim start faster

  use 'wbthomason/packer.nvim'
  use 'jiangmiao/auto-pairs'
  use 'airblade/vim-gitgutter'
  use 'benmills/vimux'
  use 'christoomey/vim-tmux-navigator'
  use 'dbakker/vim-projectroot'
  use 'ervandew/supertab'
  use 'othree/xml.vim'
  use 'sjl/gundo.vim'
  use 'tmhedberg/matchit'
  use 'tmux-plugins/vim-tmux'
  use 'tmux-plugins/vim-tmux-focus-events'
  use 'tpope/vim-endwise'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'corntrace/bufexplorer'
  use { 'shougo/deoplete.nvim', run = ':UpdateRemotePlugins' }
  -- use 'shougo/deoplete-lsp'
  -- use { 'shougo/deoplete.nvim', run = ':UpdateRemotePlugins' }
  use 'neovim/nvim-lspconfig'
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use {'ojroques/nvim-osc52'}
  use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-dap-python'
  use 'nvim-lualine/lualine.nvim'
  use 'antoinemadec/FixCursorHold.nvim'
  use "akinsho/toggleterm.nvim"
  use "rktjmp/lush.nvim"
  use 'junegunn/fzf.vim'
  use 'idbrii/itchy.vim'
  use 'axieax/urlview.nvim'
  use 'honza/vim-snippets'
  use 'f3fora/cmp-spell'
  use 'plasticboy/vim-markdown'
  use 'echasnovski/mini.nvim'
  use 'juliosueiras/vim-terraform-completion'
  use 'hashivim/vim-terraform'
  use 'kdheepak/lazygit.nvim'
  use 'martinda/Jenkinsfile-vim-syntax'
  use 'haya14busa/is.vim'
  use 'haya14busa/vim-asterisk'
  use 'wellle/targets.vim'
  use 'sam4llis/nvim-lua-gf'
  use 'rodjek/vim-puppet'
  use 'jpalardy/vim-slime'
  use 'hanschen/vim-ipython-cell'
  use 'mfussenegger/nvim-ansible'
  use 'rust-lang/rust.vim'
  use 'preservim/tagbar'
  use 'simrat39/rust-tools.nvim'


  -- unused plugins
  -- use 'fatih/vim-go'
  -- use 'hashivim/vim-hashicorp-tools'
  -- use 'tpope/vim-fugitive'
  -- use 'szw/vim-maximizer'
  -- use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  -- use "numToStr/Comment.nvim" -- Easily comment stuff
  -- use 'junegunn/fzf'
  -- use 'idbrii/vim-ripple'

  use {
    'ojroques/nvim-lspfuzzy',
    requires = {
      {'junegunn/fzf'},
      {'junegunn/fzf.vim'},
    }
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
    config = function()
      require("nvim-tree").setup {
        actions = {
          open_file = {
            quit_on_open = true
          }
        }
      }
    end
  }

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      -- {'williamboman/nvim-lsp-installer'},
      {"williamboman/mason.nvim", run = ':MasonUpdate'},
      {'williamboman/mason.lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {
        'L3MON4D3/LuaSnip',
        requires = {
          'rafamadriz/friendly-snippets',
          'honza/vim-snippets',
        }
      },

      use 'folke/lsp-colors.nvim',
    }
  }

  use {
    'SirVer/ultisnips',
    config = function()
      vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
      vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
      vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
      vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
      vim.g.UltiSnipsRemoveSelectModeMappings = 0
    end
  }

  -- use {
  --   "nvim-telescope/telescope.nvim",
  --   requires = {
  --     { "nvim-telescope/telescope-live-grep-args.nvim" },
  --   },
  --   config = function()
  --     require("telescope").load_extension("live_grep_args")
  --   end
  -- }

  use {
    'ibhagwan/fzf-lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    }
  }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
