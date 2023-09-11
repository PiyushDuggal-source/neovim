local icons = require("user.icons")

if vim.version().major > 7 then
  require("winbar").setup {

    enabled = true,

    show_file_path = true,
    show_symbols = true,

    colors = {
      path = "", -- You can customize colors like #c946fd
      file_name = "",
      symbols = "",
    },
    icons = {
      -- file_icon_default = "",
      -- seperator = ">",
      -- editor_state = "●",
      -- lock_icon = "",

      file_icon_default = icons.ui.File,
      seperator = ">",
      editor_state = icons.ui.Pencil,
      lock_icon = icons.ui.Lock,
    },

    exclude_filetype = {
      "help",
      "startify",
      "dashboard",
      "packer",
      "neogitstatus",
      "NvimTree",
      "Trouble",
      "alpha",
      "lir",
      "Outline",
      "spectre_panel",
      "toggleterm",
      "qf",
    },
  }
else
  return {}
end
