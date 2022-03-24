-- setup tab expansion
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

require('usr.options')
require('usr.plugins')
require('usr.impatient')
require('usr.cmp')
require('usr.treesitter')
require('usr.lsp')
require('usr.dag-python')
require('usr.lualine')
require('usr.comment')
require('usr.toggleterm')
require('usr.colors')
require('usr.telescope')

-- add lsp configuration
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.nvim_workspace()
lsp.setup()
require 'lspfuzzy'.setup{}

vim.cmd([[
  source ~/.config/nvim/settings/keymaps.vim
  source ~/.config/nvim/settings/functions.vim
  source ~/.config/nvim/settings/supertab.vim
  source ~/.config/nvim/settings/gundo.vim
  source ~/.config/nvim/settings/deoplete.vim
  source ~/.config/nvim/settings/nvim-tree.vim
  source ~/.config/nvim/settings/oscyank.vim
]])
