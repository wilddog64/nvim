-- This script configures the clipboard for Neovim, allowing it to work without
-- the need for external clipboard managers. It uses the `osc52` plugin for each
-- clipboard operations and checks for the presence of `win32yank.exe` for Windows_NT
-- environments. The script also handles the case where clipboard support is not available
-- and notifies the user accordingly.
if not vim.fn.exists('+clipboard') then
  vim.notify('Clipboard support not available', vim.log.levels.WARN)
  return
end

-- Check to see if win32yank is available
if vim.fn.executable('win32yank.exe') == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    }
  }
  vim.notify('Clipboard set to win32yank', vim.log.levels.INFO)
else -- else we use osc52
  -- copy and paste are functions that handle the copying and pasting of text
  -- using the `osc52` plugin. The `copy` function takes a table of lines and
  -- concatenates them into a single string,
  local function copy(lines, _)
    require('osc52').copy(table.concat(lines, '\n'))
  end

  local function paste()
    return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
  end

  vim.g.clipboard = {
    name = 'osc52',
    copy = {['+'] = copy, ['*'] = copy },
    paste = {['+'] = paste, ['*'] = paste },
  }
  vim.notify('Clipboard set to osc52', vim.log.levels.INFO)
end

