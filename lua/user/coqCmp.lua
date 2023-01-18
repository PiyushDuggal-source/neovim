local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

local servers = {
	"sumneko_lua",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	-- "yamlls",
}

vim.g.coq_settings = {
  ['keymap.bigger_preview'] = "<c-0>",
  ['keymap.jump_to_mark'] = "<c-9>",
  ['display.icons.mappings'] = kind_icons,
  ['clients.lsp.always_on_top'] = servers
}
