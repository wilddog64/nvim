-- setup tab expansion
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.softtabstop = 3
vim.opt.expandtab = true

require('usr.options')
require('usr.plugins')
require('usr.cmp')
-- require('usr.treesitter')
require('usr.lsp')
require('usr.dag-python')
require('usr.lualine')
require('usr.toggleterm')
require('usr.telescope')
-- require('usr.telescope-livegrep-arg')
require('usr.python-dap')
require('usr.urlview')
require('usr.luasnip')
require('usr.mini')
require('usr.common')
require('usr.osc52')
require('usr.win32yank')
require('usr.nvim-tree')

local lsp = require('lsp-zero').preset('recommended')
lsp.nvim_workspace()
lsp.setup()

require 'lspfuzzy'.setup{}

vim.cmd([[
  source ~/.config/nvim/settings/keymaps.vim
  source ~/.config/nvim/settings/functions.vim
  source ~/.config/nvim/settings/supertab.vim
  source ~/.config/nvim/settings/gundo.vim
  source ~/.config/nvim/settings/deoplete.vim
  source ~/.config/nvim/settings/autocmd.vim
  source ~/.config/nvim/settings/options.vim
  source ~/.config/nvim/settings/vimux.vim
  source ~/.config/nvim/settings/markdown.vim
  source ~/.config/nvim/settings/asterisk.vim
  source ~/.config/nvim/settings/vim_maximizer.vim
]])
