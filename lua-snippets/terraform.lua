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

local awsAmi = s('ami', fmt([[
data "aws_ami" "{}" {{
  owners = [
    {}
  ]
  most_recent = {}

  filter {{
    name = "{}"
    values = [
      "{}"
    ]
  }}
}}
]], {
    i(1, ''),
    i(2, ''),
    c(3, {
      i(1, "true"),
      i(2, "false")
    }),
    i(4, ''),
    i(5, '')
  }))
table.insert(snippets, awsAmi)

local awsSsm = s('ssm', fmt([[
data "aws_ssm_parameter" "{}" {{
  description = "{}"
  name = "{}"
  type = "{}"
  value = "{}"
  overwrite = {}

  {}
}}
]], {
    i(1, ''),
    i(2, ''),
    i(3, ''),
    c(4, {
      i(1, 'SecureString'),
      i(2, 'StringList'),
      i(3, 'String')
    }),
    i(5, ''),
    c(6, {
      i(1, 'true'),
      i(2, 'false')
    }),
    i(7, '')
  }))
table.insert(snippets, awsSsm)

local dataSsm = s('dssm', fmt([[
data "aws_ssm_parameter" "{}" {{
  name = "{}"
}}
]], {
    i(1, ''),
    i(2, '')
  }))
table.insert(snippets, dataSsm)

local templateFile = s('tmpl', fmt([[
data "template_file" "{}" {{
  template = "${{file("{}")}}"

  vars = {{
    {}
  }}
}}
]], {
    i(1, ''),
    c(2, {
      i(1, ''),
      i(2, '${path.module}/')
    }),
    i(3, '')
  }))
table.insert(snippets, templateFile)

local dependsON = s('dep', fmt([[
depends_on = [
  {}
]
]], {
    i(1, '')
  }))
table.insert(snippets, dependsON)

local dynamicContent = s('dc', fmt([[
dynamic "{}" {{
  for_each = {}

  content {{
    {}
  }}
}}
]], {
    i(1, ''),
    i(2, ''),
    i(3, ''),
  }))
table.insert(snippets, dynamicContent)

local listComp = s('lstc', fmt([[
{} = [for x in {} : x.{} if x.{} == {}]
]], {
    i(1, ''),
    i(2, ''),
    i(3, ''),
    i(4, ''),
    i(5, ''),
  }))
table.insert(snippets, listComp)

local tLocal = s('lo', fmt([[
local {{
  {}
}}
]], {
    i(1, '')
  }))
table.insert(snippets, tLocal)

local tModule = s('mod', fmt([[
module "{}" {{
  source = "{}"
  {}
}}
]], {
    i(1, ''),
    i(2, ''),
    i(3, ''),
  }))
table.insert(snippets, tModule)

local nestAssignment = s("=", c(1, {
  i(1, "var = value"),
  sn(1, {
    i(1, "var"),
    t(" = "),
    i(2, "value")
  })
}))

table.insert(snippets, nestAssignment)

return snippets, autosnippets
