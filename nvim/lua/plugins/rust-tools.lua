local rt = require("rust-tools")
rt.setup({
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_actions = {
            auto_focus = true
        },
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = ""
        }
    },
    server = {
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                }
            }
        },
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, {
                buffer = bufnr
            })
            -- Code action groups
            vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, {
                buffer = bufnr
            })
        end
    }
})
