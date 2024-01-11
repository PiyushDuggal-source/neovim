local status_ok, indent_blankline = pcall(require, "mini.indentscope")
if not status_ok then
  return
end

indent_blankline.setup {
  symbol = "|",
  show_trailing_blankline_indent = false,
  show_first_indent_level = true,
  options = { try_as_border = true },
  use_treesitter = true,
  show_current_context = true,
  buftype_exclude = { "terminal", "nofile" },
  filetype_exclude = {
    "help",
    "packer",
    "NvimTree",
  },
}

