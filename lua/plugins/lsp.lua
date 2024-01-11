return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = false
    },

    servers = {
      eslint = {},
      intelephense = {
        filetypes = { "php", "blade" },
        settings = {
          intelephense = {
            filetypes = { "php", "blade" },
            files = {
              associations = { "*.php", "*.blade.php" },   -- Associating .blade.php files as well
              maxSize = 5000000, },
          },
        },
      },
    },
    setup = {
      eslint = function()
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
    },
  }
}
