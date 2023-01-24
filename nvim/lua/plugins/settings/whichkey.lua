vim.opt.timeoutlen = 300
local wk = require('which-key')
local keymaps = {
    f = {
        name = 'file explorer',
        t = { ':NvimTreeToggle<CR>', 'Toggle NvimTree' },
        f = { '::NvimTreeFocus<CR>', 'Focus NvimTree' }
    },
    b = {
        name = 'buffer',
        d = { ':bdelete<CR>', 'BufferDelete' }
    },
    p = {
        name = 'project',
        o = { ':Telescope project<CR>', 'Open project' }
    },
    c = {
        name = 'code',
        a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'code Action' },
        d = { '<cmd>lua vim.lsp.buf.declaration()<CR>', 'declaration' },
        D = { '<cmd>lua vim.lsp.buf.definition()<CR>', 'definition' },
        i = { '<cmd>lua vim.lsp.buf.implementation()<CR>', 'implementation' },
        k = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'signature' },
        K = { '<cmd>lua vim.lsp.buf.hover()<CR>', 'hover' },
        r = { '<cmd>lua vim.lsp.buf.rename()<CR>', 'rename' },
        f = { '<cmd>lua vim.lsp.buf.format { async = true } <CR>', 'formatting' },
        R = { '<cmd>vim.lsp.buf.references()<CR>', 'feferences' },
        c = {
            name = 'comment',
            t = { '<plug>NERDCommenterToggle<CR>', 'toggle Comment' },
            i = { '<plug>NERDCommenterInvert<CR>', 'invert Comment' },
            c = { '<plug>NERDCommenterComment<CR>', 'comment' }
        },
        s = {
            name = 'symbols',
            t = { ':SymbolsOutline<cr>', 'toggle Symbols tree' }
        }
    },
    w = {
        name = 'windows',
        ['='] = { '<C-W>=', 'balance-window' },
        v = { ':vsplit<CR>', 'split-vertical' },
        h = { ':split<CR>', 'split-horizontal' },
        n = { '<C-W>n', 'next-window' },
        d = { '<C-W>c', 'delete-window' }
    },
    t = {
        name = 'trouble',
        t = { ':TroubleToggle<CR>', 'toggle Trouble' },
        r = { ':TroubleRefresh<CR>', 'refresh Trouble' }
    },
    n = {
        name = 'neovim',
        s = { ':source $MYVIMRC<CR>', 're-source nvim configs' }
    },
    T = {
        name = 'telescope',
        f = { ':Telescope find_files<CR>', 'find files' },
        g = { ':Telescope live_grep<CR>', 'grep files' },
        b = { ':Telescope buffers<CR>', 'find buffers' }
    },
    g = {
        name = 'git',
        d = { ':Gitsigns diffthis<CR>', 'show diff' },
        b = { ':Gitsigns toggle_current_line_blame', 'toggle blame line' }
    },
    A = { ':Alpha<CR>', "Open alpha" },
    l = {
        name = 'Lsp',
        r = { ':LspRestart', 'restart lsp' }
    }
}

local opts = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on ' in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20 -- how many suggestions should be shown in the list?
        },
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true -- bindings for prefixed with g
        }
    },
    icons = {
        breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
        separator = '➜', -- symbol used between a key and it's label
        group = '+' -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = '<c-d>', -- binding to scroll down inside the popup
        scroll_up = '<c-u>' -- binding to scroll up inside the popup
    },
    window = {
        border = 'rounded', -- none, single, double, shadow
        position = 'bottom', -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0
    },
    layout = {
        height = {
            min = 4,
            max = 25
        }, -- min and max height of the columns
        width = {
            min = 20,
            max = 50
        }, -- min and max width of the columns
        spacing = 5, -- spacing between columns
        align = 'left' -- align columns left, center or right
    },

    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = 'auto', -- automatically setup triggers
    triggers_blacklist = {
        i = { 'j', 'k' },
        v = { 'j', 'k' }
    }
}
wk.register(keymaps, {
    prefix = '<leader>',
    mode = { 'n', 'x' }
})
wk.setup(opts)
