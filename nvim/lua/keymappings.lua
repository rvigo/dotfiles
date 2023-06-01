-- TODO: improve this
if vim.g.vscode
then
    vim.keymap.set("n", "<C-L>", "<cmd>Tabnext<CR>", { silent = true, noremap = true })
    vim.keymap.set("n", "<C-H>", "<cmd>Tabprevious<CR>", { silent = true, noremap = true })
else 
    vim.keymap.set("n", "<C-L>", "<cmd>bnext<CR>", { silent = true, noremap = true })
    vim.keymap.set("n", "<C-H>", "<cmd>bprev<CR>", { silent = true, noremap = true })
end
vim.keymap.set("n", "<C-S>", "<cmd>write<CR>", { silent = true })
vim.keymap.set("v", "<C-S>", "<C-C><cmd>write<CR>", { silent = true })
vim.keymap.set("i", "<C-S>", "<C-O><cmd>write<CR>", { silent = true })
vim.keymap.set("n", "<C-z>", "<cmd>undo<CR>", { silent = true })
vim.keymap.set("v", "<C-z>", "<C-C><cmd>undo<CR>", { silent = true })
vim.keymap.set("i", "<C-z>", "<C-O><cmd>undo<CR>", { silent = true })
vim.keymap.set("n", "<C-y>", "<cmd>redo<CR>", { silent = true })
vim.keymap.set("v", "<C-y>", "<C-C><cmd>redo<CR>", { silent = true })
vim.keymap.set("i", "<C-y>", "<C-O><cmd>redo<CR>", { silent = true })
vim.keymap.set("v", "<C-c>", "+y", { noremap = true })
vim.keymap.set("n", "<C-c>", "+y", { noremap = true })
vim.keymap.set("n", "<C-v>", "+p", { noremap = true })
vim.keymap.set("v", "<C-v>", "+p", { noremap = true })
