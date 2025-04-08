if not vim.fn.exists('+clipboard') then
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
  vim.notify('use win32yank')
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
else
  vim.notify('use osc52')
  vim.g.clipboard = {
    name = 'osc52',
    copy = {['+'] = copy, ['*'] = copy },
    paste = {['+'] = paste, ['*'] = paste },
  }
end

