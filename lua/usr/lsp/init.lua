local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "usr.lsp.lsp-installer"
require("usr.lsp.handlers").setup()
require "usr.lsp.null-ls"
require("usr.lsp.config")

local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.nvim_workspace(
  { library = vim.api.nvim_get_runtime_file('', true) }
)
