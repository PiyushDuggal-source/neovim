local icons = require "config.icons.icons"

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = {
    -- error = "%#SLError#" .. "" .. "%*" .. " ",
    -- warn = "%#SLWarning#" .. "" .. "%*" .. " ",
    error = "%#SLError#" .. icons.diagnostics.Error .. "%*" .. " ",
    warn = "%#SLWarning#" .. icons.diagnostics.Warning .. "%*" .. " ",
  },
  colored = false,
  update_in_insert = true,
  always_visible = true,
  padding = 1,
}
return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    -- code
    return {
      options = {

        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        -- component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
          "alpha",
          "dashboard",
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename" },
        lualine_x = {
          "encoding",
          diagnostics,
          { "filetype", icon_only = true },
          -- {
          --   "battery",
          --   show_percentage = true,
          --   show_status_text = false,
          --   view = {
          --     charge = {
          --       zeros = { icon = "󰂎 " },
          --       tens = { icon = "󰁺 " },
          --       twenties = { icon = "󰁻 " },
          --       thirties = { icon = "󰁼 " },
          --       forties = { icon = "󰁽 " },
          --       fifties = { icon = "󰁾 " },
          --       sixties = { icon = "󰁿 " },
          --       seventies = { icon = "󰂀 " },
          --       eighties = { icon = "󰂁 " },
          --       nineties = { icon = "󰂂 " },
          --       hundred = { icon = "󰁹 " },
          --     },
          --     status = {
          --       enabled = true,
          --       charging = { icon = " 󱐋" },
          --       discharging = { icon = " 󱐌" },
          --       not_charging = { icon = "  " },
          --       full = { icon = "  " },
          --       unknown = { icon = " " },
          --       critical = { icon = " " },
          --       percentage = { icon = " 󰏰" },
          --     },
          --   },
          -- },
          --
          -- -- 'filetype',
          -- {
          --   "ram",
          --   icon = "󰍛",
          --   -- show_percentage = true,
          -- },
          {
            "datetime",
            -- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
            style = "%H:%M",
          },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    }
  end,
}
