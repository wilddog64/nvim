-- common.lua - for lua plugin setup or options that need to be setup
-- after plugins are installed
-- simple setup for lsp-colors
require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})
