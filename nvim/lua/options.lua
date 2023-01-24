vim.opt.number = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.mouse = 'a'
vim.opt.wrap = true
vim.opt.scrolloff = 7
vim.opt.clipboard = 'unnamedplus'
vim.opt.signcolumn = 'yes'
vim.opt.smartindent = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.updatetime = 100
vim.opt.completeopt = 'menuone,noselect,noinsert'
vim.opt.shortmess = vim.opt.shortmess + {
    c = true
}
vim.opt.cmdheight = 0

-- Enable diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = true
})
