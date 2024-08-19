return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
            },
            sync_install = false,
            auto_install = true,
            highlight = { 
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        })
    end,
}