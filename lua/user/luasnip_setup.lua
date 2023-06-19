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

local options = {
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
			"const {} = ({}) => {{\n console.log('Entering {}')\n {}\n console.log('Leaving {}')\n}}",
			{ i(1, "functionName"), i(2), rep(1),i(3), rep(1) }
		)
	),
	s(
		"expfun",
		fmt(
			"export const {} = ({}) => {{\n console.log('Entering {}')\n {}\n console.log('Leaving {}')\n}}",
			{ i(1, "functionName"), i(2), rep(1),i(3), rep(1) }
		)
	),
	s(
		"funLogE",
		fmt(
			"console.log('Entering {}')\n",
			{ i(1)}
		)
	),
	s(
		"funLogL",
		fmt(
			"console.log('Leaving {}')\n",
			{ i(1)}
		)
	),

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
