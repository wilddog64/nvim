-- setup tab expansion
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.softtabstop = 3
vim.opt.expandtab = true

-- require('usr.treesitter')
-- require('usr.telescope')
-- require('usr.telescope-livegrep-arg')
-- require('usr.urlview')

require('usr.options')
require('usr.lazy')
require('usr.cmp')
require('usr.lsp')
require('usr.dag-python')
require('usr.lualine')
require('usr.toggleterm')
require('usr.python-dap')
require('usr.luasnip')
require('usr.mini')
require('usr.common')
require('usr.clipboard')
require('usr.nvim-tree')
require('usr.fzf')
require('usr.copilot')
require('usr.copilot-chat')
require('usr.mapkeys')
require('usr.kubectl')
require('usr.visual_sign')
require('usr.modules').enable_lua_dir_keymap()

vim.cmd([[
  source ~/.config/nvim/settings/keymaps.vim
  source ~/.config/nvim/settings/functions.vim
  source ~/.config/nvim/settings/gundo.vim
  source ~/.config/nvim/settings/autocmd.vim
  source ~/.config/nvim/settings/options.vim
  source ~/.config/nvim/settings/markdown.vim
  source ~/.config/nvim/settings/asterisk.vim
]])
