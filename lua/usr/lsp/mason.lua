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
        'cssls',
        'emmet_ls',
        'html',
        'intelephense',
        'jdtls',
        'jsonls',
        'ltex',
        'lua_ls',
        'pyright',
        'rust_analyzer',
        'terraformls',
        'texlab',
        'tsserver',
        'volar',
        'yamlls',
    },
})
