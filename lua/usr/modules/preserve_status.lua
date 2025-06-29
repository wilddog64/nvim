local M = {}

function M.preserve_state(cmd)
  local search = vim.fn.getreg('/')
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd(cmd)
  vim.fn.setreg('/', search)
  vim.api.nvim_win_set_cursor(0, pos)
end

return M

