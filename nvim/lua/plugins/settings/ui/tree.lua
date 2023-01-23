require('nvim-tree').setup({
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
    git = {
        enable = true,
        ignore = true
    },
    filters = {
        dotfiles = false,
        custom = { '^.git$' }
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


-- the code below hides the cursor in NvimTree
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter' }, {
    pattern = 'NvimTree*',
    callback = function()
        local def = vim.api.nvim_get_hl_by_name('Cursor', true)
        vim.api.nvim_set_hl(0, 'Cursor', vim.tbl_extend('force', def, { blend = 100 }))
        vim.opt.guicursor:append('a:Cursor/lCursor')
    end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'WinClosed' }, {
    pattern = 'NvimTree*',
    callback = function()
        local def = vim.api.nvim_get_hl_by_name('Cursor', true)
        vim.api.nvim_set_hl(0, 'Cursor', vim.tbl_extend('force', def, { blend = 0 }))
        vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'
    end,
})
