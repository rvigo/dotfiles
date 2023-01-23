return {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    event = 'User BufReadRealFile',
    config = function()
        require('plugins.settings.coq')
    end
}
