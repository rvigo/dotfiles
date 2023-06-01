return {
    {
        'catppuccin/nvim',
        config = function()
            require('plugins.settings.ui.catppuccin')
        end
    }, {
    'freddiehaddad/feline.nvim',
    dependencies = 'catppuccin/nvim',
    config = function()
        require('plugins.settings.ui.feline')
    end
}, {
    'goolord/alpha-nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'catppuccin/nvim'
    },
    lazy = false,
    config = function()
        require('plugins.settings.ui.alpha')
    end
}, {
    'akinsho/bufferline.nvim',
    name = 'bufferline',
    event = "User BufReadRealFile",
    tag = 'v3.1.0',
    dependencies = {
        'freddiehaddad/feline.nvim',
        'catppuccin/nvim',
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        require('plugins.settings.ui.bufferline')
    end
}, {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VeryLazy',
    cmd = {
        'NvimTreeOpen',
        'NvimTreeToggle',
        'NvimTreeFocus',
        'NvimTreeFindFile'
    },
    config = function()
        require('plugins.settings.ui.tree')
    end
}, {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    config = function()
        require('plugins.settings.ui.notify')
    end
},
}
