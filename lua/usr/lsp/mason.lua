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
        'bashls',
        'html',
        'jdtls',
        'jsonls',
        'lua_ls',
        'pyright',
        'terraformls',
        'texlab',
        'tsserver',
        'yamlls',
    },
})
