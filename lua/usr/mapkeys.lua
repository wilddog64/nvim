local wk = require('which-key')
vim.g.gundo_prefer_python3 = 1   -- Lua init

-- add key mappings for LazyGit
wk.add({
  mode = { 'n', 'i' },
  { '<leader>gi', function() vim.cmd([[ LazyGit ]]) end },
  { '<leader>gu', ':GundoToggle<CR>', desc = 'Toggle Gundo' },
  { '<leader>tw', function() require('mini.trailspace').trim() end },
})

wk.add({
  mode = { 'i' },
  { '<tab>', '<Plug>(copilot-accept-word)' },
  { '<c-e>', '<Plug>(copilot-accept-line)' },
})
