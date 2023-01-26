return {
    'numToStr/Comment.nvim',
    event = 'User BufReadRealFile',
    config = function()
        require('plugins.settings.comment')
    end
}
