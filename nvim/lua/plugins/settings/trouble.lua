require('trouble').setup({
    position = 'right',
    use_diagnostic_signs = true,
    auto_close = true
})

-- mapping keys to which-key
local mappings = {
    t = {
        name = 'trouble',
        t = { ':TroubleToggle<CR>', 'toggle Trouble' },
        r = { ':TroubleRefresh<CR>', 'refresh Trouble' }
    },
}

require('which-key').register(mappings, { prefix = '<leader>', mode = { 'n', 'v' } })
