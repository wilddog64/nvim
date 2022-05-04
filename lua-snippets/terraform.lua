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

local requiredProviders = s('rq', fmt([[
required_providers {{
  {}
}}
]], {
    i(1, '')
  }))
table.insert(snippets, requiredProviders)

local bProvider = s('bp', fmt([[
{} = {{
  source = "{}",
  version = "{}"
}}
]], {
    i(1, ''),
    i(2, ''),
    i(3, '')
  }))
table.insert(snippets, bProvider)

local iProvider = s('p', fmt([[
provider "{}" {{
  {}
}}
]], {
    i(1, ''),
    i(2, ''),
  }))
table.insert(snippets, iProvider)

local tResource = s('res', fmt([[
resource "{}" "{}" {{
  {}
}}
]], {
    i(1, ''),
    i(2, ''),
    i(3, '')
  }))
table.insert(snippets, tResource)

local terraformRemoteState = s('trs', fmt([[
data "terraform_remote_state" "{}" {{
  backend = "{}"

  config = {{
    organization = "{}"
    workspaces = {{
      name = "{}"
    }}
  }}
}}
]], {
    i(1, ''),
    c(2, {
      i(1, "remote"),
      i(2, "local"),
    }),
    i(3, ''),
    i(4, '')
  }))
table.insert(snippets, terraformRemoteState)

return snippets, autosnippets
