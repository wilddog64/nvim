require("mason").setup {
  ui = {
    icons = {
      package_installed = "✓"
    }
  }
}
require("mason-lspconfig").setup {
    -- ensure_installed = { "lua-language-server" },
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
        'pylsp',
        'terraformls',
        'yamlls',
    },
})

