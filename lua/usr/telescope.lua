local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  },
}

-- telescope.load_extension('urlview')

vim.cmd([[
  " Using Lua functions
  nnoremap <leader>cf <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
  nnoremap <leader>fa <cmd>lua require('telescope.builtin').autocommands()<cr>
  " "nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
  nnoremap <leader>fb :Buffers<cr>
  nnoremap <leader>fc <cmd>lua require('telescope.builtin').commands()<cr>
  " nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
  nnoremap <leader>ff :Files<cr>
  nnoremap <leader>fg <cmd>:lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>
  nnoremap <leader>fl <cmd>lua require('telescope.builtin').loclist()<cr>
  nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
  nnoremap <leader>fk <cmd>lua require('telescope.builtin').keymaps()<cr>
  " nnoremap <leader>fm <cmd>lua require('telescope.builtin').marks()<cr>
  nnoremap <leader>fm :Marks<cr>
  nnoremap <leader>fr <cmd>lua require('telescope.builtin').registers()<cr>
  nnoremap <leader>fs <cmd>lua require('telescope.builtin').grep_string()<cr>
  nnoremap <leader>ss <cmd>lua require('telescope.builtin').spell_suggest()<cr>
  nnoremap <leader>fj <cmd>lua require('telescope.builtin').jumplist()<cr>
]])
