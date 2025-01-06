-- use which-key
local wk = require('which-key')

-- add key mappings for various fzf-lua functions
wk.add({
  { '<leader>cf', function() require"fzf-lua".lgrep_curbuf() end },
  { '<leader>ff', function() require"fzf-lua".files() end },
  { '<leader>fb', function() require"fzf-lua".buffers() end },
  { '<leader>fl', function() require"fzf-lua".lines() end },
  { '<leader>fg', function() require"fzf-lua".live_grep_native() end },
  { '<leader>fc', function() require"fzf-lua".loclist() end },
  { '<leader>ft', function() require"fzf-lua".tags() end },
})
