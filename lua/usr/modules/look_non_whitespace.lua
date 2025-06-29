M = {}

vim.g.replicate_non_whitespace_key = '<C-Y>'
M.look_non_whitespace = function ()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, row, false)
  for i = #lines - 1, 0, -1 do
    local line = lines[i + 1]
    if #line >= col then
      local char = line:sub(col, col)
      if char:match("%S") then
        return char
      end
    end
  end
  return ""
end

function M.enable_keymap()
  local group = vim.api.nvim_create_augroup("look_non_whitespace_map", { clear = true })
  vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    pattern = "*.lua",
    callback = function(event)
      local bufnr = event.buf
      local hotkey = vim.b[bufnr].replicate_non_whitespace_key or vim.g.replicate_non_whitespace_key or "<C-Y>"
      vim.api.nvim_buf_set_keymap(bufnr, "i", hotkey, "", {
        silent = true,
        callback = function()
          local char = M.look_non_whitespace()
          vim.api.nvim_put({char}, 'c', true, true)
        end,
      })
    end,
  })
end

return M
