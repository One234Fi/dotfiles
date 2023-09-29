-- this can be removed after setup is finished
-- vim.opt_global.shortmess:remove("F")

metals_config = require("metals").bare_config()

metals_config.settings = {
    showImplicitArguments = true,
}
metals_config.init_options.statusBarProvider = "on"



local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt" },
        callback = function()
            require("metals").initialize_or_attach({metals_config})
        end,
        group = nvim_metals_group,
    }
)

