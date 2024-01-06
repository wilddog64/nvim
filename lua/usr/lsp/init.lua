
local lsp_zero = require('lsp-zero')
lsp_zero.extend_lspconfig()

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

lspconfig.lua_ls.setup({})

-- require "usr.lsp.lsp-installer"
require("usr.lsp.handlers").setup()
require "usr.lsp.null-ls"
require("usr.lsp.config")
require('usr.lsp.setup')
require('usr.lsp.mason')
