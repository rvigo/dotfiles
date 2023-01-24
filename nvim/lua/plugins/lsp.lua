return {
    'neovim/nvim-lspconfig',
    event = 'User BufReadRealFile',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'simrat39/rust-tools.nvim',
        'onsails/lspkind-nvim'
    },
    config = function()
        require('plugins.settings.lsp.mason')
        require('plugins.settings.lsp.mason-lspconfig')
        require('plugins.settings.lsp.rust-tools')
    end
}
