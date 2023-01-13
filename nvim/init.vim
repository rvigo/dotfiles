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
map <silent> <C-J> :bnext<CR>
map <silent> <C-K> :bprev<CR>

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
 vnoremap  <leader>c  "+y
 nnoremap  <leader>c  "+y

" " Paste from clipboard
 nnoremap <leader>v "+p
 vnoremap <leader>v "+p

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
Plug 'projekt0n/github-nvim-theme'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'junegunn/fzf',  { 'do': { -> fzf#install() } }
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
Plug 'editorconfig/editorconfig-vim'
Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'folke/trouble.nvim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'justinmk/vim-sneak'
Plug 'preservim/nerdcommenter'
Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'machakann/vim-highlightedyank'
call plug#end()

filetype plugin indent on

" coq config
let g:coq_settings = { 'keymap.jump_to_mark': v:null, 'auto_start': 'shut-up', 'clients.snippets.warn': {} }
lua require("coq")

let g:vimspector_sidebar_width = 85
let g:vimspector_bottombar_height = 15
let g:vimspector_terminal_maxwidth = 70

autocmd BufWrite * try | call vm#reset() | catch | endtry

function s:openFileManager()
  if !argc()
    NvimTreeFocus
  endif
endfunction

autocmd VimEnter * call s:openFileManager()

lua << EOF
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    -- TODO validate why autocomplete is crashing thw window with rust
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
        })
    end
    null_ls.setup({
        sources = {
           
        formatting.rustfmt.with({
            extra_args = function(params)
            local cargo_toml = params.root .. "/" .. "Cargo.toml"
            local fd = vim.loop.fs_open(cargo_toml, "r", 438)
            if not fd then
                return
            end
            local stat = vim.loop.fs_fstat(fd)
            local data = vim.loop.fs_read(fd, stat.size, 0)
            vim.loop.fs_close(fd)
            for _, line in ipairs(vim.split(data, "\n")) do
                local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
                -- regex maybe wrong.
                if edition then
                return { "--edition=" .. edition }
                end
            end
            end
        }),
        formatting.autopep8,
        formatting.shfmt,
    },
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        lsp_formatting(bufnr)    
                    end,
                })
            end
        end,
    })

    require("trouble").setup({
        use_diagnostic_signs = true,
    })
    vim.keymap.set("n", "<Leader>tr", '<Cmd>TroubleToggle<CR>')   

    require('github-theme').setup()

    require("mason").setup()
    require("mason-lspconfig").setup()
    require("lspconfig")["pyright"].setup({
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150
        }
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local rt = require("rust-tools")
    rt.setup({
        server = {
            on_attach = function(client, bufnr)
                client.server_capabilities.document_formatting = false
                client.server_capabilities.document_range_formatting = false
                -- Hover actions
                vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, {
                    buffer = bufnr
                })
                -- Code action groups
                vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, {
                    buffer = bufnr
                })
            end
        }
    })

    -- Enable diagnostics
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        update_in_insert = true
    })

    -- Code navigation and shortcuts
    local keymap_opts = {
        buffer = buffer
    }

    vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, keymap_opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.implementation, keymap_opts)
    -- vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, keymap_opts)
    vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, keymap_opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
    vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
    vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
    
    vim.opt.smartindent = true
    vim.opt.cursorline = true
    vim.opt.termguicolors = true
    vim.opt.updatetime = 100
    vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
    vim.opt.shortmess = vim.opt.shortmess + {
        c = true
    }

    require("bufferline").setup({
        options = {
            offsets = {{
                filetype = "NvimTree",
                text = "EXPLORER",
                padding = 1
            }}
        }
    })

   
    vim.api.nvim_set_option('updatetime', 300)
    vim.cmd([[
        set signcolumn=yes
        autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
        ]])
    vim.cmd([[
        nmap <F9> <cmd>call vimspector#Launch()<cr>
        nmap <F5> <cmd>call vimspector#StepOver()<cr>
        nmap <F8> <cmd>call vimspector#Reset()<cr>
        nmap <F11> <cmd>call vimspector#StepOver()<cr>")
        nmap <F12> <cmd>call vimspector#StepOut()<cr>")
        nmap <F10> <cmd>call vimspector#StepInto()<cr>")
        ]])

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

    require("nvim-tree").setup({
        view = {
            adaptive_size = true,
            width = 30,
            hide_root_folder = true,
            mappings = {
                list = {{
                    key = "<C-o>",
                    action = "vsplit"
                }, {
                    key = "<ESC>",
                    action = "close"
                }, {
                    key = "..",
                    action = "dir_up"
                }, {
                    key = "cd",
                    action = "cd"
                }, {
                    key = "w",
                    action = "expand_all"
                }, {
                    key = "e",
                    action = "collapse_all"
                }, {
                    key = "<C-k>",
                    action = ""
                }, {
                    key = "<C-t>",
                    action = ""
                } -- unset default
                }
            }
        },
        git = {
            enable = true,
            ignore = true
        },
        filters = {
            dotfiles = false
        },
        actions = {
            open_file = {
                resize_window = true
            }
        }
    })

    require("bufferline").setup()

    require('lualine').setup({
        options = {
            icons_enabled = true,
            theme = 'powerline'
        }
    })

    vim.opt.list = true
    vim.opt.listchars:append "space:⋅"
    vim.opt.listchars:append "eol:↴"

    require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
    }

    require("toggleterm").setup({
        size = 22,
        open_mapping = [[<C-t>]],
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
        persist_size = true,
        direction = 'horizontal', -- 'vertical' | 'horizontal' | 'tab' | 'float'
        close_on_exit = true, -- close the terminal window when the process exits
        -- shell = vim.o.shell, -- change the default shell
        -- This field is only relevant if direction is set to 'float'
        -- float_opts = {
        --     border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved'
        --     winblend = 3
        -- }
    })

EOF
