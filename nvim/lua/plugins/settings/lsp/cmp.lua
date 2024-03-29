local cmp = require('cmp')
local lspkind = require('lspkind')

local has_words_before = function()
    ---@diagnostic disable-next-line: deprecated
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

---@diagnostic disable-next-line: redundant-parameter
cmp.setup({
    enabled = function()
        -- disable completion in comments
        local context = require('cmp.config.context')
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == 'c' then
            return true
        else
            return not context.in_treesitter_capture('comment') and not context.in_syntax_group('Comment')
        end
    end,
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end
    },
    window = {
        documentation = cmp.config.window.bordered({
            border = 'single',
            winhighlight = 'NormalFloat:CmpDocumentation,FloatBorder:CmpDocumentationBorder'
        })
    },
    mapping = {
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<Esc>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),

        ['<CR>'] = cmp.mapping.confirm({
            select = true
        }),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i' }),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i' }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn['vsnip#available'](1) == 1 then
                feedkey('<Plug>(vsnip-expand-or-jump)', '')
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn['vsnip#jumpable'](-1) == 1 then
                feedkey('<Plug>(vsnip-jump-prev)', '')
            end
        end, { 'i', 's' })
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'buffer' }
    }),
    completion = {
        completeopt = 'menu,menuone,noinsert,preview'
    },
    -- cmp kind info
    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50
        })
    }
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
    sources = { {
        name = 'buffer'
    } },
    completion = {
        completeopt = 'menu,noselect'
    }
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({ {
        name = 'path'
    } }, { {
        name = 'cmdline'
    } }),
    formatting = {
        fields = { 'abbr', 'kind' }
    },
    completion = {
        completeopt = 'menu,noselect'
    }
})

cmp.setup.filetype('TelescopePrompt', {
    enabled = false
})

require("nvim-autopairs").setup({ disable_filetype = { "TelescopePrompt", "vim" } })

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({
    map_char = {
        tex = ''
    }
}))
