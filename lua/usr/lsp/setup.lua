-- (removed) local lspconfig = require('lspconfig')
-- (removed) local lsp_defaults = lspconfig.util.default_config

-- TOGGLE INLAY HINTS (left as-is)
if vim.lsp.inlay_hint then
    vim.keymap.set('n', '<leader>ih', function()
        vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
    end, { desc = 'Toggle Inlay Hints' })
end

local border = {
    { '┌', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '┐', 'FloatBorder' },
    { '│', 'FloatBorder' },
    { '┘', 'FloatBorder' },
    { '─', 'FloatBorder' },
    { '└', 'FloatBorder' },
    { '│', 'FloatBorder' },
}

-- LSP SETTINGS (FOR OVERRIDING PER CLIENT)
local handlers = {
    ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

-- DIAGNOSTICS SIGNS (unchanged)
local signs = { Error = ' ', Warn = ' ', Hint = '󰌶 ', Info = ' ' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_text = {
        prefix = '',
    },
    float = { border = border },
})

---
-- LSP Servers
---

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
  on_init = function(client)
    print("lua-language-server initialized!")
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    bufmap('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    bufmap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', 'ga', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})

vim.lsp.config('pylsp', {
  handlers = handlers,
  settings = {
    pyls = {
      configurationSources = {"flake8"},
      plugins = {
        jedi_completion = {enabled = true},
        jedi_hover = {enabled = true},
        jedi_references = {enabled = true},
        jedi_signature_help = {enabled = true},
        jedi_symbols = {enabled = true, all_scopes = true},
        pycodestyle = {enabled = false},
        flake8 = { enabled = true, ignore = {}, maxLineLength = 160 },
        mypy = {enabled = false},
        isort = {enabled = false},
        yapf = {enabled = false},
        pylint = {enabled = false},
        pydocstyle = {enabled = false},
        mccabe = {enabled = false},
        preload = {enabled = false},
        rope_completion = {enabled = false}
      }
    }
  },
})

vim.lsp.config('terraformls', {})
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = function()
    vim.lsp.buf.format()
  end,
})

vim.lsp.config('bashls', { handlers = handlers })
vim.lsp.config('marksman', { handlers = handlers })
vim.lsp.config('dockerls', { handlers = handlers })
vim.lsp.config('jsonls', { handlers = handlers })

local function get_root_dir(fname)
  local startpath = fname and vim.fs.dirname(fname) or vim.fn.getcwd()
  local git_dir = vim.fs.find('.git', { path = startpath, upward = true })[1]
  return git_dir and vim.fs.dirname(git_dir) or vim.fn.getcwd()
end

vim.lsp.config('azure_pipelines_ls', {
  root_dir = get_root_dir,
  handlers = handlers,
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
          "/azure-pipeline*.y*l",
          "/*.azure*",
          "Azure-Pipelines/**/*.y*l",
          "pipelines/*.y*l",
        },
      },
    },
  },
})

local yaml_config = {
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/helmfile.json"] = "helmfile.yaml",
        ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
        ["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
        ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argo-rollouts.io/rollouts_v1alpha1.json"] = { "**/*rollout*.ya?ml", "**/*rollouts*.ya?ml" },
      },
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      validate = true,
      customTags = {
        "!include scalar",
        "!loop sequence",
        "!merge mapping",
        "tag:yaml.org,2002:str",
        "!env scalar",
        "!tpl scalar",
      },
      hover = true,
      completion = true,
      format = { enable = true },
    },
  },
  handlers = {
    ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
      if result and result.diagnostics then
        local filtered = {}
        for _, d in ipairs(result.diagnostics) do
          if not (d.message and d.message:match("{{.*}}")) then
            table.insert(filtered, d)
          end
        end
        result.diagnostics = filtered
      end
      vim.lsp.handlers["textDocument/publishDiagnostics"](_, result, ctx, config)
    end,
  }
}

-- Detect Helm templates / ansible (unchanged)
vim.filetype.add({
  pattern = {
    [".*/templates/.*%.ya?ml"] = "helm",
    [".*/Chart%.yaml"] = "helm",
  },
})
vim.lsp.config('helm_ls', {
  filetypes = { "helm" },
  settings = { ["helm-ls"] = { yamlls = { enabled = true } } },
})

