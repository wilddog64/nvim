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

 require("luasnip/loaders/from_vscode").lazy_load()
 require("luasnip.loaders.from_snipmate").lazy_load()

-- key maps
vim.keymap.set({
  "i", "s"
}, "<a-p>", function()
  if ls.expand_or_jumpable() then
      ls.expand()
  end
end
)

vim.keymap.set({ "i", "s" }, "<c-n>", function()
  if ls.jumpable(1) then
    ls.jump(1)
  end
end)

vim.keymap.set({ "i", "s" }, "<c-p>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end)

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end)
