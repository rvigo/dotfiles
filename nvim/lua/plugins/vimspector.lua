vim.cmd([[
    let g:vimspector_sidebar_width = 85
    let g:vimspector_bottombar_height = 15
    let g:vimspector_terminal_maxwidth = 70
    let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
    nmap <leader>vl :call vimspector#Launch()<CR>
    nmap <leader>vr :VimspectorReset<CR>
    nmap <leader>ve :VimspectorEval
    nmap <leader>vw :VimspectorWatch
    nmap <leader>vo :VimspectorShowOutput
    nmap <leader>vi <Plug>VimspectorBalloonEval
    xmap <leader>vi <Plug>VimspectorBalloonEval
]])
