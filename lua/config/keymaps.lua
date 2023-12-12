-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { noremap = true, silent = true }

--Spliting window
keymap("n", "<C-s>", ":vsplit<CR>gd", opts)

-- for emoji
vim.keymap.set("n", "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

keymap("n", "<C-z>", "u", opts)

-- Go to preview Keymaps
keymap("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true })
keymap("n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", opts)
keymap("n", "gpi", "lua require('goto-preview').goto_preview_implementation()", opts)
keymap("n", "gP", "lua require('goto-preview').close_all_win()", opts)
keymap("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()", opts)


keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float({border= 'rounded' })<CR>", opts)
-- Search
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap( "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
keymap( "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
