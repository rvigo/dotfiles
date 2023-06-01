if (not vim.g.vscode)
then
    require('manager')
    require('options')
end

require('keymappings')
require('autocmds')
