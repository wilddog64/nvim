-- setup tab expansion
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true


require('ckm.plugins')

-- add lsp configuration
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.nvim_workspace()
lsp.setup()

require('lspfuzzy').setup {}

vim.cmd([[
  source ~/.config/nvim/settings/general.vim
  source ~/.config/nvim/settings/keymaps.vim
  source ~/.config/nvim/settings/functions.vim
  source ~/.config/nvim/settings/supertab.vim
]])
