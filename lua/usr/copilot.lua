require("copilot").setup {
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<leader>e",
      -- accept_word = "<tab>",
      accept_line = false,
      next = "<c-n>",
      prev = "<c-p>",
      dismiss = "<C-]>",
    },
  },
}
