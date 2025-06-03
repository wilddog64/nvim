local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 10,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)

  vim.keymap.set("t", "<leader>h", [[<C-\><C-n><C-w>h]], { noremap = true, silent = true, buffer = true })
  vim.keymap.set("t", "<leader>j", [[<C-\><C-n><C-w>j]], { noremap = true, silent = true, buffer = true })
  vim.keymap.set("t", "<leader>k", [[<C-\><C-n><C-w>k]], { noremap = true, silent = true, buffer = true })
  vim.keymap.set("t", "<leader>l", [[<C-\><C-n><C-w>l]], { noremap = true, silent = true, buffer = true })
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=50 direction=vertical<CR>", { noremap = true, silent = true  })
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", { noremap = true, silent = true  })
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm size=50 direction=float<CR>", { noremap = true, silent = true  })
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", { noremap = true, silent = true  })

-- Auto yank to clipboard only inside ToggleTerm
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   callback = function()
--     local bufname = vim.api.nvim_buf_get_name(0)
--     if bufname:match("term://.*toggleterm#") and vim.v.event.operator == "y" then
--       -- Copy from unnamed register to system clipboard
--       vim.fn.setreg("+", vim.fn.getreg('"'))
--     end
--
--   end,
-- })

-- local Terminal = require("toggleterm.terminal").Terminal
-- local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
--
-- function _LAZYGIT_TOGGLE()
-- 	lazygit:toggle()
-- end
