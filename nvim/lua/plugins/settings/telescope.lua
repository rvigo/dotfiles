require('telescope').setup({
    defaults = {
        results_title = false,
        layout_strategy = 'horizontal',
        layout_config = {
            horizontal = {
                prompt_position = 'top',
                preview_width = 0.55,
                results_width = 0.8
            },
            vertical = {
                mirror = false
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120
        },
        file_ignore_patterns = { '.git/' },
        path_display = { 'truncate' },
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = true
    },
    pickers = {
        find_files = {
            find_command = { 'rg', '--ignore', '-L', '--hidden', '--files' }
        }
    },
    extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown() },
        project = {
            theme = 'dropdown',
            base_dirs = {
                {
                    '~/wsl_projects/',
                    max_depth = 3
                }, {
                    '~/projetos/',
                    max_depth = 3
                }
            },
            sync_with_nvim_tree = true
        }

    }
})
require('telescope').load_extension('project')
require('telescope').load_extension('notify')
require('telescope').load_extension('ui-select')

-- mapping keys to which-key
local mappings = {
    T = {
        name = 'telescope',
        f = { ':Telescope find_files<CR>', 'find files' },
        g = { ':Telescope live_grep<CR>', 'grep files' },
        b = { ':Telescope buffers<CR>', 'find buffers' }
    },
    p = {
        name = 'project',
        o = { ':Telescope project<CR>', 'open project' }
    }
}

require('which-key').register(mappings, { prefix = '<leader>', mode = { 'x', 'n', 's' } })
