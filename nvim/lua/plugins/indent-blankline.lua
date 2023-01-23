return {
    'lukas-reineke/indent-blankline.nvim',
    event = 'User BufReadRealFile',
    config = function()
        require('plugins.settings.indent-blankline')
    end
}
