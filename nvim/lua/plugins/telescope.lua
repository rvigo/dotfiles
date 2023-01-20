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
        file_ignore_patterns = {'.git/'},
        path_display = {'truncate'},
        winblend = 0,
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true
    },
    pickers = {
        find_files = {
            find_command = {'rg', '--ignore', '-L', '--hidden', '--files'}
        }
    },
    extensions = {
        project = {
            theme = 'dropdown',
            base_dirs = {{
                '~/some_folder',
                max_depth = 3
            }},
            sync_with_nvim_tree = true
        }

    }
})
require('telescope').load_extension('project')
