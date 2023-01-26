require('nvim-tree').setup({
    auto_reload_on_write = true,
    disable_netrw = true,
    hijack_cursor = true,
    update_cwd = true,
    view = {
        adaptive_size = true,
        hide_root_folder = true,
        mappings = {
            list = { {
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
            } }
        }
    },
    filesystem_watchers = {
        enable = true
    },
    git = {
        enable = true,
        ignore = true
    },
    filters = {
        dotfiles = false,
        custom = { '^.git$' }
    },
    renderer = {
        highlight_git = true,
        indent_markers = {
            enable = true
        },
        group_empty = true
    },
    actions = {
        open_file = {
            resize_window = true
        }
    }
})

-- mapping keys to which-key
local mappings = {
    f = {
        name = 'file explorer',
        t = { ':NvimTreeToggle<CR>', 'toggle NvimTree' },
        f = { ':NvimTreeFocus<CR>', 'focus NvimTree' }
    }
}

require('which-key').register(mappings, { mode = { 'n', 'x' }, prefix = '<leader>' })
