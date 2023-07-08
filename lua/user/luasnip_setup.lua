local present, luasnip = pcall(require, "luasnip")
if not present then
	return
end

local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/my-snippets/" })

local options = {
	history = true,
	enable_autosnippets = true,
	ext_opts = {
		[c] = {
			active = {
				virt_text = { { "●", "GruvboxOrange" } },
			},
		},
	},
	updateevents = "TextChanged,TextChangedI",
}

luasnip.config.set_config(options)
-- require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = "./cool_snippets" })

vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		if
			require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
			and not require("luasnip").session.jump_active
		then
			require("luasnip").unlink_current()
		end
	end,
})

ls.add_snippets("typescript", {
	s(
		"cfun",
		fmt(
			"const {} = ({}) => {{\n console.log('\\nEntering {}')\n {}\n console.log('Leaving {}\\n')\n}}",
			{ i(1, "functionName"), i(2), rep(1), i(3), rep(1) }
		)
	),
	s(
		"expfun",
		fmt(
			"export const {} = ({}) => {{\n console.log('\\nEntering {}')\n {}\n console.log('Leaving {}\\n')\n}}",
			{ i(1, "functionName"), i(2), rep(1), i(3), rep(1) }
		)
	),
	s("funLogE", fmt("console.log('\\nEntering {}')\n", { i(1) })),
	s("funLogL", fmt("console.log('Leaving {}\\n')\n", { i(1) })),

	-- s(
	-- 	"cfun",
	-- 	{
	-- 		t("const "),
	-- 		i(1),
	-- 		t(" = () => { console.log('Entering ', "),
	-- 		rep(1),
	-- 		t(")"),
	-- 		i(2),
	-- 		t(" console.log('Leaving ', "),
	-- 		rep(1),
	-- 		t(")"),
	-- 		i(3),
	-- 		t("}"),
	-- 	},
	-- 	{}
	-- ),
})

-- Shorten function name
local keymap = vim.keymap.set
-- lua snip Keymaps
keymap({ "i", "s" }, "<C-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

keymap({ "i", "s" }, "<C-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

keymap("i", "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

keymap("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/user/luasnip_setup.lua<CR>")
