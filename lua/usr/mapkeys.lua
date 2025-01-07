local wk = require('which-key')

-- add key mappings for LazyGit
wk.add({
  mode = { 'n', 'i' },
  { '<leader>gi', function() vim.cmd([[ LazyGit ]]) end },
})
