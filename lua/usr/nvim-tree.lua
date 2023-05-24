-- local ok, nvim_tree = pcall('require', 'nvim-tree')

local opts = { noremap = true, silent = true }

-- create an alias for option
local keymap = vim.api.nvim_set_keymap

-- set map leader to ;
vim.g.mapleader = ";"
vim.g.localleader = ";"

keymap("n", "<leader>n", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", opts)
keymap("n", "<leader>f", ":NvimTreeFindFile<CR>", opts)

-- setup with all defaults
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
-- require 'nvim-tree'.setup {} -- END_DEFAULT_OPTS

opts.actions = {}
opts.actions.open_file = {}
opts.actions.open_file.quit_on_open = true
-- nvim_tree.setup(opts)
-- require('nvim-tree').setup(opts)

