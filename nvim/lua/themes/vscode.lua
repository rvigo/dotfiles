vim.o.background = 'dark'
local c = require('vscode.colors').get_colors()
require('vscode').setup({
    -- Enable transparent background
    transparent = true,

    -- Enable italic comment
    italic_comments = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    -- Override colors (see ./lua/vscode/colors.lua)
    color_overrides = {
        vscLineNumber = '#FFFFFF'
    },

    -- Override highlight groups (see ./lua/vscode/theme.lua)
    group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        Cursor = {
            fg = c.vscDarkBlue,
            bg = c.vscLightGreen,
            bold = true
        }
    }
})

-- hides the "~" at end of file
vim.cmd([[hi EndOfBuffer guifg=#24292e]])
vim.cmd([[hi CustomInlay guifg=#6f6c6f gui=italic]])
vim.cmd([[hi GitSignsCurrentLineBlame guifg=#6f6c6f]])
