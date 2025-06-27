require('usr.modules.lua_dir')

local luamap_group = vim.api.nvim_create_augroup("luamap", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
  group = luamap_group,
  pattern = "*.lua",
  callback = function(event)
    local bufnr = event.buf
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gf", "", {
      silent = true,
      callback = function()
        local get_lua_config = require("usr.modules.lua_dir")
        local path = get_lua_config.get_lua_config_dir()
        if path and path ~= "" then
          vim.cmd("edit " .. path)
        end
      end,
    })
  end,
})

