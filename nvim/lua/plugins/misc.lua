return {{
    'RRethy/vim-illuminate',
    event = 'VeryLazy',
    config = function()
        require('illuminate').configure({
            filetypes_denylist = {'alpha', 'NvimTree', 'lazy', 'toggleterm', 'Outline'}
        })
    end
}, {
    'sindrets/diffview.nvim',
    event = 'VeryLazy',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
        require('diffview').setup()
    end
}, {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    cmd = {'TodoQuickFix', 'TodoTrouble', 'TodoTelescope'},
    config = function()
        require('todo-comments').setup()
    end
}, {
    'simrat39/symbols-outline.nvim',
    event = 'LspAttach',
    config = function()
        require('symbols-outline').setup({
            highlight_hovered_item = true,
            show_guides = true,
            auto_preview = false,
            relative_width = false,
            position = 'right',
            width = 40,
            show_numbers = false,
            show_relative_numbers = false,
            show_symbol_details = true,
            preview_bg_highlight = 'NormalFloat',
            lsp_blacklist = {},
            symbol_blacklist = {}
        })
    end
}}
