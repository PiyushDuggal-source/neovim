-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.cmd([[:set laststatus=3]])
vim.cmd([[colorscheme tokyonight-night]])

-- Enable LazyVim auto format
vim.g.autoformat = false
vim.cmd[[imap <silent><script><expr> <M-i> codeium#Accept()]]
vim.g.codeium_no_map_tab = true

vim.g.luasnippets_path = vim.fn.stdpath("config") .. "/cool_snippets"
