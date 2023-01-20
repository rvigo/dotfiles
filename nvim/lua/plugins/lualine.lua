require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'vscode'
    },
    sections = {
        lualine_c = {{
            'filename',
            path = 3
        }}
    }
})
