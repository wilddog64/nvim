local wk = require('which-key')

-- add key mappings for LazyGit
wk.add({
  { '<leader>gi', function() vim.cmd([[ LazyGit ]]) end },
})
