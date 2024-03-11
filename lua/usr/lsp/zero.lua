local lsp_zero = require('lsp-zero')
lsp_zero.extend_lspconfig()

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

lsp_zero.setup()

require 'lspfuzzy'.setup{}
vim.g.lsp_zero_extend_lspconfig = 0
