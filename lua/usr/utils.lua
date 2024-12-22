-- General utility function to find a project or config directory
local M = {}

M.log = function(message, level)
  local current_log_level = vim.log.levels.INFO
  if level >= current_log_level then
    local info = debug.getinfo(3, "Sl") -- Get the third-level caller info
    local context = string.format("[%s:%d]", info.short_src, info.currentline)
    vim.notify(context .. " " .. message, level)
  end
end

M.find_config_dir = function(fname, markers)
  local startpath = fname and vim.fs.dirname(fname) or vim.fn.getcwd()
  local found_dir = vim.fs.find(markers, { path = startpath, upward = true })[1]
  M.log("start path: " .. startpath, vim.log.levels.DEBUG)
  M.log("found_dir: " .. found_dir, vim.log.levels.DEBUG)

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

  -- get puppet resource from where cursor is, and then construct
  -- proper puppet directory. if [ and  ] found, remove them
  local puppet_manifest_ref = vim.fn.expand("<cWORD>")
  if puppet_manifest_ref:find("%[") and puppet_manifest_ref:find("%]") then
    puppet_manifest_ref = puppet_manifest_ref:gsub("^Class%['", ""):gsub("'%]$", "")
  end
  local manifests_dir = puppet_manifest_ref:gsub('::', '/manifests/')
  local puppet_manifest = base_dir .. '/' .. manifests_dir .. '.pp'

  M.log("base directory: " .. base_dir, vim.log.levels.DEBUG)
  M.log("current caputre WORD: " .. puppet_manifest_ref, vim.log.levels.DEBUG)
  M.log("manifests_dir: " .. manifests_dir, vim.log.levels.DEBUG)
  M.log("puppet manifest: " .. puppet_manifest, vim.log.levels.DEBUG)

  -- check if file exists and return it
  if vim.fn.filereadable(puppet_manifest) then
    return puppet_manifest
  end

  -- return "" if file does not exist
  M.log("Puppet file does not exist: " .. puppet_manifest, vim.log.levels.WARN)
  return ""
end

return M
