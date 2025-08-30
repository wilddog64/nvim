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
    cmd = { "GundoToggle", "GundoShow" }
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
    "nvimtools/none-ls.nvim",
    event = 'BufReadPre',
    pin = true,
  },-- for formatters and linters

  {
    'ojroques/nvim-osc52',
    config = function()
      require('osc52').setup {
        max_length = 0,           -- Maximum length of selection (0 for no limit)
        silent = false,           -- Disable message on successful copy
        trim = false,             -- Trim surrounding whitespaces before copy
        tmux_passthrough = false, -- Use tmux passthrough (requires tmux: set -g allow-passthrough on)
      }
     end
  },
  { 'mfussenegger/nvim-dap', },

  {
    'nvim-lualine/lualine.nvim',
    event = 'BufReadPre',
  },

  {
    "akinsho/toggleterm.nvim",
    keys = { { "<C-`>", "<cmd>ToggleTerm<cr>", desc="Terminal" } }
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
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile" }

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
    "towolf/vim-helm",
    ft = { "helm" },
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
      -- require('copilot').setup {}
      require('CopilotChat').setup({
        mappings ={
          complete = {
            insert = '<Tab>',
          },
          close = {
            normal = 'q',
            insert = '<C-c>'
          },
          reset = {
            normal = '<C-r>',
            insert = '<C-r>'
          },
          submit_prompt = {
            normal = '<CR>',
            insert = '<C-S>',
          },
          accept_diff = {
            normal = '<C-y>',
            insert = '<C-y>'
          }
        }
      })
    end,
    event = "BufReadPost", -- Loads Copilot after a file is opened
  },

  {
    'ojroques/nvim-lspfuzzy',
    pin = true,
    dependencies = {
      {'junegunn/fzf'},
      {'junegunn/fzf.vim'},
    }
  },

  -- devicons: install even if nothing else depends on it
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,                      -- load on demand
    opts = { default = true  },        -- generic icons for unknown types
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
    config = function()
      require('nvim-web-devicons').setup( { default = true } )
      require("nvim-tree").setup {
        actions = {
          open_file = {
            quit_on_open = true
          }
        },
        renderer = {
          icons = {
            show = { file = true, folder = true, folder_arrow = true, git = true }
          }
        }
      }
    end,
    keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc="File tree" } }
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
    pin = true,
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig', priority = 1000, pin = true},
      {"williamboman/mason.nvim", run = ':MasonUpdate', pin = true},
      {'williamboman/mason.lspconfig.nvim', pin = true},
      {'tamago324/nlsp-settings.nvim', pin = true},

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
