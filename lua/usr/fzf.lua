vim.cmd([[
  " Using Lua functions
  nnoremap <leader>cf <cmd>lua require('fzf-lua.builtin').current_buffer_fuzzy_find()<cr>
  nnoremap <leader>fa <cmd>lua require('fzf-lua.builtin').autocommands()<cr>
  " "nnoremap <leader>fb <cmd>lua require('fzf-lua.builtin').buffers()<cr>
  nnoremap <leader>fb :Buffers<cr>
  nnoremap <leader>fc <cmd>lua require('telescope.builtin').commands()<cr>
  nnoremap <leader>ff <cmd>lua require('fzf-lua').files()<cr>
  nnoremap <leader>fg <cmd>:lua require('fzf-lua').live_grep_native()<cr>
  nnoremap <leader>fl <cmd>lua require('fzf-lua').loclist()<cr>
  nnoremap <leader>fh <cmd>lua require('fzf-lua').tags()<cr>
  nnoremap <leader>fk <cmd>lua require('fzf-lua.builtin').keymaps()<cr>
  " nnoremap <leader>fm <cmd>lua require('fzf-lua.builtin').marks()<cr>
  nnoremap <leader>fm :Marks<cr>
  nnoremap <leader>fr <cmd>lua require('fzf-lua.builtin').registers()<cr>
  nnoremap <leader>fs <cmd>lua require('fzf-lua.builtin').grep_string()<cr>
  nnoremap <leader>ss <cmd>lua require('fzf-lua.builtin').spell_suggest()<cr>
  nnoremap <leader>fj <cmd>lua require('fzf-lua.builtin').jumplist()<cr>
]])

