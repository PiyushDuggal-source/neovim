--

if vim.fn.has "mac" == 1 then
vim.cmd[[imap <silent><script><expr> <C-i> codeium#Accept()]]
else

vim.cmd[[imap <silent><script><expr> <M-i> codeium#Accept()]]
end

-- vim.api.nvim_set_keymap('n', '<D-i>', ':call codeium#Accept()<CR>', { noremap = true, silent = true })
-- -- vim.api.nvim_set_keymap('i', '<D-i>', '<C-o>:call codeium#Accept()<CR>', { noremap = true, silent = true })
vim.g.codeium_no_map_tab = true
