-- A series of functions that allow for quick parsing of "todo" items
-- in a directory subtree, appends them to a given .todo file, and 
-- allow for quick jumping from the list to the given file that needs work done
--
-- TODO: fix createlist overwriting scratch-pad bug
-- TODO: figure out how to do this in a more cross-platform manner
--
-- relevant rebinds are at the bottom

function CreateList(search_dir, output_file)
    dir = search_dir or "."
    out = output_file or "./.todo"

    if isFile(out) then
        vim.cmd([[!if rg list .todo; then sed -e "/^list/,/^EOF/d" ]]..out..' > '..out..[[; else echo "====\n" >> ]]..out..[[; fi]])
        vim.cmd('!echo "list" >> '..out)
        vim.cmd('!echo "====" >> '..out)
        vim.cmd('!rg -n TODO '..dir..' >> '..out)
    else 
        if not isDir(out) then
            Template(out)
            vim.cmd('!rg -n TODO '..dir..' > '..out)
        else
            print('pick a different file name')
        end
    end
end

function Template(path) 
    path = path or "./.todo"
    vim.cmd('echo "========\nscratch\n========\n\n\n====\nlist\n====" > '..path)
end

function JumpToItem(path, line)
    path = path or ''
    line = line or '0'

    vim.api.nvim_exec('e +' .. line .. ' ' .. path, false)
end

function ParseJumpLine(jump_data) 
    split_index = string.find(jump_data, ':')
    path = string.sub(jump_data, 1, split_index-1)
    line = string.sub(jump_data, split_index+1)
    JumpToItem(path, line)
end

-- this file only needs individual lines, 
-- this func might need to be changed in the future if I start needing blocks
function LoadVisualSelection() 
    local vf = vim.fn.getpos("'<")
    local ve = vim.fn.getpos("'>")
    text = vim.api.nvim_buf_get_text(0, vf[2]-1, vf[3]-1, ve[2]-1, ve[3], {})
    print(text[1])
    return text[1]
end

-- borrowed from here:
-- https://stackoverflow.com/questions/4990990/check-if-a-file-exists-with-lua
function exists(name)
    if type(name)~="string" then return false end
    return os.rename(name,name) and true or false
end

function isFile(name)
    if type(name)~="string" then return false end
    if not exists(name) then return false end
    local f = io.open(name)
    if f then f:close()
        return true
    end
    return false
end

function isDir(name)
    return(exists(name) and not isFile(name))
end



--bindings--

-- Make List
vim.keymap.set("n", "<leader>ml", "<cmd>lua CreateList()<CR>")
-- Jump to Item
vim.keymap.set("n", "<leader>ji", "0v2f:h<cmd>lua ParseJumpLine(LoadVisualSelection())<CR>")
