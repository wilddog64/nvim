require('mini.completion').setup({
  deplay = {
    complete = math.huge,
  }
})

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.MiniCompletion.complete()', { expr = true, noremap = true  })
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.MiniCompletion.smart_tab()', { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.MiniCompletion.smart_cr()', { expr = true, noremap = true })
