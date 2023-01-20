require('mason-lspconfig').setup()

local default_lsp_config = {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150
    }
}

local lspconfig = require('lspconfig')
lspconfig['pyright'].setup(default_lsp_config)
lspconfig['dockerls'].setup(default_lsp_config)
lspconfig['marksman'].setup(default_lsp_config)
lspconfig['bashls'].setup(default_lsp_config)
lspconfig['yamlls'].setup(default_lsp_config)
lspconfig['sqlls'].setup(default_lsp_config)
lspconfig['terraformls'].setup(default_lsp_config)
lspconfig['graphql'].setup(default_lsp_config)
lspconfig['sumneko_lua'].setup(default_lsp_config)
lspconfig['vimls'].setup(default_lsp_config)
