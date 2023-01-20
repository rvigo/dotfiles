set number                 " Sets line numbers
set autoindent             " Sets auto indentation
set expandtab              " convert tab to spaces
set tabstop=4              " Sets tabstop
set shiftwidth=4           " For proper indentation
set smarttab               " Affects how tab key presses are interpreted
set softtabstop=4          " Control how many columns Vim uses when you hit tab key
set mouse=a                " This lets you use your mouse
set wrap                   " Sets up line wrapping
set scrolloff=7            " 7 lines above/below cursor when scrolling
set clipboard=unnamedplus  " Use + register (X Window clipboard) as unnamed register

" move among buffers with CTRL
noremap <silent> <C-J> :bnext<CR>
noremap <silent> <C-K> :bprev<CR>

map <silent> <A-\> :NvimTreeToggle<CR>
map <silent> <C-\> :NvimTreeFocus<CR>

" saving
noremap <silent> <C-S>     :write<CR>
vnoremap <silent> <C-S>    <C-C>:write<CR>
inoremap <silent> <C-S>    <C-O>:write<CR>

" undo
noremap <silent> <C-z>     :undo<CR>
vnoremap <silent> <C-z>    <C-C>:undo<CR>
inoremap <silent> <C-z>    <C-O>:undo<CR>

" redo
noremap <silent> <C-y>     :redo<CR>
vnoremap <silent> <C-y>    <C-C>:redo<CR>
inoremap <silent> <C-y>    <C-O>:redo<CR>

" Copy to clipboard
vnoremap  <C-c>  "+y
nnoremap  <C-c>  "+y

" " Paste from clipboard
nnoremap <C-v> "+p
vnoremap <C-v> "+p

" auto install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin()
Plug 'puremourning/vimspector'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'junegunn/fzf',  { 'do': { -> fzf#install() } }
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'folke/trouble.nvim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'justinmk/vim-sneak'
Plug 'preservim/nerdcommenter'
Plug 'nvim-lua/plenary.nvim'
Plug 'machakann/vim-highlightedyank'
Plug 'Mofiqul/vscode.nvim'
Plug 'folke/which-key.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'goolord/alpha-nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-telescope/telescope-project.nvim'
call plug#end()

filetype plugin indent on

autocmd BufWrite * try | call vm#reset() | catch | endtry

autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()

lua << EOF
    -- plugins configs
    -- NOTE keep the 'requires' in this order
    require('themes.vscode')
    require('themes.alpha')
    require('lsp.mason')
    require('lsp.mason-lspconfig')
    require('lsp.rust-tools')
    require('plugins.whichkey')
    require('plugins.bufferline')
    require('plugins.tree')
    require('plugins.toggleterm')
    require('plugins.treesitter')
    require('plugins.trouble')
    require('plugins.coq')
    require('plugins.vimspector')
    require('plugins.lualine')
    require('plugins.nerdcommenter')
    require('plugins.indent-blankline')
    require('plugins.gitsigns')
    require('plugins.telescope')

    -- Enable diagnostics
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        update_in_insert = true
    })

    -- Code navigation and shortcuts
    local keymap_opts = {
        buffer = buffer
    }

    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, keymap_opts)

    vim.opt.smartindent = true
    vim.opt.cursorline = true
    vim.opt.termguicolors = true
    vim.opt.updatetime = 100
    vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
    vim.opt.shortmess = vim.opt.shortmess + {
        c = true
    }

    -- TODO fix me
    vim.cmd([[
        set signcolumn=yes
        autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
    ]])

EOF
