local M = {}

vim.g.lua_dir_hotkey = 'gf'

M.get_lua_config_dir = function()
  local word = vim.api.nvim_get_current_line()

  if not string.find(word, "require", 1, true) then
    local tilde_pos = string.find(word, "~", 1, true)
    if tilde_pos then
      word = vim.fn.expand(string.sub(word, tilde_pos))
      if vim.fn.filereadable(word) == 1 then
        return word
      end
    end
  end

  local looking_for = "'"
  if not string.find(word, looking_for, 1, true) then
    looking_for = '"'
  end

  local first_quote = string.find(word, looking_for, 1, true)
  if not first_quote then
    return ""
  end
  first_quote = first_quote + 1

  local second_quote = string.find(word, looking_for, first_quote, true)
  if not second_quote then
    return ""
  end

  local lua_path = string.sub(word, first_quote, second_quote - 1)
  local lua_file_path = "./lua/" .. lua_path:gsub("%.", "/")
  local lua_file = lua_file_path .. ".lua"
  if vim.fn.filereadable(lua_file) == 1 then
    return lua_file
  else
    local lua_init_file = lua_file_path .. "/init.lua"
    if vim.fn.filereadable(lua_init_file) == 1 then
      return lua_init_file
    end
  end

  return ""
end

function M.enable_keymap()
  local group = vim.api.nvim_create_augroup("luamap", { clear = true })
  vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    pattern = "*.lua",
    callback = function(event)
      local bufnr = event.buf
      local hotkey = vim.b[bufnr].lua_dir_hotkey or vim.g.lua_dir_hotkey or "gf"
      vim.api.nvim_buf_set_keymap(bufnr, "n", hotkey, "", {
        silent = true,
        callback = function()
          local path = M.get_lua_config_dir()
          if path and path ~= "" then
            vim.cmd("edit " .. path)
          end
        end,
      })
    end,
  })
end

return M
