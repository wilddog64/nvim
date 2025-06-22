require('mini.pick').setup({
  mappings = {
        toggle_info    = '<C-k>',
        toggle_preview = '<C-p>',
        move_down      = 'j',
        move_up        = 'k',
        scroll_left    = 'h',
        scroll_right   = 'l',
        mark           = '<SPACE>',
        choose_marked  = '<C-CR>',
  },
  windows = {
    window = {
      config = function()
        local editor_w = vim.o.columns
        local editor_h = vim.o.lines
        local win_w = math.floor(editor_w * 0.8)
        local win_h = math.floor(editor_h * 0.8)
        local row = math.floor((editor_h - win_h) / 2)
        local col = math.floor((editor_w - win_w) / 2)

        return {
          anchor = 'NW',
          border = 'single',
          style = 'minimal',
          relative = 'editor',
          width = win_w,
          heigh = win_h,
        }
      end,
    }
  }
})
