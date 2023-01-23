-- vim.cmd([[
--     let g:vimspector_sidebar_width = 85
--     let g:vimspector_bottombar_height = 15
--     let g:vimspector_terminal_maxwidth = 70
--     let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
--     nmap <leader>vl :call vimspector#Launch()<CR>
--     nmap <leader>vr :VimspectorReset<CR>
--     nmap <leader>ve :VimspectorEval
--     nmap <leader>vw :VimspectorWatch
--     nmap <leader>vo :VimspectorShowOutput
--     nmap <leader>vi <Plug>VimspectorBalloonEval
--     xmap <leader>vi <Plug>VimspectorBalloonEval
-- ]])
vim.g.vimspector_sidebar_width = 85
vim.g.vimspector_bottombar_height = 15
vim.g.vimspector_terminal_maxwidth = 70
vim.g.vimspector_enable_mappings = 'VISUAL_STUDIO'

vim.api.nvim_set_keymap("n", "<leader>vl", ":call vimspector#Launch()<CR>", {
    noremap = true
})
vim.api.nvim_set_keymap("n", "<leader>vr", ":VimspectorReset<CR>", {
    noremap = true
})
vim.api.nvim_set_keymap("n", "<leader>ve", ":VimspectorEval", {
    noremap = true
})
vim.api.nvim_set_keymap("n", "<leader>vw", ":VimspectorWatch", {
    noremap = true
})
vim.api.nvim_set_keymap("n", "<leader>vo", ":VimspectorShowOutput", {
    noremap = true
})
vim.api.nvim_set_keymap("n", "<leader>vi", "<Plug>VimspectorBalloonEval", {
    noremap = true
})
vim.api.nvim_set_keymap("x", "<leader>vi", "<Plug>VimspectorBalloonEval", {
    noremap = true
})
