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


if vim.fn.executable('lazygit') == 1 then
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new { cmd = 'lazygit', hidden = true }

    function _OPEN_LAZYGIT()
        lazygit:toggle()
    end

    local lazygit_mapping = { ':lua _OPEN_LAZYGIT()<CR>', 'open lazygit' }
    require('which-key').register(lazygit_mapping, { prefix = '<leader>gt', mode = { 'n', 'x', 't' } })
else
    vim.notify('"lazygit" not found', 'debug')
end

-- mapping keys to which-key
local mappings = {
    name = 'git',
    d = { ':DiffviewOpen<CR>', 'show diff' },
    q = { ':DiffviewClose<CR>', 'close diff' },
    b = { ':Gitsigns toggle_current_line_blame<CR>', 'toggle blame line' },
}

require('which-key').register(mappings, { prefix = '<leader>g', mode = { 'n', 'v' } })
