require('usr.options')

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

require('packer').startup(function(use)
  -- packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'echasnovski/mini.nvim'
  use 'ervandew/supertab'
  use 'corntrace/bufexplorer'
  use 'dbakker/vim-projectroot'
  use 'airblade/vim-gitgutter'
  use 'ojroques/vim-oscyank'
  use 'tpope/vim-fugitive'
  use 'tmux-plugins/vim-tmux'
  use 'tmux-plugins/vim-tmux-focus-events'
  use 'sjl/gundo.vim'
  use 'terryma/vim-multiple-cursors'

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

require('mini.base16').setup({
    palette = {
      base00 = '#112641',
      base01 = '#3a475e',
      base02 = '#606b81',
      base03 = '#8691a7',
      base04 = '#d5dc81',
      base05 = '#e2e98f',
      base06 = '#eff69c',
      base07 = '#fcffaa',
      base08 = '#ffcfa0',
      base09 = '#cc7e46',
      base0A = '#46a436',
      base0B = '#9ff895',
      base0C = '#ca6ecf',
      base0D = '#42f7ff',
      base0E = '#ffc4ff',
      base0F = '#00a5c5',
    },
    use_cterm = true,
})

require('mini.bufremove').setup({
    set_vim_settings = true
})

require('mini.comment').setup({
    comment = 'gc',
    comment_line = 'gcc',
    textobject = 'gc',
})

require('mini.completion').setup({
    lsp_completion = {
        source = 'omnifunc'
    }
})

-- vim.api.nvim_set_keymap('i', [[<Tab>]],   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   { noremap = true, expr = true })
-- vim.api.nvim_set_keymap('i', [[<S-Tab>]], [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })

require('mini.cursorword').setup {}
require('mini.fuzzy').setup {}
require('mini.indentscope').setup {}
require('mini.pairs').setup {}
require('mini.statusline').setup {}
require('mini.surround').setup {}
require('mini.trailspace').setup {}
require('mini.jump').setup {}
require('mini.sessions').setup {}

-- g:bufExplorerShowRelativePath=1
vim.g.bufExplorerShowRelativePath = 1
vim.cmd [[
    source ~/.config/nvim/settings/autocmd.vim
    source ~/.config/nvim/settings/keymaps.vim
    source ~/.config/nvim/settings/functions.vim
    source ~/.config/nvim/settings/supertab.vim
]]
