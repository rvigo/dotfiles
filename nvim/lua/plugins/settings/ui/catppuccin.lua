require('catppuccin').setup({
    integrations = {
        notify = true,
        vim_sneak = true,
        which_key = true,
        telescope = true,
        treesitter = true,
        nvimtree = true,
        mason = true,
        gitsigns = true
    }
})

vim.cmd.colorscheme 'catppuccin'
