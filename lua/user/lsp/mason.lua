local servers = {
  "cssls",
  "html",
  "clangd",
  "lua_ls",
  "tsserver",
  -- "vue-language-server",
  "pyright",
  "bashls",
  "jdtls",
  "jsonls",
  "cssls",
  -- "intelephense",
  "phpactor",
  -- "yamlls",
}


-- -- local coq = require "coq"

-- local settings = {
--   ui = {
--     border = "none",
--     icons = {
--       package_installed = "◍",
--       package_pending = "◍",
--       package_uninstalled = "◍",
--     },
--   },
--   log_level = vim.log.levels.INFO,
--   max_concurrent_installers = 4,
-- }

-- require("mason").setup(settings)
-- -- require("mason-lspconfig").setup(coq.lsp_ensure_capabilities({
-- require("mason-lspconfig").setup({
--   ensure_installed = servers,
--   automatic_installation = true,
-- })

-- local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
-- if not lspconfig_status_ok then
--   return
-- end
-- local opts = {}

-- for _, server in pairs(servers) do
--   opts = {
--     on_attach = require("user.lsp.handlers").on_attach,
--     capabilities = require("user.lsp.handlers").capabilities,
--   }

--   server = vim.split(server, "@")[1]

--   local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
--   if require_ok then
--     opts = vim.tbl_deep_extend("force", conf_opts, opts)
--   end
--   -- lspconfig[server].setup(coq.lsp_ensure_capabilities(opts))
--   lspconfig[server].setup(opts)
-- end

local present, mason = pcall(require, "mason")

if not present then
  print("mason not found")
  return
end

vim.api.nvim_create_augroup("_mason", { clear = true })

local options = {
  -- ensure_installed = "all",
  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ﮊ",
    },
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },
  max_concurrent_installers = 10,
}

mason.setup(options)

--require("mason").setup(settings)
-- require("mason-lspconfig").setup(coq.lsp_ensure_capabilities({

local mConf = {

  ensure_installed = {
    "bashls",
    "clangd",
    "cssls",
    "html",
    "jsonls",
    "lua_ls",
    "pyright",
    -- "tsserver",
    "jdtls",
    "cmake",
    "cssmodules_ls",
    "dockerls",
    "phpactor",
    -- "intelephense",
    "eslint",
    -- "marksman",
    "sqlls",
    -- "vuels",
    "tailwindcss",
  },
  automatic_installation = true,
}


-- Check if Go is executable and add gopls if it is
if vim.fn.executable("go") == 1 then
  print("inserting")
  table.insert(servers, "gopls")
  table.insert(mConf.ensure_installed, "gopls")
end

require("mason-lspconfig").setup(mConf)

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end
local opts = {}

for _, server in pairs(servers) do
  -- WARN: Temp fix
  if server == "tsserver" then
    server = "ts_ls"
  end
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end
  -- lspconfig[server].setup(coq.lsp_ensure_capabilities(opts))
  lspconfig[server].setup(opts)
end
--options = require("core.utils").load_override(options, "williamboman/mason.nvim")

--vim.api.nvim_create_user_command("MasonInstallAll", function()
--  vim.cmd("MasonInstall " .. table.concat(options.ensure_installed, " "))
--end, {})