vim.filetype.add({
  pattern = {
    [".*/(playbooks|group_vars|host_vars)/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/(tasks|handlers|vars|defaults)/.*%.ya?ml"] = "yaml.ansible",
    [".*/inventory/.*%.ya?ml"] = "yaml.ansible",
  },
})

-- (kept both yamlls/helm/ansible blocks you had; just converted)
vim.lsp.config('helm_ls', {
  filetypes = { "helm" },
  settings = { ["helm-ls"] = { yamlls = { enabled = false } } },
})

vim.lsp.config('yamlls', {
  filetypes = { "yaml", "yml", "yaml.docker-compose" },
  settings = {
    yaml = {
      validate = true,
      schemaStore = { enable = true },
      schemas = {
        kubernetes = { "manifests/**/*.yaml", "k8s/**/*.yaml" },
        ["https://raw.githubusercontent.com/istio/api/master/networking/v1beta1/gateway.json"]       = "**/gateway*.ya?ml",
        ["https://raw.githubusercontent.com/istio/api/master/networking/v1beta1/virtualservice.json"] = "**/virtualservice*.ya?ml",
      },
    },
  },
})

vim.lsp.config('ansiblels', {
  filetypes = { "yaml.ansible" },
  settings = {
    ansible = {
      python = { interpreterPath = "python" },
      ansible = { path = "ansible" },
      ansibleLint = { enabled = true, path = "ansible-lint" },
      executionEnvironment = { enabled = false },
    },
  },
})

vim.lsp.config('yamlls', {
  filetypes = { "yaml", "yml", "yaml.docker-compose" },
  settings = {
    yaml = {
      validate = true,
      schemaStore = { enable = true },
      schemas = {
        kubernetes = { "manifests/**/*.yaml", "k8s/**/*.yaml" },
        ["https://raw.githubusercontent.com/istio/api/master/networking/v1beta1/gateway.json"]       = "**/gateway*.ya?ml",
        ["https://raw.githubusercontent.com/istio/api/master/networking/v1beta1/virtualservice.json"] = "**/virtualservice*.ya?ml",
      },
    },
  },
})

local rollouts_schema =
  "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argo-rollouts.io/rollouts_v1alpha1.json"

local function map_rollout_schema_for_this_file(client, bufnr)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  if not fname:match("%.ya?ml$") then return end
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, math.min(200, vim.api.nvim_buf_line_count(bufnr)), false)
  local text = table.concat(lines, "\n")

  if text:match("apiVersion:%s*argoproj%.io/v1alpha1") and text:match("kind:%s*Rollout") then
    local cfg = vim.deepcopy(client.config.settings or {})
    cfg.yaml = cfg.yaml or {}
    cfg.yaml.schemas = cfg.yaml.schemas or {}

    local cur = cfg.yaml.schemas[rollouts_schema]
    if type(cur) == "string" then
      cfg.yaml.schemas[rollouts_schema] = { cur, fname }
    elseif type(cur) == "table" then
      table.insert(cur, fname)
    else
      cfg.yaml.schemas[rollouts_schema] = { fname }
    end

    client.config.settings = cfg
    client.notify("workspace/didChangeConfiguration", { settings = cfg })
  end
end

yaml_config.on_attach = function(client, bufnr)
  if client.name == "yamlls" then
    map_rollout_schema_for_this_file(client, bufnr)
  end
end

vim.lsp.config('yamlls', yaml_config)

-- enable servers (added to replace .setup())
vim.lsp.enable('lua_ls')
vim.lsp.enable('pylsp')
vim.lsp.enable('terraformls')
vim.lsp.enable('bashls')
vim.lsp.enable('marksman')
vim.lsp.enable('dockerls')
vim.lsp.enable('jsonls')
vim.lsp.enable('azure_pipelines_ls')
vim.lsp.enable('helm_ls')
vim.lsp.enable('yamlls')
vim.lsp.enable('ansiblels')
