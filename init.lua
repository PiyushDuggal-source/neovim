require("user.options")
require("user.plugins")
require("user.keymaps")
require("user.lsp")
require("user.treesitter")
require("user.cmp")
require("user.autocommands")
require("user.colorscheme")
require("user.telescope-cfg")
require("user.gitsigns")
require("user.autopairs")
-- require("user.comment")
require("user.nvim-tree")
require("user.bufferline")
require("user.lualine")
require("user.toggleterm")
require("user.project")
require("user.impatient")
require("user.illuminate")
require("user.indentline")
require("user.alpha")
require("user.luasnip_setup")
require("user.copilot")
require("user.commands")
-- require("user.modicator")
require("user.navic")
require("user.noice")
--require("user.notify")
require("user.research")
require("user.todo-comments")
-- require("user.trouble")
require("user.winbar")
-- require("user.shade")
-- require "user.dap"
-- require 'user.coqCmp'
require("user.whichKey")
-- require("user.import-cost")
require("user.typescript")
require("Comment").setup()
-- require "user.tabout"
require("scope").setup()
-- require "user.colorizer"
-- vim.cmd(":COQnow --shut-up")
-- require("pets").setup({})
vim.cmd(":set laststatus=3")
vim.cmd([[colorscheme tokyonight-night]])
-- require("flirt").setup()
