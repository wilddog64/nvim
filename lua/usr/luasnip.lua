local ls = require("luasnip")

vim.fn.system("mkdir -p ~/.config/nvim/lua-snippets")
require('luasnip.loaders.from_lua').load( { paths = "~/.config/nvim/lua-snippets/" } )

ls.config.set_config({
  history = true, -- keep around last snippet local to jump back
  updateevents = "TextChanged,TextChangedI", -- update changes as you type
  enable_autosnippets = true,
  ext_opts = {
    [require('luasnip.util.types').choiceNode] = {
      active = {
        virt_text = { { "●", "GruvboxOrange" } },
      },
    },
  },
})
