require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
        'rust_analyzer',
        'pyright',
        'marksman',
        'yamlls',
        'dockerls',
        'bashls',
        'graphql',
        'sqlls',
        'vimls'
    },
})

-- format code on save if the client supports it
local function on_attach(client, bufnr)
    if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end
end

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
lspconfig['lua_ls'].setup(default_lsp_config)
lspconfig['vimls'].setup(default_lsp_config)


local mappings = {
    l = {
        name = 'Lsp',
        r = { ':LspRestart<CR>', 'restart lsp' }
    }
}

require('which-key').register(mappings, { prefix = 'l', mode = { 'n', 'x' } })
