return {
    {
        'sindrets/diffview.nvim',
        event = 'VeryLazy',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            require('diffview').setup()
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        event = 'User BufReadRealFile',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            require('plugins.settings.git')
        end
    }
}
