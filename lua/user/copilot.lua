-- local keymap = vim.keymap.set
vim.cmd([[imap <silent><script><expr> <M-i> copilot#Accept()]])
-- keymap("i", "<M-i>", ":copilot#Accept('\\<CR>')<CR>", { silent = true })
-- keymap("i", "<M-i>", function()
-- 	return vim.fn["copilot#Accept()"]()
-- end, { silent = true })
vim.g.copilot_no_tab_map = true
