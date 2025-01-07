-- Conditional mappings for Copilot Chat buffer
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'copilot-chat',
    callback = function()
        vim.keymap.set('n', 'cd', '<cmd>ChatGotoDefinition<CR>', { buffer = true })
        vim.keymap.set('n', '<c-e>', '<cmd>CopilotChatAccept<CR>', { buffer = true })
    end,
})
