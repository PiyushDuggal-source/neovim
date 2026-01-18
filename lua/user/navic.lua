local present, navic = pcall(require, "nvim-navic")

if not present then
  return
end

local icons = require "user.icons"

navic.setup {
  -- icons = {
  --   File = " ",
  --   Module = " ",
  --   Namespace = " ",
  --   Package = " ",
  --   Class = " ",
  --   Method = " ",
  --   Property = " ",
  --   Field = " ",
  --   Constructor = " ",
  --   Enum = "練",
  --   Interface = "練",
  --   Function = " ",
  --   Variable = " ",
  --   Constant = " ",
  --   String = " ",
  --   Number = " ",
  --   Boolean = "◩ ",
  --   Array = " ",
  --   Object = " ",
  --   Key = " ",
  --   Null = "ﳠ ",
  --   EnumMember = " ",
  --   Struct = " ",
  --   Event = " ",
  --   Operator = " ",
  --   TypeParameter = " ",
  -- },

  icons = {
    File = icons.kind.File .. " ",
    Module = icons.kind.Module .. " ",
    Namespace = icons.kind.Namespace .. " ",
    Package = icons.kind.Package .. " ",
    Class = icons.kind.Class .. " ",
    Method = icons.kind.Method .. " ",
    Property = icons.kind.Property .. " ",
    Field = icons.kind.Field .. " ",
    Constructor = icons.kind.Constructor .. " ",
    Enum = icons.kind.Enum .. " ",
    Interface = icons.kind.Interface .. " ",
    Function = icons.kind.Function .. " ",
    Variable = icons.kind.Variable .. " ",
    Constant = icons.kind.Constant .. " ",
    String = icons.kind.String .. " ",
    Number = icons.kind.Number .. " ",
    Boolean = icons.kind.Boolean .. " ",
    Array = icons.kind.Array .. " ",
    Object = icons.kind.Object .. " ",
    Key = " ",
    Null = "ﳠ ",
    EnumMember = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
  },

  highlight = true,
  separator = " > ",
  depth_limit = 0,
  depth_limit_indicator = "..",
}

vim.opt.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
