local ctp_feline = require('catppuccin.groups.integrations.feline')

local feline = require('feline')
feline.setup({
    components = ctp_feline.get(),
    force_inactive = {
        filetypes = {
            '^NvimTree$',
            '^vim-plug$',
            '^alpha$'
        },
        buftypes = { '^terminal$' },
        bufnames = {}
    }
})
