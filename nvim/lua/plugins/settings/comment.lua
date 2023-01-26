vim.g.NERDCreateDefaultMappings = 0

-- mapping keys to which-key
local mappings = {
    c = {
        name = 'comment',
        t = { ':lua require("Comment.api").toggle.linewise.current()<CR>', 'toggle comment' },
        u = { ':lua require("Comment.api").uncomment.linewise.current()<CR>', 'uncomment' },
        c = { ':lua require("Comment.api").comment.linewise.current()<CR>', 'comment' }
    },
}

require('which-key').register(mappings, { prefix = '<leader>c', mode = { 'n', 'x' } })
