local wk = require('which-key')

wk.add({
  {'<leader>ce', function() require'chatgpt'.edit_with_instructions({}) end}
})

vim.api.nvim_set_keymap("i", "<CR>", [[<cmd>lua require('chatgpt').submit()<CR>]], { noremap = true, silent = true })

