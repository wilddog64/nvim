-- MASON
require('mason').setup({
    ui = {
        icons = {
            package_installed = ' ',
            package_pending = ' ',
            package_uninstalled = ' ',
        },
        border = 'rounded',
    },
})

require("mason-lspconfig").setup {
    -- ensure_installed = { "lua_language_server" },
}

-- MASON LSPCONFIG
require('mason-lspconfig').setup({
    ensure_installed = {
        'azure_pipelines_ls',
        'bashls',
        'dockerls',
        'html',
        'jdtls',
        'jsonls',
        'lua_ls',
        'marksman',
        'pyright',
        'terraformls',
        'texlab',
        'tsserver',
        'yamlls',
    },
})
