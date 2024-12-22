-- General utility function to find a project or config directory
local M = {}

M.find_config_dir = function(fname, markers)
  local startpath = fname and vim.fs.dirname(fname) or vim.fn.getcwd()
  local found_dir = vim.fs.find(markers, { path = startpath, upward = true })[1]
  vim.notify("start path: " .. startpath, vim.log.levels.DEBUG)
  vim.notify("found_dir: " .. found_dir, vim.log.levels.DEBUG)

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
  -- proper puppet directory. if [ and  ] found, remove them
  local current_word = vim.fn.expand("<cWORD>")
  if current_word:find("%[") and current_word:find("%]") then
    current_word = current_word:gsub("^Class%['", ""):gsub("'%]$", "")
  end
  local manifests_dir = current_word:gsub('::', '/manifests/')
  local puppet_manifest = base_dir .. '/' .. manifests_dir .. '.pp'

  vim.notify("base directory: " .. base_dir, vim.log.levels.DEBUG)
  vim.notify("current caputre WORD: " .. current_word, vim.log.levels.DEBUG)
  vim.notify("manifests_dir: " .. manifests_dir, vim.log.levels.DEBUG)
  vim.notify("puppet manifest: " .. puppet_manifest, vim.log.levels.DEBUG)

  -- check if file exists and return it
  if vim.fn.filereadable(puppet_manifest) then
    return puppet_manifest
  end

  -- return "" if file does not exist
  vim.notify("Puppet file does not exist: " .. puppet_manifest, vim.log.levels.WARN)
  return ""
end

return M
