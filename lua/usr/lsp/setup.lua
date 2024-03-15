-- LSPCONFIG
local lspconfig = require('lspconfig')

-- CMP LSP CAPABILITIES
local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend('force', lsp_defaults.capabilities, require('cmp_nvim_lsp').default_capabilities())

require('lspconfig.ui.windows').default_options.border = 'rounded'

---
-- LSP Servers
---

lspconfig.lua_ls.setup({
  single_file_support = true,
  flags = {
    debounce_text_changes = 150,
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references 
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', 'ga', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})

-- TOGGLE INLAY HINTS
if vim.lsp.inlay_hint then
    vim.keymap.set('n', '<leader>ih', function()
        vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
    end, { desc = 'Toggle Inlay Hints' })
end

-- BORDERS FOR DIAGNOSTICS
-- vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#181926]])
-- vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#181926]])

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

-- DISABLE LSP (NOT CMP) INLINE DIAGNOSTICS ERROR MESSAGES
-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = false,
-- })

-- DIAGNOSTICS SIGNS
local signs = { Error = ' ', Warn = ' ', Hint = '󰌶 ', Info = ' ' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_text = {
        prefix = '', -- Could be '●', '▎', │, 'x', '■', , 
    },
    float = { border = border },
    -- virtual_text = false,
    -- signs = true,
    -- underline = true,
})

lspconfig.lua_ls.setup({
    -- For nvim-navic
    -- on_attach = function(client, bufnr)
    --     navic.attach(client, bufnr)
    -- end,
    handlers = handlers,
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME,
                            -- "${3rd}/luv/library"
                            -- "${3rd}/busted/library",
                        },
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    },
                    telemetry = {
                        enable = false,
                    },
                    hint = {
                        enable = true,
                    },
                },
            })

            client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
        end
        return true
    end,
 })

 -- JAVASCRIPT SERVER
lspconfig.tsserver.setup({
    handlers = handlers,
    init_options = {
        preferences = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            importModuleSpecifierPreference = 'non-relative',
        },
    },
    -- on_attach = function(client, bufnr)
    --     client.server_capabilities.document_formatting = false
    --     client.server_capabilities.document_range_formatting = false
    --     on_attach(client, bufnr)
    -- end,
})

-- PYTHON SERVER
lspconfig.pyright.setup({
    handlers = handlers,
})

-- EMMET SERVER
lspconfig.emmet_ls.setup({
    handlers = handlers,
})

-- CSS SERVER
lspconfig.cssls.setup({
    handlers = handlers,
    settings = {
        css = {
            lint = {
                unknownAtRules = 'ignore',
            },
        },
    },
})

-- TAILWIND SERVER
-- lspconfig.tailwindcss.setup({
--     handlers = handlers,
-- })

-- VOLAR VUE SERVER
lspconfig.volar.setup({
    handlers = handlers,
    filetypes = {
        'vue', --[[ 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'json' ]]
    },
    init_options = {
        typescript = {
            tsdk = '/Users/ilias/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib',
        },
        preferences = {
            disableSuggestions = true,
        },
        languageFeatures = {
            implementation = true,
            references = true,
            definition = true,
            typeDefinition = true,
            callHierarchy = true,
            hover = true,
            rename = true,
            renameFileRefactoring = true,
            signatureHelp = true,
            codeAction = true,
            workspaceSymbol = true,
            diagnostics = true,
            semanticTokens = true,
            completion = {
                defaultTagNameCase = 'both',
                defaultAttrNameCase = 'kebabCase',
                getDocumentNameCasesRequest = false,
                getDocumentSelectionRequest = false,
            },
        },
    },
})

-- JSON SERVER
lspconfig.jsonls.setup({
    handlers = handlers,
    filetypes = { 'json', 'jsonc' },
    init_options = {
        provideFormatter = true,
    },
})

-- HTML SERVER
lspconfig.html.setup({
    handlers = handlers,
    settigns = {
        css = {
            lint = {
                validProperties = {},
            },
        },
    },
})

-- LTEX SERVER
lspconfig.ltex.setup({
    handlers = handlers,
    settings = {
        ltex = {
            language = 'de-DE',
            enabled = { 'bibtex', 'markdown', 'latex', 'tex' },
        },
    },
})

-- TEXLAB SERVER
lspconfig.texlab.setup({
    handlers = handlers,
    settings = {
        texlab = {
            auxDirectory = '.',
            bibtexFormatter = 'texlab',
            build = {
                args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
                executable = 'latexmk',
                forwardSearchAfter = false,
                onSave = false,
            },
            chktex = {
                onEdit = false,
                onOpenAndSave = false,
            },
            diagnosticsDelay = 300,
            formatterLineLength = 100,
            forwardSearch = {
                args = {},
            },
            latexFormatter = 'latexindent',
            latexindent = {
                modifyLineBreaks = false,
            },
        },
    },
})

-- PHP SERVER
lspconfig.intelephense.setup({
    handlers = handlers,
})

-- JAVA SERVER
-- lspconfig.jdtls.setup({
--     handlers = handlers,
-- })

-- YAML SERVER
lspconfig.yamlls.setup({
    handlers = handlers,
    settings = {
        yaml = {
            validate = true,
            hover = true,
            completion = true,
            format = {
                enable = true,
                singleQuote = true,
                bracketSpacing = true,
            },
            editor = {
                tabSize = 2,
            },
            schemaStore = {
                enable = true,
            },
        },
        editor = {
            tabSize = 2,
        },
    },
})

-- RUST
lspconfig.rust_analyzer.setup({
    handlers = handlers,
})

lspconfig.terraformls.setup({})
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = function()
    vim.lsp.buf.format()
  end,
})
