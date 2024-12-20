return {
    'theprimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local harpoon = require('harpoon')

        harpoon:setup({
            settings = {
                save_on_toggle = true,
            },
        })

        vim.keymap.set('n', '<leader>aa', function() harpoon:list():add() end)
        vim.keymap.set('n', '<leader>ah', function() harpoon:list():replace_at(1) end)
        vim.keymap.set('n', '<leader>aj', function() harpoon:list():replace_at(2) end)
        vim.keymap.set('n', '<leader>ak', function() harpoon:list():replace_at(3) end)
        vim.keymap.set('n', '<leader>al', function() harpoon:list():replace_at(4) end)
        vim.keymap.set('n', '<leader>a;', function() harpoon:list():replace_at(5) end)

        vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        vim.keymap.set('n', '<leader>hd', function() harpoon:list():clear() end)

        vim.keymap.set('n', "<C-h>", function() harpoon:list():select(1) end)
        vim.keymap.set('n', "<C-j>", function() harpoon:list():select(2) end)
        vim.keymap.set('n', "<C-k>", function() harpoon:list():select(3) end)
        vim.keymap.set('n', "<C-l>", function() harpoon:list():select(4) end)
        vim.keymap.set('n', "<C-;>", function() harpoon:list():select(5) end)
    end,
}
