if not vim.fn.exists('+clipboard') then
  vim.notify('Clipboard support not available', vim.log.levels.WARN)
  return
end

local function copy(lines, _)
  require('osc52').copy(table.concat(lines, '\n'))
end

local function paste()
  return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
end

-- vim.opt.clipboard = "unnamedplus"
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
else
  vim.g.clipboard = {
    name = 'osc52',
    copy = {['+'] = copy, ['*'] = copy },
    paste = {['+'] = paste, ['*'] = paste },
  }
  vim.notify('Clipboard set to osc52', vim.log.levels.INFO)
end

