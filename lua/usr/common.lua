-- common.lua - for lua plugin setup or options that need to be setup
-- after plugins are installed
-- simple setup for lsp-colors

local utils = require('usr.utils')
vim.cmd[[
  function! PuppetIncludeExpr() abort
    return luaeval("require'usr.utils'.resolve_puppet_path()")
  endfunction

  " this function AnsibleIncludeExpr is to defer the includeexxpr evaluation
  function! AnsibleIncludeExpr() abort
    return luaeval("require'usr.utils'.resolve_ansible_path()")
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

-- Autocommand for Ansible filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml.ansible",
  callback = function()
    -- Use the Lua utility for includeexpr
    vim.opt_local.includeexpr = "AnsibleIncludeExpr()"
    local ansible_task_path = utils.resolve_ansible_path()
    if not ansible_task_path then
      utils.log('ansible task not found: ' .. ansible_task_path, vim.log.levels.WARN)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    -- Properly set includeexpr using Lua
    vim.opt_local.includeexpr = "substitute(v:fname, '\\.', '/', 'g') . '.lua'"
    local root_dir = require('usr.utils').get_lua_config_dir()
    if root_dir then
      utils.log("lua root dir: " .. root_dir, vim.log.levels.DEBUG)
    end
  end,
})

-- trim off whitespaces
vim.keymap.set('n', '<leader>tw', function() require('mini.trailspace').trim() end)
