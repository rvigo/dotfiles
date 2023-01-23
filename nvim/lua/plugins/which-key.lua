return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
        require('plugins.settings.whichkey')
    end
}
