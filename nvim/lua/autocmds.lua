vim.api.nvim_create_autocmd({ 'CursorHold' }, {
    pattern = '*',
    callback = function()
        vim.diagnostic.open_float(nil, {
            focusable = false
        })
    end
})

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNew', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('CustomBufRead', {
        clear = true
    }),
    callback = function()
        vim.cmd([[do User BufReadRealFile]])
    end
})

-- the code below hides the cursor in NvimTree
local change_cursor = function(value)
    local def = vim.api.nvim_get_hl_by_name('Cursor', true)
    vim.api.nvim_set_hl(0, 'Cursor', vim.tbl_extend('force', def, {
        blend = value
    }))
end

-- hide
vim.api.nvim_create_autocmd({ 'CursorHold', 'WinEnter', 'BufWinEnter' }, {
    pattern = 'NvimTree*',
    callback = function()
        change_cursor(100)
        vim.opt.guicursor:append('a:Cursor/lCursor')
    end
})

-- show
vim.api.nvim_create_autocmd({ 'BufLeave', 'WinClosed' }, {
    pattern = 'NvimTree*',
    callback = function()
        change_cursor(0)
        vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'
    end
})
