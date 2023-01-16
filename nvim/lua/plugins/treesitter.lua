require('nvim-treesitter.configs').setup({
    ensure_installed = {"lua", "rust", "toml", "python", "yaml", "json", "java", "kotlin", "bash", "dockerfile", "json",
                        "markdown", "terraform"},
    auto_install = true,
    highlight = {
        enable = true
    },
    ident = {
        enable = true
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil
    }
})
