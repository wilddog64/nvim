-- require('mini.indentscope').setup({
--   options = {
--     try_as_border = true,
--     border = 'both',
--     indent_at_cursor = false,
--   }
-- })

-- Custom configuration for mini.indentscope
local M = {}

function M.setup()
  -- Default configuration for all file types
  require('mini.indentscope').setup({
    try_as_border = true,
    border = 'both',
    indent_at_cursor = false,
  })

  -- Create autocmd group for YAML-specific settings
  local augroup = vim.api.nvim_create_augroup('MiniIndentscopeConfig', { clear = true })

  -- Configure special settings for YAML files
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'yaml',
    group = augroup,
    callback = function()

      -- Since we can't modify internal config directly
      require('mini.indentscope').setup({
        symbol = '│',
        options = {
          try_as_border = true,
          border = 'top',  -- YAML-specific setting
          indent_at_cursor = false,
        }
      })
    end
  })
end

return M

