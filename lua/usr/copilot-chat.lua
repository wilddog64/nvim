-- Conditional mappings for Copilot Chat buffer
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'copilot-chat',
    callback = function()
        vim.keymap.set('n', 'cd', '<cmd>ChatGotoDefinition<CR>', { buffer = true })
        vim.keymap.set('n', '<leader>e', '<cmd>CopilotChatAccept<CR>', { buffer = true })
    end,
})

local wk = require('which-key')
wk.add({
  { '<leader>cc', function() vim.cmd([[ CopilotChatToggle ]]) end },
  { '<leader>cce', function() vim.cmd([[ CopilotChatExplain ]]) end },
  { '<leader>ccr', function() vim.cmd([[ CopilotChatReview ]]) end },
  { '<leader>cct', function() vim.cmd([[ CopilotChatTest ]]) end },
})
