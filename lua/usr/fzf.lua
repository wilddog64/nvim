-- use which-key
local wk = require('which-key')

-- add key mappings for various fzf-lua functions
wk.add({
  { '<leader>cf', function() require"fzf-lua".lgrep_curbuf() end, group = 'fzf' },
  { '<leader>ff', function() require"fzf-lua".files() end, group = 'fzf' },
  { '<leader>fb', function() require"fzf-lua".buffers() end, group = 'fzf' },
  { '<leader>fl', function() require"fzf-lua".lines() end, group = 'fzf' },
  { '<leader>fg', function() require"fzf-lua".live_grep_native() end, group = 'fzf' },
  { '<leader>fc', function() require"fzf-lua".loclist() end, group = 'fzf' },
  { '<leader>ft', function() require"fzf-lua".tags() end, group = 'fzf' },
})

