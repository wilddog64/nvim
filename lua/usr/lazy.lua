-- Path to lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is installed
---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
  print("Installing lazy.nvim...")
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

-- Load lazy.nvim and plugins
require("lazy").setup({
   -- Example plugin specs
   {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      event = "BufRead",
   },
   -- {
   --    "nvim-telescope/telescope.nvim",
   --    cmd = "Telescope",
   --    dependencies = { "nvim-lua/plenary.nvim" },
   -- },
   {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre", -- Load when a file is opened
   },
   {
      'christoomey/vim-tmux-navigator',
      event = 'bufReadPre',
   },
   {
      'tmux-plugins/vim-tmux',
      event = 'bufReadPre',
   },
   {
      'tmux-plugins/vim-tmux-focus-events',
      event = 'bufReadPre',
   },
   {
      'jiangmiao/auto-pairs',
      event = 'bufReadPre',
   },
   {
      'dbakker/vim-projectroot',
      event = 'bufReadPre',
   },
   {
      'ervandew/supertab',
      event = 'bufReadPre',
   },
   {
      'sjl/gundo.vim',
      event = 'bufReadPre',
   },
   {
      'tpope/vim-endwise',
      event = 'bufReadPre',
   },
   {
      'tpope/vim-repeat',
      event = 'bufReadPre',
   },
   {
      'tpope/vim-surround',
      event = 'bufReadPre',
   },
   {
      'tpope/vim-unimpaired',
      event = 'bufReadPre',
   },
   {
      'corntrace/bufexplorer',
      event = 'bufReadPre',
   },
   {
      'nvim-lualine/lualine.nvim',
      event = 'bufReadPre',
   },
   {
      "akinsho/toggleterm.nvim",
      event = 'bufReadPre',
   },
   {
      'echasnovski/mini.nvim',
      event = 'bufReadPre',
   },
   {
      'sam4llis/nvim-lua-gf',
      event = 'bufReadPre',
   },
   {
      'kdheepak/lazygit.nvim',
      event = 'bufReadPre',
   },
   {
      'airblade/vim-gitgutter',
      event = 'bufReadPre',
   },
   {
      'L3MON4D3/LuaSnip',
      event = 'bufReadPre',
   },
   {
     'mfussenegger/nvim-dap',
      event = 'bufReadPre',
   },
   {
     'ojroques/nvim-osc52',
      event = 'bufReadPre',
   },
   {
     'haya14busa/vim-asterisk',
      event = 'bufReadPre',
   },
   {
     'haya14busa/vim-asterisk',
      event = 'bufReadPre',
   },
   {
     'sam4llis/nvim-lua-gf',
      event = 'bufReadPre',
   },

   {
     'CopilotC-Nvim/CopilotChat.nvim',
     lazy = true,
     branch = "main",
     build = "make tiktoken",
     dependencies = {
       { "zbirenbaum/copilot.lua" },
       { "nvim-lua/plenary.nvim" },
     },
     opts = {
       debug = false,
       window = {
         width = 0.30,
       },
     },
     keys = {
       {
         "<Leader>ch",
         ":'<,'>CopilotChat<CR>",
         mode = { "v" },
         desc = "Copilot Chat Selection",
       },
       {
         "<Leader>ch",
         ":CopilotChatToggle<CR>",
         mode = { "n" },
         desc = "Toggle Copilot Chat",
       },
     },
     event = "BufReadPost", -- Loads Copilot after a file is opened
   },
   {
      'ojroques/nvim-lspfuzzy',
      dependencies = {
         'ibhagwan/fzf-lua'
      }
   },
   {
     'VonHeikemen/lsp-zero.nvim',
     dependencies = {
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
       {'folke/lsp-colors.nvim'}
     }
   }
})
