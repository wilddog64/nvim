-- common.lua - for lua plugin setup or options that need to be setup
-- after plugins are installed
-- simple setup for lsp-colors

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    -- Properly set includeexpr using Lua
    vim.opt_local.includeexpr = "substitute(v:fname, '\\.', '/', 'g') . '.lua'"
    local root_dir = require('usr.utils').get_lua_config_dir(vim.fn.expand("%:p"))
    if root_dir then
      print("Lua Root Dir: " .. root_dir)
    end
  end,
})

vim.cmd[[
autocmd FileType lua lua local root_dir = require('usr.utils').get_lua_config_dir(vim.fn.expand('%:p'))
]]

