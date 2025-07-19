-- redact.nvim: sanitize buffers and preview in a floating window
local api = vim.api
local M = {}

-- Default sanitization patterns
M.patterns = {
  { pattern = '%f[%w][A-Za-z][A-Za-z0-9+%-%.]+://[%w%._%/:%?&=#%-]+', replace = 'REDACTED_URL' },
  { pattern = '[Hh][Oo][Ss][Tt]:%s*[%w%._%-]+', replace = 'host: REDACTED_HOST' },
  { pattern = '[Ee][Xx][Tt][Ee][Rr][Nn][Aa][Ll][Hh][Oo][Ss][Tt]:%s*[%w%._%-]+', replace = 'externalHost: REDACTED_EXTERNAL_HOST' },
  {
    pattern = '(%d+%.%d+%.%d+%.%d+)',
    replace = function(s)
      if s:match('^10%.')
         or s:match('^192%.168%.')
         or s:match('^172%.1[6-9]')
         or s:match('^172%.2[0-9]')
         or s:match('^172%.3[01]') then
        return 'REDACTED_IP'
      end
      return s
    end,
  },
  { pattern = '[%w%._%-]+%.internal', replace = 'REDACTED_DNS' },
  { pattern = '[%w%._%-]+%.cluster%.local', replace = 'REDACTED_DNS' },
  { pattern = 'Bearer%s+[%w._%-]+', replace = 'Bearer REDACTED_TOKEN' },
  { pattern = '[Pp]assword[:=]%s*["\']?[^"\',%s]+', replace = 'password: REDACTED' },
  { pattern = '[%w%.%-]+@[%w%.%-]+%.[A-Za-z][A-Za-z]+', replace = 'REDACTED_EMAIL' },
  { pattern = '[Tt]enant[Ii]d[:=]%s*[%w%-]+', replace = 'tenantId: REDACTED_TENANT_ID' },
  { pattern = '[Rr]epository[:=]%s*[%w%/._%-]+', replace = 'repository: REDACTED_REPO' },
  { pattern = '[Dd]bUsername[:=]%s*[%w._%-]+', replace = 'dbUsername: REDACTED_DB_USER' },
  { pattern = 'spring%%.datasource%%.username[:=]%s*[%w._%-]+', replace = 'spring.datasource.username: REDACTED_DB_USER' },
  { pattern = 'database[Nn]ame=[^;,%s]+', replace = 'databaseName=REDACTED_DB' },
}

-- Setup commands and keymaps
function M.enable_keymap(opts)
  opts = opts or {}
  M.patterns = opts.patterns or M.patterns
  local maps = opts.mappings or {
    buffer            = '<leader>rb',
    selection         = '<leader>rs',
    copy              = '<leader>rc',
    preview           = '<leader>rp',
    preview_selection = '<leader>rq',
  }

  -- create user commands for each action
  api.nvim_create_user_command('RedactBuffer',           M.sanitize_buffer, {})
  api.nvim_create_user_command('RedactSelectionPreview', M.preview_selection, { range = true })
  api.nvim_create_user_command('RedactSelection',        M.sanitize_selection, { range = true })
  api.nvim_create_user_command('RedactCopy',             M.copy_buffer, {})
  api.nvim_create_user_command('RedactPreview',          M.preview_buffer, {})
  api.nvim_create_user_command('RedactSelectionPreview', M.preview_selection, { range = true })

  -- set up key mappings
  api.nvim_set_keymap('n', maps.buffer,    ':RedactBuffer<CR>',    { noremap=true, silent=true })
  api.nvim_set_keymap('v', maps.selection, ':RedactSelection<CR>', { noremap=true, silent=true })
  api.nvim_set_keymap('n', maps.copy,      ':RedactCopy<CR>',      { noremap=true, silent=true })
  api.nvim_set_keymap('n', maps.preview,   ':RedactPreview<CR>',   { noremap=true, silent=true })
  api.nvim_set_keymap('v', maps.preview_selection, ':RedactSelectionPreview<CR>', { noremap=true, silent=true })
end

-- Internal sanitize function
local function sanitize_line(line)
  for _, pat in ipairs(M.patterns) do
    if type(pat.replace) == 'function' then
      line = line:gsub(pat.pattern, pat.replace)
    else
      line = line:gsub(pat.pattern, pat.replace)
    end
  end
  return line
