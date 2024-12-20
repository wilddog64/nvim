local lsp_zero = require('lsp-zero')
lsp_zero.extend_lspconfig()

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
  return -- Exit gracefully if lspconfig is not installed
end

-- Set up lua-language-server (lua_ls)
-- lspconfig.lua_ls.setup({
--   settings = {
--     Lua = {
--       runtime = {
--         version = "LuaJIT", -- Use LuaJIT for Neovim
--       },
--       diagnostics = {
--         globals = { "vim" }, -- Suppress "undefined global 'vim'" warning
--       },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime
--         checkThirdParty = false, -- Avoid third-party prompts
--       },
--       telemetry = { enable = false }, -- Disable telemetry
--     },
--   },
--   on_init = function(client)
--     print("lua-language-server initialized!")
--   end,
-- })

-- require "usr.lsp.lsp-installer"
require("usr.lsp.handlers").setup()
require "usr.lsp.null-ls"
require("usr.lsp.config")
require('usr.lsp.mason')
require('usr.lsp.setup')
require('usr.lsp.rttools')
