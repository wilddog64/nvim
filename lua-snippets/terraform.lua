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

-- use double braces to escape {}
local snippets, autosnippets = {}, {}
local group = vim.api.nvim_create_augroup('Lua Snippets', { clear = true })
local file_pattern = "*.lua"

local tfw = s('tfw', fmt([[
terraform {{
  organization = "{}"

  backend = "{}" {{
    workspaces {{
      name = "{}"
    }}
    hostname = "{}"
  }}

}}
]], {
    i(1, ''),
    i(2, ''),
    i(3, ''),
    i(4, ''),
  }))

table.insert(snippets, tfw)
return snippets, autosnippets
