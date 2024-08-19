return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    dependencies = {
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/nvim-cmp',
        { 'L3MON4D3/LuaSnip', version = 'v2.*' }
    },
    config = function()
        local lsp_zero = require('lsp-zero')

        local lsp_attach = function(client, bufnr)
            client.server_capabilities.semanticTokensProvider = nil

            local opts = {
                buffer = bufnr,
                remap = false
            }

            vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
            vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set('n', '<leader>wp', function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set('n', '<leader>fd', function() vim.lsp.buf.references() end, opts)
            vim.keymap.set('n', '<leader>re', function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
        end

        lsp_zero.extend_lspconfig({
            sign_text = true,
            lsp_attach = lsp_attach,
            capabilities = require('cmp_nvim_lsp').default_capabilities()
        })

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {'lua_ls'},
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
                lua_ls = function()
                    require('lspconfig').lua_ls.setup({})
                end
            }
        })

        local cmp = require('cmp')
        local cmp_select = {behavior = cmp.SelectBehavior.Select}
        local cmp_mappings = cmp.mapping.preset.insert({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({select = true}),
            ['<C-Space>'] = cmp.mapping.complete(),
        })
        cmp.setup({
            sources = {
                {name = 'path'},
                {name = 'nvim_lsp'},
                {name = 'luasnip'}
            },
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },
            mapping = cmp_mappings,
        })
    end
}
