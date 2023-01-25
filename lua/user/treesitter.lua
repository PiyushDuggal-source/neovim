-- local status_ok, configs = pcall(require, "nvim-treesitter.configs")
-- if not status_ok then
--   return
-- end
-- configs.setup({
--   ensure_installed = { "c", "cpp", "lua", "javascript", "typescript", "python", "bash", "cmake", "json5", "gitignore",
--     "css", "tsx", "json", "vim", "dockerfile", "html", "css", "yaml", "markdown", "sql" },
--   -- ensure_installed = "all", -- one of "all" or a list of languages
--   ignore_install = { "" }, -- List of parsers to ignore installing
--   sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
--   highlight = {
--     enable = true, -- false will disable the whole extension
--     disable = { "css" }, -- list of language that will be disabled
--     additional_vim_highlighting = false,
--   },
--   autopairs = {
--     enable = true,
--   },
--   indent = { enable = true, disable = { "python", "css" } },
--
--   context_commentstring = {
--     enable = true,
--     enable_autocmd = false,
--   },
--   rainbow = {
--     enable = true,
--     -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
--     extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
--     max_file_lines = nil, -- Do not enable for files with more than n lines, int
--     -- colors = {}, -- table of hex strings
--     -- termcolors = {} -- table of colour name strings
--   },
--   autotag = {
--     enable = true,
--   }
-- })
--
--

local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
	return
end

local options = {
	ensure_installed = {
		"c",
		"cpp",
		"lua",
		"javascript",
		"typescript",
		"python",
		"bash",
		"cmake",
		"json5",
		"gitignore",
		"css",
		"tsx",
		"json",
		"vim",
		"dockerfile",
		"html",
		"css",
		"yaml",
		"markdown",
		"sql",
	},

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = {
		enable = true,
	},
  autotag = {
    enable = true,
  }
}

-- check for any override
-- options = require("core.utils").load_override(options, "nvim-treesitter/nvim-treesitter")

treesitter.setup(options)
