return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", 'use', 'bit' },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
