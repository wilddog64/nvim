-- General utility function to find a project or config directory
local M = {}

M.find_config_dir = function(fname, markers)
  local startpath = fname and vim.fs.dirname(fname) or vim.fn.getcwd()
  local found_dir = vim.fs.find(markers, { path = startpath, upward = true })[1]
  return found_dir and vim.fs.dirname(found_dir) or nil
end

M.get_lua_config_dir = function ()
  return M.find_config_dir(vim.fn.expand('%:p'), { 'init.lua', '.git', 'lua-config' })
end

-- Resolve Puppet module paths to file paths
M.resolve_puppet_path = function()
  -- Convert Puppet module references to directory paths

  -- figure out root directory from git repo if any; otherwise,
  -- from current directory
  local base_dir = M.find_config_dir(vim.fn.expand("%:p"),
    { ".git", "modules" }) or vim.fn.getcwd()

  -- get WORD from where cursor is, and then construct
  -- proper puppet directory
  local current_word = vim.fn.expand("<cWORD>")
  local cword = current_word:gsub('::', '/manifests/')
  local puppet_manifest = base_dir .. '/' .. cword .. '.pp'

  -- check if file exists and return it
  if vim.fn.filereadable(puppet_manifest) then
    return puppet_manifest
  end

  -- return "" if file does not exist
  vim.notify("Puppet file does not exist: " .. puppet_manifest, vim.log.levels.WARN)
  return ""
end

return M
