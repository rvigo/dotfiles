require('toggleterm').setup({
    size = 22,
    open_mapping = [[<C-t>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    auto_scroll = true,
    shade_filetypes = {},
    shade_terminals = true,
    start_in_insert = true,
    shading_factor = 1,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    direction = 'horizontal', -- 'vertical' | 'horizontal' | 'tab' | 'float'
    close_on_exit = true -- close the terminal window when the process exits
})
