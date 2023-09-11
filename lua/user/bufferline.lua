local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

local M = {}

local icons = require("user.icons")

-- bufferline.setup {
--   options = {
--     close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
--     right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
--     offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
--     separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
--     buffer_close_icon = "",
--     -- buffer_close_icon = '',
--     modified_icon = "●",
--     close_icon = "",
--     -- close_icon = '',
--     left_trunc_marker = "",
--     right_trunc_marker = "",
--     diagnostics = "nvim_lsp",
--     diagnostics_indicator = function(count, level)
--       local icon = level:match("error") and " " or ""
--       return " " .. icon .. " " .. count
--     end
--   },
-- }

function M.buf_kill(kill_command, bufnr, force)
  kill_command = kill_command or "bd"

  local bo = vim.bo
  local api = vim.api
  local fmt = string.format
  local fn = vim.fn

  if bufnr == 0 or bufnr == nil then
    bufnr = api.nvim_get_current_buf()
  end

  local bufname = api.nvim_buf_get_name(bufnr)

  if not force then
    local choice
    if bo[bufnr].modified then
      choice = fn.confirm(fmt([[Save changes to "%s"?]], bufname), "&Yes\n&No\n&Cancel")
      if choice == 1 then
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd("w")
        end)
      elseif choice == 2 then
        force = true
      else
        return
      end
    elseif api.nvim_buf_get_option(bufnr, "buftype") == "terminal" then
      choice = fn.confirm(fmt([[Close "%s"?]], bufname), "&Yes\n&No\n&Cancel")
      if choice == 1 then
        force = true
      else
        return
      end
    end
  end

  -- Get list of windows IDs with the buffer to close
  local windows = vim.tbl_filter(function(win)
    return api.nvim_win_get_buf(win) == bufnr
  end, api.nvim_list_wins())

  if force then
    kill_command = kill_command .. "!"
  end

  -- Get list of active buffers
  local buffers = vim.tbl_filter(function(buf)
    return api.nvim_buf_is_valid(buf) and bo[buf].buflisted
  end, api.nvim_list_bufs())

  -- If there is only one buffer (which has to be the current one), vim will
  -- create a new buffer on :bd.
  -- For more than one buffer, pick the previous buffer (wrapping around if necessary)
  if #buffers > 1 and #windows > 0 then
    for i, v in ipairs(buffers) do
      if v == bufnr then
        local prev_buf_idx = i == 1 and #buffers or (i - 1)
        local prev_buffer = buffers[prev_buf_idx]
        for _, win in ipairs(windows) do
          api.nvim_win_set_buf(win, prev_buffer)
        end
      end
    end
  end

  -- Check if buffer still exists, to ensure the target buffer wasn't killed
  -- due to options like bufhidden=wipe.
  if api.nvim_buf_is_valid(bufnr) and bo[bufnr].buflisted then
    vim.cmd(string.format("%s %d", kill_command, bufnr))
  end
end

local bufferlineOptions = {
  active = true,
  on_config_done = nil,
  keymap = {
    normal_mode = {},
  },
  highlights = {
    background = {
      italic = true,
    },
    buffer_selected = {
      bold = true,
    },
  },
  options = {
    mode = "buffers",               -- set to "tabs" to only show tabpages instead
    numbers = "none",               -- can be "none" | "ordinal" | "buffer_id" | "both" | function
    close_command = function(bufnr) -- can be a string | function, see "Mouse actions"
      M.buf_kill("bd", bufnr, false)
    end,
    right_mouse_command = "vert sbuffer %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d",        -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil,              -- can be a string | function, see "Mouse actions"
    indicator = {
      icon = icons.ui.BoldLineLeft,          -- this should be omitted if indicator style is not 'icon'
      style = "icon",                        -- can also be 'underline'|'none',
    },
    buffer_close_icon = icons.ui.Close,
    modified_icon = icons.ui.Circle,
    close_icon = icons.ui.BoldClose,
    left_trunc_marker = icons.ui.ArrowCircleLeft,
    right_trunc_marker = icons.ui.ArrowCircleRight,
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      if buf.name:match "%.md" then
        return vim.fn.fnamemodify(buf.name, ":t:r")
      end
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    truncate_names = true,  -- whether or not tab names should be truncated
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = diagnostics_indicator,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = custom_filter,
    offsets = {
      {
        filetype = "undotree",
        text = "Undotree",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "NvimTree",
        text = "Explorer",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "DiffviewFiles",
        text = "Diff View",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "flutterToolsOutline",
        text = "Flutter Outline",
        highlight = "PanelHeading",
      },
      {
        filetype = "lazy",
        text = "Lazy",
        highlight = "PanelHeading",
        padding = 1,
      },
    },
    color_icons = true, -- whether or not to add the filetype icon highlights
    -- show_buffer_icons = use_icons,   -- disable filetype icons for buffers
    -- show_buffer_close_icons = use_icons,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "thin",
    enforce_regular_tabs = false,
    always_show_bufferline = false,
    hover = {
      enabled = true, -- requires nvim 0.8+
      delay = 200,
      reveal = { "close" },
    },
    sort_by = "id",
  },
}

bufferline.setup {
  options = bufferlineOptions.options,
  highlights = bufferlineOptions.highlights
}
