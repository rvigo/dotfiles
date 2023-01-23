local nvim_notify = require('notify')
nvim_notify.setup {
    background_colour = '#000000',
    --stages = 'fade_in_slide_out',
    stages = 'static',
    timeout = 3000,
    on_open = function(win)
        vim.api.nvim_win_set_option(win, 'wrap', true)
    end,
    on_close = nil,
    minimum_width = 50,
    maximum_width = 70,
    render = 'compact',
}
vim.notify = nvim_notify

vim.notify(
    'nvim-notify setup successful!', 'debug', {}
)
