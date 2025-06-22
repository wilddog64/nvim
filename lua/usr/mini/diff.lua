require('mini.pick').setup({
  window = {
    config = function()
      local screen_h = vim.o.lines
      local screen_w = vim.o.columns

      local win_h = math.floor(screen_h * 0.4)
      local win_w = math.floor(screen_w * 0.5)

      local row = math.floor((screen_h - win_h) / 2)
      local col = math.floor((screen_w - win_w) / 2)

      return {
        anchor = 'NW',
        border = 'single',
        style = 'minimal',
        relative = 'editor',
        row = row,
        col = col,
        width = win_w,
        height = win_h,
      }
    end
  }
})

local function pick_files_from_cwd()
  local cwd = vim.fn.getcwd()

  -- Collect files recursively from current directory
  local output = vim.fn.systemlist({ 'find', cwd, '-type', 'f' })

  -- Handle error or empty results
  if vim.v.shell_error ~= 0 then
    vim.notify("Error finding files", vim.log.levels.ERROR)
    return
  end

  -- Launch picker
  require('mini.pick').start({
    source = {
      items = output,
      name = 'Find Files'
    },
    -- Optional: on confirm, open selected file
    action = function(item)
      vim.cmd('edit ' .. vim.fn.fnameescape(item))
    end,
  })
end

vim.keymap.set('n', '<leader>df', pick_files_from_cwd, { desc = '[P]ick [F]ile (static list)' })
