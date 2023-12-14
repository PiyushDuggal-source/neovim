return {
  "folke/noice.nvim",
  opts = {
    view = "cmdline_popup",
    presets = {
      bottom_search = false,      -- use a classic bottom cmdline for search
      command_palette = false,    -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false,         -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true,      -- add a border to hover docs and signature help
    },
  }
}
