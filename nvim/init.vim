set number                 " Sets line numbers
set autoindent             " Sets auto indentation
set tabstop=2              " Sets tabstop
set shiftwidth=2           " For proper indentation
set smarttab               " Affects how tab key presses are interpreted
set softtabstop=2          " Control how many columns Vim uses when you hit tab key
set mouse=a                " This lets you use your mouse
set wrap                   " Sets up line wrapping

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'puremourning/vimspector'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'nvim-tree/nvim-tree.lua'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}
call plug#end()

let g:coq_settings = { 'keymap.jump_to_mark': v:null, 'auto_start': v:true, 'clients.snippets.warn': {} }
lua require("coq")

let g:vimspector_sidebar_width = 85
let g:vimspector_bottombar_height = 15
let g:vimspector_terminal_maxwidth = 70
set termguicolors


lua << EOF
	require("mason").setup()
	require("mason-lspconfig").setup()
  
  local rt = require("rust-tools")
  rt.setup({
    server = {
      settings = {
        ["rust-analyzer"] = {
          inlayHints = { locationLinks = false },
        },
      },
      on_attach = function(_, bufnr)
        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      end,
    },
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.rs",
    callback = function()
    vim.lsp.buf.format(nil, 200)
    end,
    group = format_sync_grp,
  })

  vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
  vim.opt.shortmess = vim.opt.shortmess + { c = true}
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

  require('nvim-treesitter.configs').setup {
    ensure_installed = { "lua", "rust", "toml", "python",  "yaml" },
    auto_install = true,
    highlight = {
      enable = true,
    },
    ident = { enable = true }, 
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    }
  }
  vim.g.coq_settings = {
    auto_start = 'shut-up',
    ['keymap.jump_to_mark'] = '',
      ['display.icons.mode'] = 'none',
      ['clients.third_party.enabled'] = false,
  }
  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
      adaptive_size = true,
      mappings = {
        list = {
          { key = "u", action = "dir_up" },
        },
      },
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  })

  vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')

  require("bufferline").setup()
  require('lualine').setup({
    options = {
      icons_enabled = true,
      theme = 'powerline',
  }
}) 
require("toggleterm").setup{
  size = 22,
  open_mapping = [[<c-s>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  direction = 'float', -- 'vertical' | 'horizontal' | 'tab' | 'float'
  close_on_exit = true, -- close the terminal window when the process exits
  -- shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved'
    winblend = 3,
  }
}

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)

end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
EOF
