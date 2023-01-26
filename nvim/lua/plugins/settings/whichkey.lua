vim.opt.timeoutlen = 300
local wk = require('which-key')
local keymaps = {
    b = {
        name = 'buffer',
        d = { ':bdelete<CR>', 'delete (close) buffer' }
    },
    c = {
        name = 'code',
        a = { ':lua vim.lsp.buf.code_action()<CR>', 'code action' },
        d = { ':lua vim.lsp.buf.declaration()<CR>', 'declaration' },
        D = { ':lua vim.lsp.buf.definition()<CR>', 'definition' },
        i = { ':lua vim.lsp.buf.implementation()<CR>', 'implementation' },
        k = { ':lua vim.lsp.buf.signature_help()<CR>', 'signature' },
        K = { ':lua vim.lsp.buf.hover()<CR>', 'hover' },
        r = { ':lua vim.lsp.buf.rename()<CR>', 'rename' },
        f = { ':lua vim.lsp.buf.format()<CR>', 'formatting' },
        R = { ':lua vim.lsp.buf.references()<CR>', 'references' },
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
    m = {
        name = 'misc',
        s = { ':source $MYVIMRC<CR>', 're-source nvim configs' }
    },
    L = {
        name = 'Lazy',
        s = { ':Lazy<CR>', 'lazy show' },
        S = { ':Lazy sync<CR>', 'lazy sync' },
        i = { ':Lazy install<CR>', 'lazy install' },
        c = { ':Lazy clean<CR>', 'lazy clean' },
        u = { ':Lazy update<CR>', 'lazy update' },
        l = { ':Lazy log<CR>', 'lazy log' },
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

wk.register(keymaps, { prefix = '<leader>', mode = { 'n', 'x' } })
wk.setup(opts)
