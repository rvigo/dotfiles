require('bufferline').setup({
    options = {
        numbers = 'ordinal',
        close_command = 'bp|sp|bn|bd! %d',
        indicator = {
            style = 'underline'
        },
        left_trunc_marker = '',
        modified_icon = '●',
        offsets = {
                {
                filetype = 'NvimTree',
                text = 'File Explorer',
                text_align = 'center',
                separator = true
            }, {
                filetype = 'Outline',
                text = 'Symbols',
                text_align = 'center',
                separator = true
            }
        },
        view = 'multiwindow',
        right_trunc_marker = '',
        always_show_bufferline = false,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        enforce_regular_tabs = true,
        sort_by = 'id',
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, _, _, _)
            return '(' .. count .. ')'
        end
    },
    highlights = require('catppuccin.groups.integrations.bufferline').get()
})
