local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

lspconfig.lua_ls.setup({})

require("usr.lsp.zero")
-- require "usr.lsp.lsp-installer"
require("usr.lsp.handlers").setup()
require "usr.lsp.null-ls"
require("usr.lsp.config")
require('usr.lsp.setup')
require('usr.lsp.mason')
