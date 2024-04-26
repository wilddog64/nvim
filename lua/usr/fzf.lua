vim.cmd([[
  " Using Lua functions
  nnoremap <leader>cf <cmd>lua require('fzf-lua').lgrep_curbuf()<cr>
  nnoremap <leader>fb <cmd>lua require('fzf-lua').buffers()<cr>
  nnoremap <leader>ff <cmd>lua require('fzf-lua').files()<cr>
  nnoremap <leader>fg <cmd>:lua require('fzf-lua').live_grep_native()<cr>
  nnoremap <leader>fl <cmd>lua require('fzf-lua').loclist()<cr>
  nnoremap <leader>fh <cmd>lua require('fzf-lua').tags()<cr>
  inoremap <c-x><c-f> <cmd>lua require("fzf-lua").complete_path()<cr>
]])

