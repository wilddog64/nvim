-- Conditional mappings for Copilot Chat buffer
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'copilot-chat',
    callback = function()
        vim.keymap.set('n', 'cd', '<cmd>ChatGotoDefinition<CR>', { buffer = true })
        vim.keymap.set('n', '<c-e>', '<cmd>CopilotChatAccept<CR>', { buffer = true })
    end,
})

-- Key mappings for Copilot Chat
vim.api.nvim_set_keymap('n', '<leader>cce', ':CopilotChatExplain<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cct', ':CopilotChatTest<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ccr', ':CopilotChatReview<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cc', ':CopilotChatToggle<CR>', { noremap = true, silent = true })

-- Map <leader>a to accept the word from Copilot
vim.api.nvim_set_keymap('i', '<leader>a', '<Plug>(copilot-accept-word)', {})

-- Disable default tab mapping for Copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap('i', '<Tab>', 'copilot#Accept("\\<CR>")', { expr = true, silent = true })
