-- common.lua - for lua plugin setup or options that need to be setup
-- after plugins are installed
-- simple setup for lsp-colors

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    -- Properly set includeexpr using Lua
    vim.opt_local.includeexpr = "substitute(v:fname, '\\.', '/', 'g') . '.lua'"
    local root_dir = require('usr.utils').get_lua_config_dir()
    if root_dir then
      vim.notify("lua root dir: " .. root_dir, vim.log.levels.INFO)
    end
  end,
})

vim.cmd[[
autocmd FileType lua lua local root_dir = require('usr.utils').get_lua_config_dir(vim.fn.expand('%:p'))
function! PuppetIncludeExpr() abort
  return luaeval("require'usr.utils'.resolve_puppet_path(_A)", expand('<cword>'))
endfunction
]]

-- Autocommand for Puppet filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = "puppet",
  callback = function()
    -- Use the Lua utility for includeexpr
    vim.opt_local.includeexpr = "PuppetIncludeExpr()"
    vim.opt_local.suffixesadd:append(".pp")      -- Add .pp as a suffix
    vim.opt_local.path:append("modules/**")      -- Add Puppet modules directory to path
  end,
})

