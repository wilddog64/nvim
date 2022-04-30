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

-- key maps
vim.keymap.set({
  "i", "s"
}, "<cr>", function()
  if ls.expand_or_jumpable() then
      ls.expand()
  end
end
)

vim.keymap.set({
  "i", "s"
}, "<tab>", function()
  if ls.jummpable(1) then
    ls.jump(1)
  end
end)

vim.keymap.set({ "i", "s" }, "<s-tab>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end)

vim.keymap.set({ "i", "s" }, "<a-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set({ "i", "s" }, "<a-h", function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end)
