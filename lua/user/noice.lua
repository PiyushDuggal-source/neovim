local present, noice = pcall(require, "noice")

if not present then
  return
end

noice.setup({
  --cmdline = {
  --	enabled = false, -- disable if you use native command line UI
  --	view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
  --	--opts = { buf_options = { filetype = "lua" } }, -- enable syntax highlighting in the cmdline
  --  opts = {},
  --	icons = {
  --		["/"] = { icon = " ", hl_group = "DiagnosticWarn" },
  --		["?"] = { icon = " ", hl_group = "DiagnosticWarn" },
  --		[":"] = { icon = " ", hl_group = "DiagnosticInfo", firstc = false },
  --	},
  --},
  enabled = true, -- enables the Noice cmdline UI
  view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
  opts = { buf_options = { filetype = "lua" } }, -- enable syntax highlighting in the cmdline

  -- -@type table<string, CmdlineFormat>
  format = {
    -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
    -- view: (default is cmdline view)
    -- opts: any options passed to the view
    -- icon_hl_group: optional hl_group for the icon
    -- title: set to anything or empty string to hide
    icons = {
      ["/"] = { icon = " ", hl_group = "DiagnosticWarn" },
      ["?"] = { icon = " ", hl_group = "DiagnosticWarn" },
      [":"] = { icon = " ", hl_group = "DiagnosticInfo", firstc = false },
    },
    --     cmdline = { pattern = "^:", icon = "", lang = "vim" },
    --     search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
    --     search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
    --     filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
    --     lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
    --     help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
    --     input = {}, -- Used by input()
    --      -- lua = false, -- to disable a format, set to `false`
  },
  messages = {
    -- NOTE: If you enable noice messages UI, noice cmdline UI is enabled
    -- automatically. You cannot enable noice messages UI only.
    -- It is current neovim implementation limitation.  It may be fixed later.
    enabled = false, -- disable if you use native messages UI
  },
  popupmenu = {
    enabled = true, -- disable if you use something like cmp-cmdline
    ---@type 'nui'|'cmp'
    backend = "cmp", -- backend to use to show regular cmdline completions
    -- You can specify options for nui under `config.views.popupmenu`
  },
  history = {
    -- options for the message history that you get with `:Noice`
    view = "split",
    opts = { enter = true },
    filter = { event = "msg_show", ["not"] = { kind = { "search_count", "echo" } } },
  },
  notify = {
    -- Noice can be used as `vim.notify` so you can route any notification like other messages
    -- Notification messages have their level and other properties set.
    -- event is always "notify" and kind can be any log level as a string
    -- The default routes will forward notifications to nvim-notify
    -- Benefit of using Noice for this is the routing and consistent history view
    enabled = false,
  },
  hacks = {
    -- due to https://github.com/neovim/neovim/issues/20416
    -- messages are resent during a redraw. Noice detects this in most cases, but
    -- some plugins (mostly vim plugns), can still cause loops.
    -- When a loop is detected, Noice exits.
    -- Enable this option to simply skip duplicate messages instead.
    skip_duplicate_messages = false,
  },
  throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
  --	---@type table<string, NoiceViewOptions>
  --	views = {}, -- @see the section on views below
  --	---@type NoiceRouteConfig[]
  --	routes = {}, -- @see the section on routes below
  --	---@type table<string, NoiceFilter>
  --	status = {}, --@see the section on statusline components below
  --	---@type NoiceFormatOptions
  --	format = {}, -- @see section on formatting
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = false, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})
