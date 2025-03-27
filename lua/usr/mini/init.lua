-- require('mini.base16').setup({
--     palette = {
--       base00 = '#112641',
--       base01 = '#3a475e',
--       base02 = '#606b81',
--       base03 = '#8691a7',
--       base04 = '#d5dc81',
--       base05 = '#e2e98f',
--       base06 = '#eff69c',
--       base07 = '#fcffaa',
--       base08 = '#ffcfa0',
--       base09 = '#cc7e46',
--       base0A = '#46a436',
--       base0B = '#9ff895',
--       base0C = '#ca6ecf',
--       base0D = '#42f7ff',
--       base0E = '#ffc4ff',
--       base0F = '#00a5c5',
--     },
--     use_cterm = true,
-- })

require('mini.bufremove').setup({
  set_vim_settings = true
})

require('mini.comment').setup({
  comment = 'gc',
  comment_line = 'gcc',
  textobject = 'gc',
})

require('mini.cursorword').setup {}
require('mini.indentscope').setup {}
require('mini.diff').setup({})
require('mini.ai').setup({})
require('mini.trailspace').setup({})
require('mini.surround').setup({
  mappings = {
    add = 'ys',
    delete = 'ds',
    find = 'sf',
    find_left = 'sF',
    update_n_lines = 'gn',
  }
})
-- require('mini.misc').setup {}

local keymap = vim.api.nvim_set_keymap

local opts = {
  silent = true
}
keymap('n', '<leader>z', ":lua require('mini.misc').zoom()<CR>", opts)

-- require('usr.mini.git')
require('usr.mini.diff')
require('usr.mini.completion')
