return {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    config = function()
        require('plugins.settings.toggleterm')
    end
}
