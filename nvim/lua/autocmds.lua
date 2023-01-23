vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = '*',
    callback = function()
        vim.lsp.buf.format()
    end
})
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
