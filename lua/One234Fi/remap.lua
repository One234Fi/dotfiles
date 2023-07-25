vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)

-- highlighted text can be moved up and down with J or K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor centered when jumping half page and stuff
vim.keymap.set("n", "Y", "yg$")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- leader p preserves clipboard and pastes instead of overwriting and pasting
vim.keymap.set("x", "<leader>p", "\"_dP")

-- leader y cuts to system clipboard instead of vim clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- delete to void register with leader d
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- idk what anything below this comment does yet tbh
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionaizer<CR>")
vim.keymap.set("n", "<leader>f", function()
    vim.lsb.buf.format()
end)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- custom build script remaps
vim.keymap.set("n", "<leader>bh", "<cmd>lua Build()<cr>")
vim.keymap.set("n", "<leader>nj", "<cmd>lua Clean()<cr>")
vim.keymap.set("n", "<leader>e", "<cmd>lua Run()<cr>")
vim.keymap.set("n", "<leader>mk", "<cmd>lua Compile()<cr>")
