vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN]  = '',
      [vim.diagnostic.severity.INFO]  = '',
      [vim.diagnostic.severity.HINT]  = '',
    },
    numhl = {
      [vim.diagnostic.severity.WARN]  = 'WarningMsg',
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.INFO]  = 'DiagnosticInfo',
      [vim.diagnostic.severity.HINT]  = 'DiagnosticHint',

    },
  },
})

-- hover for diagnostic
vim.opt.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(bor, {focus=false, border='rounded', scope='cursor'})]]

require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})

