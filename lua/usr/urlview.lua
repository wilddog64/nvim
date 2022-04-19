require('urlview').setup {
  default_picker = 'telescope'
}

vim.cmd [[
  map <leader>u :UrlView<cr>
  imap <leader>u <C-O>:UrlView<cr>
]]
