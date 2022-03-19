-- setup tab expansion
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

require('packer').startup(function(use)
  -- allow packer to manage itself
  use 'wbthomason/packer.nvim'

  -- colorscheme
  use 'joshdick/onedark.vim'
end)

vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
pcall(vim.cmd, 'colorscheme onedark')
