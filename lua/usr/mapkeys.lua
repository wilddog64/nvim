local wk = require('which-key')

-- add key mappings for LazyGit
wk.add({
  mode = { 'n', 'i' },
  { '<leader>gi', function() vim.cmd([[ LazyGit ]]) end },
})

wk.add({
  mode = { 'i' },
  { '<tab>', '<Plug>(copilot-accept-word)' },
  { '<c-e>', '<Plug>(copilot-accept-line)' },
})

wk.add({
  { '<leader>tw', function() require('mini.trailspace').trim() end },
})
