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
-- require('mini.misc').setup {}

local keymap = vim.api.nvim_set_keymap

local opts = {
  silent = true
}
keymap('n', '<leader>z', ":lua require('mini.misc').zoom()<CR>", opts)

require('mini.git').setup({
  signs = true,
  blame = true,
  diff = true,
  diff_inline = true,
  diff_opts = {
    internal = true,
    external = true,
  },
  diff_keymap = {
    next = '<leader>gn',
    prev = '<leader>gp',
    toggle = '<leader>gd',
  },
  blame_keymap = {
    next = '<leader>bn',
    prev = '<leader>bp',
    toggle = '<leader>bd',
  },
  signs_keymap = {
    next = '<leader>sn',
    prev = '<leader>sp',
    toggle = '<leader>sd',
  },
  command = {
    split = 'auto',
  },
})

require('mini.diff').setup({
  -- Options for how hunks are visualized
  view = {
    -- Visualization style. Possible values are 'sign' and 'number'.
    -- Default: 'number' if line numbers are enabled, 'sign' otherwise.
    style = vim.go.number and 'number' or 'sign',

    -- Signs used for hunks with 'sign' view
    signs = { add = '+', change = '~', delete = '-' },

    -- Priority of used visualization extmarks
    priority = 199,
  },

  -- Source for how reference text is computed/updated/etc
  -- Uses content from Git index by default
  source = nil,

  -- Delays (in ms) defining asynchronous processes
  delay = {
    -- How much to wait before update following every text change
    text_change = 200,
  },

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Apply hunks inside a visual/operator region
    apply = 'gh',

    -- Reset hunks inside a visual/operator region
    reset = 'gH',

    -- Hunk range textobject to be used inside operator
    -- Works also in Visual mode if mapping differs from apply and reset
    textobject = 'gh',

    -- Go to hunk range in corresponding direction
    goto_first = '[H',
    goto_prev = '[h',
    goto_next = ']h',
    goto_last = ']H',
  },

  -- Various options
  options = {
    -- Diff algorithm. See `:h vim.diff()`.
    algorithm = 'histogram',

    -- Whether to use "indent heuristic". See `:h vim.diff()`.
    indent_heuristic = true,

    -- The amount of second-stage diff to align lines (in Neovim>=0.9)
    linematch = 60,

    -- Whether to wrap around edges during hunk navigation
    wrap_goto = false,
  },
})
