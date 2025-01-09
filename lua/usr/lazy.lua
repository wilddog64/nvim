-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print('Cloning lazy.nvim repo from github ...')
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  print("lazy.nvim installed successfully.")
end
vim.opt.rtp:prepend(lazypath)

<<<<<<< HEAD
require('lazy').setup({
  {
    'airblade/vim-gitgutter',
    event = 'BufReadPre',
  },

  {
    'jiangmiao/auto-pairs',
    event = 'InsertEnter',
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

  {
    'ervandew/supertab',
    event = 'BufReadPre',
  },

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

=======
-- Plugin specifications
return require('lazy').setup({
  -- Core Editor Enhancements
>>>>>>> da4f775 (rework lazy plugins to make them more organzied)
  {
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'tpope/vim-endwise',
    'tpope/vim-unimpaired',
    'jiangmiao/auto-pairs',
    'wellle/targets.vim',
    'ervandew/supertab',
    event = 'VeryLazy',
  },

{
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    -- Add any mini.nvim modules you want to use
    require('mini.bufremove').setup()
    -- You can add other mini.nvim modules here
  end,
},

  -- Git Integration
  {
    'airblade/vim-gitgutter',
    'kdheepak/lazygit.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  -- File Navigation & Search
  {
    'nvim-tree/nvim-tree.lua',
    priority = 900,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require("nvim-tree").setup {
        actions = {
          open_file = { quit_on_open = true }
        }
      }
    end,
  },

  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
  },

  -- LSP & Completion
  {
    'VonHeikemen/lsp-zero.nvim',
    priority = 1000,
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim', build = ':MasonUpdate'},
      {'williamboman/mason.lspconfig.nvim'},
      {'tamago324/nlsp-settings.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},
      {'saadparwaiz1/cmp_luasnip'},

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

  -- AI Assistance
  {
    'github/copilot.vim',
    priority = 900,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
    },
  },

  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require('copilot').setup {}
      require('CopilotChat').setup()
    end,
    event = "BufReadPost",
  },

  -- Terminal & TMUX Integration
  {
    'akinsho/toggleterm.nvim',
    'benmills/vimux',
    'christoomey/vim-tmux-navigator',
    'tmux-plugins/vim-tmux',
    'tmux-plugins/vim-tmux-focus-events',
    event = 'VeryLazy',
  },

  -- Language Specific
  {
    'hashivim/vim-terraform',
    'rodjek/vim-puppet',
    'mfussenegger/nvim-ansible',
    'martinda/Jenkinsfile-vim-syntax',
    'plasticboy/vim-markdown',
    ft = {
      'terraform',
      'puppet',
      'yaml.ansible',
      'Jenkinsfile',
      'markdown',
    },
  },

  -- UI Enhancements
  {
    'nvim-lualine/lualine.nvim',
    'folke/which-key.nvim',
    event = 'VeryLazy',
  },

  -- Debugging
  {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
  },
}, {
  -- Lazy.nvim options
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { "habamax" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

