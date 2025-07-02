local M = {}

-- The RemoveLastPathComponent function strips the last path component from a path
-- It's equivalent to the VimScript function in settings/functions.vim
M.remove_last_path_component = function()
  local cmdline = vim.fn.getcmdline()
  local cmdroot = vim.fn.fnamemodify(cmdline, ':r')

  if cmdline == cmdroot then
    -- Remove the last path component or trailing slash
    -- We use vim.fn.substitute to maintain the exact same regex behavior
    return vim.fn.substitute(
      cmdline,
      [[\%(\\ \|[\/]\@!\f\)\+[\/]\=$\|.$]],
      '',
      ''
    )
  end

  return cmdroot
end

-- Set up the command mode keymap similar to the original cnoremap
function M.enable_keymap()
  vim.api.nvim_set_keymap('c', '<C-w>', 
    [[<C-\>e luaeval("require('usr.modules.remove_last_path').remove_last_path_component()")<CR>]],
    { noremap = true })
end

return M

