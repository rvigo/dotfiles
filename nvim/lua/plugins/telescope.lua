return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-project.nvim'
    },
    cmd = 'Telescope',
    event = 'User BufReadRealFile',
    config = function()
        require('plugins.settings.telescope')
    end
}
