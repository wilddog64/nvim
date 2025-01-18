local wk = require('which-key')

-- add key mappings for LazyGit
wk.add({
  mode = { 'n', 'i' },
  { '<leader>gi', function() vim.cmd([[ LazyGit ]]) end },
  { '<leader>tw', function() require('mini.trailspace').trim() end },
  { '<tab>', '<Plug>(copilot-accept-word)' },
  { '<c-a>', '<Plug>(copilot-accept-line)' },
  { '<c-e>', '<Plug>(copilot-accept)' },
})
