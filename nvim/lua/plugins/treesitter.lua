return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'User BufReadRealFile',
    config = function()
        require('plugins.settings.treesitter')
    end
}
