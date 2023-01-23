return {
    {
        'williamboman/mason.nvim',
        event = 'User BufReadRealFile',
        dependencies = 'neovim/nvim-lspconfig',
        config = function()
            require('plugins.settings.lsp.mason')
        end
    }, {
        'williamboman/mason-lspconfig.nvim',
        event = 'VeryLazy',
        dependencies = 'williamboman/mason.nvim',
        config = function()
            require('plugins.settings.lsp.mason-lspconfig')
        end
    }, {
        'simrat39/rust-tools.nvim',
        ft = 'rust',
        config = function()
            require('plugins.settings.lsp.rust-tools')
        end
    }
}
