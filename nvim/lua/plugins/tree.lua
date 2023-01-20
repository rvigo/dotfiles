require('nvim-tree').setup({
    view = {
        adaptive_size = true,
        hide_root_folder = true,
        mappings = {
            list = {{
                key = '<C-o>',
                action = 'vsplit'
            }, {
                key = '<ESC>',
                action = 'close'
            }, {
                key = '..',
                action = 'dir_up'
            }, {
                key = 'cd',
                action = 'cd'
            }, {
                key = 'w',
                action = 'expand_all'
            }, {
                key = 'e',
                action = 'collapse_all'
            }, {
                key = '<C-k>',
                action = ''
            }, {
                key = '<C-t>',
                action = '' -- unset default
            }}
        }
    },
    git = {
        enable = true,
        ignore = true
    },
    filters = {
        dotfiles = false,
        custom = {'^.git$'}
    },
    renderer = {
        group_empty = true
    },
    actions = {
        open_file = {
            resize_window = true
        }
    }
})
-- vim.cmd([[
--     function s:openFileManager()
--         if !argc()
--             NvimTreeFocus
--         endif
--     endfunction

--     autocmd VimEnter * call s:openFileManager()
-- ]])
