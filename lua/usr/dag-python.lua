vim.cmd([[
  augroup dag_python
  au!
  autocmd FileType py nmap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
  autocmd FileType py nmap <silent> <leader>df :lua require('dap-python').test_class()<CR>
  autocmd FileType py vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
  augroup END
]])
