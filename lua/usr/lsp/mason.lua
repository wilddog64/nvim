local lsp_zero = require('lsp-zero')
lsp_zero.setup({})

require("mason").setup {
  ui = {
    icons = {
      package_installed = "✓"
    }
  }
}

-- MASON LSPCONFIG
require('mason-lspconfig').setup({
    ensure_installed = {
        'azure_pipelines_ls',
        'bashls',
        'dockerls',
        'helm_ls',
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