end

-- Sanitize entire buffer in-place
function M.sanitize_buffer()
  local buf = api.nvim_get_current_buf()
  local lines = api.nvim_buf_get_lines(buf, 0, -1, false)
  for i = 1, #lines do lines[i] = sanitize_line(lines[i]) end
  api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

-- Sanitize visual selection in-place
function M.sanitize_selection()
  local s = vim.fn.line("'<") - 1
  local e = vim.fn.line("'>")
  local buf = api.nvim_get_current_buf()
  local lines = api.nvim_buf_get_lines(buf, s, e, false)
  for i = 1, #lines do lines[i] = sanitize_line(lines[i]) end
  api.nvim_buf_set_lines(buf, s, e, false, lines)
end

-- Copy sanitized buffer to clipboard without modifying buffer
function M.copy_buffer()
  local buf = api.nvim_get_current_buf()
  local lines = api.nvim_buf_get_lines(buf, 0, -1, false)
  for i = 1, #lines do lines[i] = sanitize_line(lines[i]) end
  vim.fn.setreg('+', table.concat(lines, '\n'))
end

-- Preview sanitized buffer in a floating window
function M.preview_buffer()
  local buf = api.nvim_get_current_buf()
  local lines = api.nvim_buf_get_lines(buf, 0, -1, false)
  local out = {}
  for i, line in ipairs(lines) do out[i] = sanitize_line(line) end

  local fb = api.nvim_create_buf(false, true)
  api.nvim_buf_set_lines(fb, 0, -1, false, out)
  api.nvim_buf_set_option(fb, 'filetype', api.nvim_buf_get_option(buf, 'filetype'))

  local width  = math.floor(vim.o.columns * 0.7)
  local height = math.floor(vim.o.lines   * 0.7)
  local row    = math.floor((vim.o.lines  - height) / 2)
  local col    = math.floor((vim.o.columns - width ) / 2)

  api.nvim_open_win(fb, true, {
    relative   = 'editor',
    row        = row,
    col        = col,
    width      = width,
    height     = height,
    style      = 'minimal',
    border     = 'rounded',
    title      = 'Redact Preview q: quit, c: copy',
    title_pos  = 'center',
  })

  -- Set keymaps for the floating window
  api.nvim_buf_set_keymap(fb, 'n', 'q', '<cmd>close<CR>',           { nowait=true, noremap=true, silent=true })
  api.nvim_buf_set_keymap(fb, 'n', 'c', '<cmd>normal! ggVG"+y<CR>', { nowait=true, noremap=true, silent=true })
end

-- Preview only the selection in floating window
function M.preview_selection()
  -- Ensure we have a visual selection
  local s = vim.fn.line("'<") - 1
  local e = vim.fn.line("'>")
  local buf = api.nvim_get_current_buf()
  local lines = api.nvim_buf_get_lines(buf, s, e, false)

  -- Sanitize the selected lines
  local out = {}
  for i, line in ipairs(lines) do out[i] = sanitize_line(line) end

  -- Create a floating buffer to display the sanitized selection
  local fb = api.nvim_create_buf(false, true)
  api.nvim_buf_set_lines(fb, 0, -1, false, out)
  api.nvim_buf_set_option(fb, 'filetype', api.nvim_buf_get_option(buf, 'filetype'))

  -- Set up floating window dimensions and position
  -- Use 70% of the editor size for the floating window
  local width  = math.floor(vim.o.columns * 0.7)
  local height = math.floor(vim.o.lines   * 0.7)
  local row    = math.floor((vim.o.lines  - height) / 2)
  local col    = math.floor((vim.o.columns - width ) / 2)
  api.nvim_open_win(fb, true, {
    relative   = 'editor',
    row        = row,
    col        = col,
    width      = width,
    height     = height,
    style      = 'minimal',
    border     = 'rounded',
    title      = 'Redact Preview: q: quit, c: copy',
    title_pos  = 'center',
  })

  -- Set keymaps for the floating window
  api.nvim_buf_set_keymap(fb, 'n', 'q', '<cmd>close<CR>',           { nowait=true, noremap=true, silent=true })
  api.nvim_buf_set_keymap(fb, 'n', 'c', '<cmd>normal! ggVG"+y<CR>', { nowait=true, noremap=true, silent=true })
end

return M
