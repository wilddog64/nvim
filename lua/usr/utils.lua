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
  -- find a project root base on git repo or return current directory if
  -- it is not
  local startpath = fname and vim.fs.dirname(fname) or vim.fn.getcwd()
  local found_dir = vim.fs.find(markers, { path = startpath, upward = true })[1]
  M.log("start path: " .. startpath, vim.log.levels.DEBUG)
  M.log("found_dir: " .. found_dir, vim.log.levels.DEBUG)

  -- return directory name or nil if not found
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
    { ".git", "modules", "role", "profile" }) or vim.fn.getcwd()

  -- Get the current line's content get puppet resource from where cursor is, and
  -- trim of any whitespaces around it
  local line=vim.fn.getline(".")
  local puppet_manifest_ref = vim.fn.trim(line)

  -- if [ and ] were found extract xyz from Class['xyz'] ->
  if puppet_manifest_ref:find("%[") and puppet_manifest_ref:find("%]") then
    puppet_manifest_ref = puppet_manifest_ref:gsub("^Class%['", ""):gsub("'%]", "")
    puppet_manifest_ref = vim.fn.substitute(puppet_manifest_ref, '\\s*->', '', 'g')
    puppet_manifest_ref = vim.fn.substitute(puppet_manifest_ref, " -$", "", "")
  end

  -- remove include if there's any
  if puppet_manifest_ref:find("include") then
    puppet_manifest_ref = vim.fn.substitute(puppet_manifest_ref, "include ", "", "i")
  end

  -- add /manifests/ between base_dir and puppet_ref
  local manifests_dir = puppet_manifest_ref:gsub('::', '/manifests/')
  local puppet_manifest = base_dir .. '/' .. manifests_dir .. '.pp'

  -- debug output
  M.log("base directory: " .. base_dir, vim.log.levels.DEBUG)
  M.log("current caputre WORD: " .. puppet_manifest_ref, vim.log.levels.DEBUG)
  M.log("manifests_dir: " .. manifests_dir, vim.log.levels.DEBUG)
  M.log("puppet manifest: " .. puppet_manifest, vim.log.levels.DEBUG)

  -- check if file exists and return it
  if vim.fn.filereadable(puppet_manifest) then
    return puppet_manifest
  end

  if vim.fn.matchstr(puppet_manifest_ref, 'lookup') then
    local search_pattern = vim.fn.matchstr(puppet_manifest_ref, "['\"]\\zs[^\"]\\+']")
    if search_pattern then
      local datadir = base_dir .. '/data/'
      local loclist = M.search_pattern_infiles(datadir, search_pattern)
      vim.fn.setloclist(0, {}, 'r', {title = 'SEarch Results', items = loclist})
      return ''
    end
  end

  -- return "" if file does not exist
  M.log("Puppet file does not exist: " .. puppet_manifest, vim.log.levels.WARN)
  return ""
end

M.search_pattern_infiles = function(dir, pattern)
  -- use rg to search pattern in a given directory
  local rg_cmd = 'rg --no-heading -n --with-filename --color=never --column ' .. pattern

  -- execute rg_cmd and read all output into a result varabile
  local handle = io.popen(rg_cmd)
  if not handle then
    return nil
  end
  local result = handle:read('*a')
  handle:close()

  -- check if there any result came back
  if result == "" then
    M.log("no match found for " .. pattern, vim.log.levels.INFO)
    return ''
  end

  -- now create a location list with these entries
  -- filename, location number, column, and text
  local loclist = {}
  for line in result:gmatch("[^\r\n]+") do
    local file, lnum, col, text = line:match("([^:]+):(%d+):(%d+):(.*)")
    if file and lnum and col and text then
      table.insert(loclist, {
        filename = file,
        lnum = tonumber(line),
        col = tonumber(col),
        text = text
      })
    end
  end

  -- call vim function setLocList to popular a location list
  return loclist
end

M.resolve_ansible_path = function()
  -- convert ansible module refereces to directory paths

  -- figure out our ansible base directory by looking at .git or tasks directories
  -- if not, then use current directory
  local base_dir = M.find_config_dir(vim.fn.expand("%:p"),
    { ".git", "tasks" }) or vim.fn.getcwd()
  M.log('ansible bsae directory: ' .. base_dir, vim.log.levels.DEBUG)

  -- now get current line from where cursor is, and
  -- remove any leading or trailing whitespaces
  local line = vim.fn.getline('.')
  local ansible_task_path = vim.fn.trim(line)
  M.log('ansible task: ' .. ansible_task_path, vim.log.levels.DEBUG)

  -- if - include_tasks: is found, then the rmove it and the double quotes
  if ansible_task_path:find('- include_tasks:') then
    ansible_task_path = vim.fn.substitute(ansible_task_path, '- include_tasks: ', '', '')
    ansible_task_path = vim.fn.substitute(ansible_task_path, '"', '', 'g')
    M.log('ansible task path : ' .. ansible_task_path, vim.log.levels.DEBUG)
  end

  -- concatnate base directory and ansible task path with /
  -- and return it back to caller if ansible_task_path exist
  ansible_task_path = base_dir .. '/' .. ansible_task_path
  if vim.fn.filereadable(ansible_task_path) then
    return ansible_task_path
  end

  -- return "" if we reach here3
  return ""
end

return M
