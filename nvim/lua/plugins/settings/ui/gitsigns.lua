require('gitsigns').setup({
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text_pos = 'right_align'
    },
    signs = {
        add = {
            hl = 'GitSignsAdd',
            text = '▎',
            numhl = 'GitSignsAddNr',
            linehl = 'GitSignsAddLn'
        },
        change = {
            hl = 'GitSignsChange',
            text = '▎',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn'
        }
    }
})
