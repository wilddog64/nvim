-- redact.nvim: A Neovim Lua module to sanitize sensitive data in buffers
-- Place this file in ~/.config/nvim/lua/redact.lua

local M = {}

-- Default patterns to sanitize; override via enable_keymap(opts.patterns)
M.patterns = {
  -- sanitize host entries (case-insensitive)
  { pattern = '[Hh][Oo][Ss][Tt]:%s*[%w._%-]+',   replace = 'host: REDACTED_HOST' },
  { pattern = '[Ee][Xx][Tt][Ee][Rr][Nn][Aa][Ll][Hh][Oo][Ss][Tt]:%s*[%w._%-]+', replace = 'externalHost: REDACTED_EXTERNAL_HOST' },
  
  -- private IP ranges: 10.x.x.x, 192.168.x.x, 172.16.x.x - 172.31.x.x
  { pattern = '(%d+%.%d+%.%d+%.%d+)', replace = function(match)
      if match:match('^10%.') or match:match('^192%.168%.') or match:match('^172%.1[6-9]')
         or match:match('^172%.2[0-9]') or match:match('^172%.3[01]') then
        return 'REDACTED_IP'
      end
      return match
    end
  },

  -- internal domain names
  { pattern = '[%w._%-]+%.internal',       replace = 'REDACTED_DNS' },
  { pattern = '[%w._%-]+%.cluster%.local', replace = 'REDACTED_DNS' },

  -- bearer tokens or JWTs
  { pattern = 'Bearer%s+[%w._%-]+',        replace = 'Bearer REDACTED_TOKEN' },

  -- generic passwords
  { pattern = '[Pp]assword[:=]%s*["\']?[^"\',%s]+', replace = 'password: REDACTED' },

  -- email addresses
  { pattern = '[%w%.%-]+@[%w%.%-]+%.[A-Za-z][A-Za-z]+', replace = 'REDACTED_EMAIL' },

  -- handle http(s) URLs
  { pattern = 'https?://[%w%._%/:%?&=#-]+', replace = 'REDACTED_URL' },
}

-- enable_keymap: configure patterns and keybindings
-- opts = { patterns = {...}, mappings = { buffer, selection, copy, preview } }
function M.enable_keymap(opts)
  opts = opts or {}
  M.patterns = opts.patterns or M.patterns
  local maps = opts.mappings or {
    buffer    = '<leader>rb',
    selection = '<leader>rs',
    copy      = '<leader>rc',
    preview   = '<leader>rp',
  }

  -- user commands
  vim.api.nvim_create_user_command('RedactBuffer',    M.sanitize_buffer, {})
  vim.api.nvim_create_user_command('RedactSelection', M.sanitize_selection, { range = true })
  vim.api.nvim_create_user_command('RedactCopy',      M.copy_buffer, {})
  vim.api.nvim_create_user_command('RedactPreview',   M.preview_buffer, {})

  -- key mappings
  local km = vim.api.nvim_set_keymap
  km('n', maps.buffer,    ':RedactBuffer<CR>',    { noremap=true, silent=true })
  km('v', maps.selection, ':RedactSelection<CR>', { noremap=true, silent=true })
  km('n', maps.copy,      ':RedactCopy<CR>',      { noremap=true, silent=true })
  km('n', maps.preview,   ':RedactPreview<CR>',   { noremap=true, silent=true })
end

-- sanitize a single line
local function sanitize_line(line)
  for _, p in ipairs(M.patterns) do
    if type(p.replace) == 'function' then
      line = line:gsub(p.pattern, p.replace)
    else
      line = line:gsub(p.pattern, p.replace)
    end
  end
  return line
end

-- sanitize entire buffer in-place
function M.sanitize_buffer()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for i = 1, #lines do
    lines[i] = sanitize_line(lines[i])
  end
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

-- sanitize visual selection in-place
function M.sanitize_selection()
  local s = vim.fn.line("'<") - 1
  local e = vim.fn.line("'>")
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, s, e, false)
  for i = 1, #lines do
    lines[i] = sanitize_line(lines[i])
  end
  vim.api.nvim_buf_set_lines(bufnr, s, e, false, lines)
end

-- sanitize buffer and copy to clipboard
function M.copy_buffer()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for i = 1, #lines do
    lines[i] = sanitize_line(lines[i])
  end
  local text = table.concat(lines, "\n")
  vim.fn.setreg('+', text)
end

-- preview sanitized buffer in a split, original untouched
function M.preview_buffer()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local out = {}
  for i, line in ipairs(lines) do
    out[i] = sanitize_line(line)
  end
  vim.cmd('vnew')
  local nb = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(nb, 0, -1, false, out)
  -- make the preview buffer scratch and set filetype
  vim.api.nvim_buf_set_option(nb, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(nb, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(nb, 'swapfile', false)
  vim.api.nvim_buf_set_option(nb, 'filetype', vim.api.nvim_buf_get_option(bufnr, 'filetype'))
end

return M
