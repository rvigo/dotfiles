require('mason-lspconfig').setup()

local default_lsp_config = {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150
    }
}

require('lspconfig')['pyright'].setup(default_lsp_config)
require('lspconfig')['dockerls'].setup(default_lsp_config)
require('lspconfig')['marksman'].setup(default_lsp_config)
