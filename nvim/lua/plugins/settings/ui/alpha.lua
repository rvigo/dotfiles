local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

-- Set header
dashboard.section.header.val =
{ "        `       --._    `-._   `-.   `.     :   /  .'   .-'   _.-'    _.--'                 ",
    "        `--.__     `--._   `-._  `-.  `. `. : .' .'  .-'  _.-'   _.--'     __.--'           ",
    "           __    `--.__    `--._  `-._ `-. `. :/ .' .-' _.-'  _.--'    __.--'    __         ",
    "            `--..__   `--.__   `--._ `-._`-.`_=_'.-'_.-' _.--'   __.--'   __..--'           ",
    "          --..__   `--..__  `--.__  `--._`-q(-_-)p-'_.--'  __.--'  __..--'   __..--         ",
    "                ``--..__  `--..__ `--.__ `-'_) (_`-' __.--' __..--'  __..--''               ",
    "          ...___        ``--..__ `--..__`--/__/  --'__..--' __..--''        ___...          ",
    "                ```---...___    ``--..__`_(<_   _/)_'__..--''    ___...---'''               ",
    "           ```-----....._____```---...___(____|_/__)___...---'''_____.....-----'''          ", "    " }

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button('e', '  > New file', ':ene <BAR> startinsert<CR>'),
    dashboard.button('f', '  > Find file', ':Telescope oldfiles<CR>'),
    dashboard.button('r', '  > Find repos', ':Telescope project<CR>'),
    dashboard.button('s', '  > Settings', ':e ~/.config/nvim/<CR>'),
    dashboard.button('q', '  > Quit NVIM', ':qa!<CR>')
}

local function footer()
    local total_plugins = require("lazy").stats().count
    local loaded_plugins = require("lazy").stats().loaded
    local load_time = require("lazy").stats().startuptime
    return " " .. total_plugins .. " plugins (" .. loaded_plugins .. " loaded in " .. load_time .. " ms)"
end

dashboard.section.footer.val = footer()

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'alpha*',
    callback = function()
        vim.wo.foldenable = false
    end
})
