-- we use stdpath to figure where to place lazy.nvim package
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  print('Cloning lazy.nvim repo from github ...')
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  print("lazy.nvim installed successfully.")
end

-- Add lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'airblade/vim-gitgutter',
    event = 'BufReadPre',
  },

  {
    'jiangmiao/auto-pairs',
    event = 'BufReadPre',
  },

  {
    'benmills/vimux',
    event = 'BufReadPre',
  },

  {
    'christoomey/vim-tmux-navigator',
    event = 'BufReadPre',
  },

  {
    'dbakker/vim-projectroot',
    event = 'BufReadPre',
  },

  -- {
  --   'ervandew/supertab',
  --   event = 'BufReadPre',
  -- },

  {
    'sjl/gundo.vim',
    event = 'BufReadPre',
  },

  {
    'tmhedberg/matchit',
    event = 'BufReadPre',
  },

  {
    'tmux-plugins/vim-tmux',
    event = 'BufReadPre',
  },

  {
    'tmux-plugins/vim-tmux-focus-events',
    event = 'BufReadPre',
  },

  {
    'tpope/vim-endwise',
    event = 'BufReadPre',
  },

  {
    'tpope/vim-repeat',
    event = 'BufReadPre',
  },

  -- {
  --   'tpope/vim-surround',
  --   event = 'BufReadPre',
  -- },

  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({
        normal = 'ys',
        visual = 'S',
        change = 'cs',
        delete = 'ds',
      })
    end
  },

  {
    'tpope/vim-unimpaired',
    event = 'BufReadPre',
  },

  {
    'corntrace/bufexplorer',
    event = 'BufReadPre',
  },

  { 'neovim/nvim-lspconfig' },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = 'BufReadPre',
  },-- for formatters and linters

  {'ojroques/nvim-osc52'},
  { 'mfussenegger/nvim-dap', },

  {
    'nvim-lualine/lualine.nvim',
    event = 'BufReadPre',
  },

  {
    "akinsho/toggleterm.nvim",
    event = 'BufReadPre',
  },

  {
    'honza/vim-snippets',
    event = 'BufReadPre',
  },

  {
    'f3fora/cmp-spell',
    event = 'BufReadPre',
  },

  {
    'plasticboy/vim-markdown',
    event = 'BufReadPre',
  },

  { 'echasnovski/mini.nvim', },

  {
    'hashivim/vim-terraform',
    event = 'BufReadPre',
  },

  {
    'kdheepak/lazygit.nvim',
    event = 'BufReadPre',
  },

  {
    'martinda/Jenkinsfile-vim-syntax',
    event = 'BufReadPre',
  },

  {
    'haya14busa/is.vim',
    event = 'BufReadPre',
  },

  {
    'haya14busa/vim-asterisk',
    event = 'BufReadPre',
  },

  {
    'wellle/targets.vim',
    event = 'BufReadPre',
  },

  {
    'sam4llis/nvim-lua-gf',
    event = 'BufReadPre',
  },

  {
    'rodjek/vim-puppet',
    event = 'BufReadPre',
  },

  {
    'mfussenegger/nvim-ansible',
    event = 'BufReadPre',
  },

  {
    'github/copilot.vim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
    },
  },


  {
    'CopilotC-Nvim/CopilotChat.nvim',
    lazy = true,
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require('copilot').setup {}
      require('CopilotChat').setup()
    end,
    event = "BufReadPost", -- Loads Copilot after a file is opened
  },

  {
    'ojroques/nvim-lspfuzzy',
    depdencies = {
      {'junegunn/fzf'},
      {'junegunn/fzf.vim'},
    }
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
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
    end,
    event = 'BufReadPre',
  },

  {
    "folke/which-key.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to  the default settings
      -- refer to the configuration section below
    },
  },

  -- LSP
  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig', priority = 1000},
      {"williamboman/mason.nvim", run = ':MasonUpdate'},
      {'williamboman/mason.lspconfig.nvim'},
      {'tamago324/nlsp-settings.nvim'},

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
        dependencies = {
          'rafamadriz/friendly-snippets',
          'honza/vim-snippets',
        }
      },

      'folke/lsp-colors.nvim',
    }
  },

  {
    'ibhagwan/fzf-lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    event = 'BufReadPre',
  },

  {
    'Ramilito/kubectl.nvim',
    event = 'BufReadPre',
  },
})
