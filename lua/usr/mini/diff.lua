require('mini.pick').setup({
  window = {
    config = function()
      local editor_w = vim.o.columns
      local editor_h = vim.o.lines

      local win_w = math.floor(editor_w * 0.5)
      local win_h = math.floor(editor_h * 0.4)

      local row = math.floor((editor_h - win_h) / 2 - 1)
      local col = math.floor((editor_w - win_w) / 2)

      return {
        anchor = 'NW',
        row = row,
        col = col,
        width = win_w,
        height = win_h,
        border = 'single',
        style = 'minimal',
      }
    end,
  },
  mappings = {
    move_down = 'j',
    move_up = 'k',
    choose = '<CR>',
  },
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
