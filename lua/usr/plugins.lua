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

  -- unused plugins
  -- use 'junegunn/fzf.vim'
  -- use 'othree/xml.vim'
  -- use "numToStr/Comment.nvim" -- Easily comment stuff
  -- use "rktjmp/lush.nvim"
  -- use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  -- use 'antoinemadec/FixCursorHold.nvim'
  -- use 'axieax/urlview.nvim'
  -- use 'fatih/vim-go'
  -- use 'hanschen/vim-ipython-cell'
  -- use 'hashivim/vim-hashicorp-tools'
  -- use 'idbrii/itchy.vim'
  -- use 'idbrii/vim-ripple'
  -- use 'jpalardy/vim-slime'
  -- use 'juliosueiras/vim-terraform-completion'
  -- use 'junegunn/fzf'
  -- use 'mfussenegger/nvim-dap-python'
  -- use 'preservim/tagbar'
  -- use 'rust-lang/rust.vim'
  -- use 'shougo/deoplete-lsp'
  -- use 'simrat39/rust-tools.nvim'
  -- use 'szw/vim-maximizer'
  -- use 'tpope/vim-fugitive'
  -- use { 'shougo/deoplete.nvim', run = ':UpdateRemotePlugins' }

  use 'wbthomason/packer.nvim'

  use {
    'jiangmiao/auto-pairs',
    event = 'BufReadPre',
  }

  use {
    'airblade/vim-gitgutter',
    event = 'BufReadPre',
  }

  use {
    'benmills/vimux',
    event = 'BufReadPre',
  }

  use {
    'christoomey/vim-tmux-navigator',
    event = 'BufReadPre',
  }

  use {
    'dbakker/vim-projectroot',
    event = 'BufReadPre',
  }

  use {
    'ervandew/supertab',
    event = 'BufReadPre',
  }

  use {
    'sjl/gundo.vim',
    event = 'BufReadPre',
  }

  use {
    'tmhedberg/matchit',
    event = 'BufReadPre',
  }

  use {
    'tmux-plugins/vim-tmux',
    event = 'BufReadPre',
  }

  use {
    'tmux-plugins/vim-tmux-focus-events',
    event = 'BufReadPre',
  }

  use {
    'tpope/vim-endwise',
    event = 'BufReadPre',
  }

  use {
    'tpope/vim-repeat',
    event = 'BufReadPre',
  }

  use {
    'tpope/vim-surround',
    event = 'BufReadPre',
  }

  use {
    'tpope/vim-unimpaired',
    event = 'BufReadPre',
  }

  use {
    'corntrace/bufexplorer',
    event = 'BufReadPre',
  }

  use { 'neovim/nvim-lspconfig' }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    event = 'BufReadPre',
  }-- for formatters and linters

  use {'ojroques/nvim-osc52'}
  use { 'mfussenegger/nvim-dap', }

  use {
    'nvim-lualine/lualine.nvim',
    event = 'BufReadPre',
  }

  use {
    "akinsho/toggleterm.nvim",
    event = 'BufReadPre',
  }

  use {
    'honza/vim-snippets',
    event = 'BufReadPre',
  }

  use {
    'f3fora/cmp-spell',
    event = 'BufReadPre',
  }

  use {
    'plasticboy/vim-markdown',
    event = 'BufReadPre',
  }

  use { 'echasnovski/mini.nvim', }

  use {
    'hashivim/vim-terraform',
    event = 'BufReadPre',
  }

  use {
    'kdheepak/lazygit.nvim',
    event = 'BufReadPre',
  }

  use {
    'martinda/Jenkinsfile-vim-syntax',
    event = 'BufReadPre',
  }

  use {
    'haya14busa/is.vim',
    event = 'BufReadPre',
  }

  use {
    'haya14busa/vim-asterisk',
    event = 'BufReadPre',
  }

  use {
    'wellle/targets.vim',
    event = 'BufReadPre',
  }

  use {
    'sam4llis/nvim-lua-gf',
    event = 'BufReadPre',
  }

  use {
    'rodjek/vim-puppet',
    event = 'BufReadPre',
  }

  use {
    'mfussenegger/nvim-ansible',
    event = 'BufReadPre',
  }

  -- use {
  --   'github/copilot.vim',
  --   requires = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-lua/popup.nvim',
  --   },
  -- }
  --
  -- use {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   lazy = true,
  --   branch = "main",
  --   dependencies = {
  --     { "zbirenbaum/copilot.lua" },
  --     { "nvim-lua/plenary.nvim" },
  --   },
  --   requires = {
  --     'zbirenbaum/copilot.lua',
  --   },
  --   config = function()
  --     require('copilot').setup {}
  --     require('CopilotChat').setup({
  --       keymaps = {
  --         close = "<C-c>", -- Close the chat
  --         submit = "<Enter>", -- Send user input
  --         next = "<Tab>", -- Navigate predefined options (if available)
  --         prev = "<S-Tab>",
  --         aceept = "<C-e>", -- Accept the current suggestion
  --       },
  --     })
  --   end,
  --   event = 'BufReadPre',
  -- }

  use {
    'ojroques/nvim-lspfuzzy',
    requires = {
      {'junegunn/fzf'},
      {'junegunn/fzf.vim'},
    },
    event = 'BufReadPre',
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
    end,
    event = 'BufReadPre',
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
    end,
    event = 'BufReadPre',
  }

  use {
    'ibhagwan/fzf-lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    event = 'BufReadPre',
  }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
