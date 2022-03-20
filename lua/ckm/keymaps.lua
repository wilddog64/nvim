local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

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
keymap("n", "cln", ":w/./,/./-1join", opts)
keymap("i", "cln", ":w/./,/./-1join", opts)
