local ls = require('luasnip')
local s = ls.s -- snippet
local i = ls.i -- insert node
local t = ls.t -- text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

local snippets, autosnippets = {}, {}

local group = vim.api.nvim_create_augroup('Lua Snippets', { clear = true })
local file_pattern = "*.lua"

local mySnippet = s("mySnippet", {
  t('Hi!, this is my first snippet in LuaSnip'),
  i(1, ' placeholder_text'),
  t({ "", 'that is another text' }),
})
table.insert(snippets, mySnippet)

local myOtherSnippet = s('myOtherSnippet', fmt([[
  local {} = function({})
    {} {{ I am in a curly braces }}
  end
]], {
    i(1, 'myVar'),
    c(2, { t"", i(1, "myArg" )}),
    i(3, '-- TODO: something'),
  }))
table.insert(snippets, myOtherSnippet)

local myAutoTrigger = s(
  { trig = "digit(%d)(%d)", regTrig = true },
  { i(1, "upper case me") },
  f(function(arg, snip)
    return arg[1][1]:upper() .. arg[2][1]:lower()
  end, {1, 2}),
  i(2, " LOWERCASE ME")
)
table.insert(autosnippets, myAutoTrigger)

local luaTemplate = s("luh", fmt([[
local ls = require('luasnip')
local s = ls.s -- snippet
local i = ls.i -- insert node
local t = ls.t -- text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

-- use double braces to escape {{}}
local snippets, autosnippets = {{}}, {{}}
local group = vim.api.nvim_create_augroup('Lua Snippets', {{ clear = true }})
local file_pattern = "*.lua"

{}

table.insert(snippets, {})
return snippets, autosnippets
]], {
  i(1, ""),
  i(2, ""),
  }))
table.insert(snippets, luaTemplate)


return snippets, autosnippets

