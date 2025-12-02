require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		vue = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		less = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		python = { "black" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		sh = { "shfmt" },
	},
	formatters = {
		black = {
			prepend_args = { "--fast" },
		},
	},
	-- Set up format-on-save
	-- format_on_save = { timeout_ms = 500, lsp_fallback = true },
})
