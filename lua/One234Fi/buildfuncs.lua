
-----------------------------
-- local utility functions --
-----------------------------

local is_single_file = function() 
    if (vim.lsp.buf_get_clients()[1].config.root_dir == nil) then
        return true
    else
        return false
    end
end

local get_root_dir = function() 
    return vim.lsp.buf_get_clients()[1].config.root_dir
end

local file_type = function()
    return vim.lsp.buf_get_clients()[1].config.filetypes[1]
end

local get_pom_dir = function()
    local pom = vim.fs.find('pom.xml', {
        upward = true,
        stop = vim.loop.os_homedir(),
        path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
    })
    local iter = string.gmatch(pom[1], "([^/]+)")
    local temp = "";
    while true do
        local element = iter();
        if element == "pom.xml" then
            return temp
        else
            temp = element;
        end
    end
end

----------------------------------------------------------------------
-- local tables that define the default behaviour for each function --
----------------------------------------------------------------------

local t_build = {
    lua = function() vim.cmd('so') end,

    java = function(single_file)
        if single_file then
            vim.cmd('!javac ' .. vim.api.nvim_buf_get_name(0))
        else
            vim.cmd('!mvn package')
        end
    end,

    rust = function(single_file)
        if single_file then
            vim.cmd('echo implement single file rust build')
        else
            vim.cmd('!cargo build')
        end
    end,

}

local t_compile = {
    lua = function() vim.cmd('so') end,

    java = function(single_file)
        if single_file then 
            vim.cmd('!javac ' .. vim.api.nvim_buf_get_name(0))
        else
            vim.cmd('!mvn compile')
        end
    end,

    rust = function(single_file)
        if single_file then
            vim.cmd('echo implement rust compile for single files')
        else
            vim.cmd('!cargo compile')
        end
    end,

}

local t_run = {
    lua = function() vim.cmd('so') end,

    java = function(single_file)
        if single_file then
            vim.cmd('!java ' .. vim.api.nvim_buf_get_name(0))
        else
            --TODO: this might only work on my machine, figure out how to generalize it
            vim.cmd('!java -cp target\\' .. get_pom_dir() .. '-1.0-SNAPSHOT.jar One234Fi.App')
        end
    end,

    rust = function(single_file)
        if single_file then
            vim.cmd('echo implement rust compile for single files')
        else
            vim.cmd('!cargo run')
        end
    end,

}

local t_clean = {}


---------------------------------------------------
-- global functions that can be bound to hotkeys --
---------------------------------------------------

Build = function()
    t_build[file_type()](is_single_file())
end

Compile = function()
    t_compile[file_type()](is_single_file())
end

Clean = function()
    t_clean[file_type()](is_single_file())
end

Run = function()
    t_run[file_type()](is_single_file())
end

