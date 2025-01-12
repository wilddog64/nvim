local wk = require('which-key')

-- add key mappings for LazyGit
wk.add({
  mode = { 'n', 'i' },
  { '<leader>gi', function() vim.cmd([[ LazyGit ]]) end },
  { '<leader>tw', function() require('mini.trailspace').trim() end },

  -- Add chat history mappings
  { '<leader>hs', function()
      require("usr.copilot-chat-history").save_chat_history()
      vim.notify("Copilot chat history saved")
    end
  },
  { '<leader>hl', function()
      require("usr.copilot-chat-history").restore_chat_history()
      vim.notify("Copilot chat history restored")
    end
  },
})
