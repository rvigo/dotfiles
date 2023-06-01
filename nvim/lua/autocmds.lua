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

if (not vim.g.vscode)
then
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

    -- got to last buffer when deleting a buffer
    vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
            -- Only 1 window with nvim-tree left: we probably closed a file buffer
            if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
                local api = require('nvim-tree.api')
                -- Required to let the close event complete. An error is thrown without this.
                vim.defer_fn(function()
                    -- close nvim-tree: will go to the last hidden buffer used before closing
                    api.tree.toggle({ find_file = true, focus = true })
                    -- re-open nivm-tree
                    api.tree.toggle({ find_file = true, focus = true })
                    -- nvim-tree is still the active window. Go to the previous window.
                    vim.cmd("wincmd p")
                end, 0)
            end
        end
    })
end
