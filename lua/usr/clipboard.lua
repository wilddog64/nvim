-- This script configures the clipboard for Neovim, allowing it to work without
-- the need for external clipboard managers. It uses the `osc52` plugin for each
-- clipboard operations and checks for the presence of `win32yank.exe` for Windows_NT
-- environments. The script also handles the case where clipboard support is not available
-- and notifies the user accordingly.
if not vim.fn.exists('+clipboard') then
  vim.notify('Clipboard support not available', vim.log.levels.WARN)
  return
end

local use_win32yank = vim.fn.executable('win32yank.exe') and not vim.fn.has('wsl')
if use_win32yank then
  vim.notify('Using win32yank for clipboard operations', vim.log.levels.INFO)
else
  vim.notify('Using osc52 for clipboard operations', vim.log.levels.INFO)
end

local function copy(lines, _)
  local content = table.concat(lines, '\n')
  if use_win32yank then
    local handle = io.popen('win32yank.exe -i --crlf', 'w')
    if handle then
      handle:write(content)
      handle:close()
    else
      vim.notify('copy content' .. content .. 'via osc52')
      require('osc52').copy(table.concat(lines, '\n'))
    end
  else
    require('osc52').copy(content)
  end
end

local function paste()
  if use_win32yank then
    local output = vim.fn.systemlist('win32yank.exe -o --lf')
    return { output, 'v' }
  else
    return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
  end
end

 vim.g.clipboard = {
   name = use_win32yank and 'win32yank' or 'osc52',
   copy = {['+'] = copy, ['*'] = copy },
   paste = {['+'] = paste, ['*'] = paste },
 }
