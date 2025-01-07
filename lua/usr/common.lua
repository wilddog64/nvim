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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "puppet",
  callback = function()
    vim.opt_local.includeexpr = "PuppetIncludeExpr()"
    vim.opt_local.suffixesadd:append(".pp")
    vim.opt_local.path:append("modules/**")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml.ansible",
  callback = function()
    vim.opt_local.includeexpr = "AnsibleIncludeExpr()"
    local ansible_task_path = utils.resolve_ansible_path()
    if not ansible_task_path then
      utils.log('ansible task not found: ', vim.log.levels.WARN)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.includeexpr = "substitute(v:fname, '\\.', '/', 'g') . '.lua'"
    local root_dir = require('usr.utils').get_lua_config_dir()
    if root_dir then
      utils.log("lua root dir: ", vim.log.levels.DEBUG)
    end
  end,
})
