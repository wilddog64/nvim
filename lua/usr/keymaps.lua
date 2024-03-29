local opts = { noremap = true, silent = true }

-- create an alias for option
local keymap = vim.api.nvim_set_keymap

-- set map leader to ;
vim.g.mapleader = ";"
vim.g.localleader = ";"

-- control return will open a line in either normal or insert mode
keymap("n", "<C-CR>", "o", opts)
keymap("i", "<C-CR>", "<C-O>o", opts)

-- control option return will append ; at the end, and open a new line
keymap("n", "<C-D-CR>", "A;<CR>", opts)
keymap("i", "<C-D-CR>", "<C-O>A;<CR>", opts)

-- control-s will update buffer in nomad, and insert mode
keymap("n", "<C-S>", ":update<CR>", opts)
keymap("i", "<C-S>", "<C-O>:update<CR>", opts)

-- remap <c-u> and <c-w> to allow undo
keymap("i", "<c-u>", "<c-g>u<c-u>", opts)
keymap("i", "<c-w>", "<c-g>u<c-w>", opts)

-- compress empty lines
keymap("n", "cln", ":v/./,/./-1join<C-R>", opts)
keymap("i", "cln", ":v/./,/./-1join<C-R>", opts)

-- key maps for nvim-osc52
vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, {expr = true})
vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
vim.keymap.set('v', '<leader>c', require('osc52').copy_visual)
