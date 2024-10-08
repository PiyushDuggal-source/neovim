-- local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
-- if not status_ok then
--   return
-- end
-- -- local coq = require "coq"
--
-- -- Register a handler that will be called for all installed servers.
-- -- Alternatively, you may also register handlers on specific server instances instead (see example below).
-- lsp_installer.on_server_ready(function(server)
--   local opts = {
--     on_attach = require("user.lsp.handlers").on_attach,
--     capabilities = require("user.lsp.handlers").capabilities,
--   }
--
--   if server.name == "jsonls" then
--     local jsonls_opts = require("user.lsp.settings.jsonls")
--     opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
--   end
--
--   if server.name == "sumneko_lua" then
--     local sumneko_opts = require("user.lsp.settings.sumneko_lua")
--     opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
--   end
--
--   if server.name == "pyright" then
--     local pyright_opts = require("user.lsp.settings.pyright")
--     opts = vim.tbl_deep_extend("force", pyright_opts, opts)
--   end
--
--   -- This setup() function is exactly the same as lspconfig's setup function.
--   -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--   -- server:setup(coq.lsp_ensure_capabilities(opts))
--   server:setup(opts)
-- end)

-- local on_attach = require("user.lsp.handlers").on_attach
-- local capabilities = require("user.lsp.handlers").capabilities

require("user.lsp.handlers").setup()
-- local typescript_setup, typescript = pcall(require, "typescript")
-- if not typescript_setup then
-- 	return
-- end

-- local lspconfig = require("lspconfig")
-- local servers = {
-- 	"cssls",
-- 	-- "emmet_ls",
-- 	"clangd",
-- 	"lua_ls",
-- 	"eslint",
-- 	-- "gopls",
-- 	"pyright",
-- 	"html",
-- 	"bashls",
-- 	"cssmodules_ls",
-- 	"jsonls",
-- 	"gopls",
-- 	"volar",
-- 	"yamlls",
-- 	-- "vuels",
-- 	"tailwindcss",
-- 	"cssls",
-- 	-- "intelephense",
-- 	"phpactor",
-- 	-- "dockerls",
-- }
-- local lspInlays = { "tsserver" }
-- capabilities.textDocument.foldingRange = {
-- 	dynamicRegistration = false,
-- 	lineFoldingOnly = true,
-- }
-- for _, lsp in ipairs(servers) do
-- 	lspconfig[lsp].setup({
-- 		on_attach = on_attach,
-- 		capabilities = capabilities,
-- 		handlers = {
-- 			["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 				-- Disable virtual_text
-- 				virtual_text = false,
-- 			}),
-- 		},
-- 		settings = {
-- 			Lua = {
-- 				diagnostics = {
-- 					-- Get the language server to recognize the `vim` global
-- 					globals = { "vim" },
-- 				},
-- 			},
-- 		},
-- 	})
-- end
--
-- lspconfig.volar.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	handlers = {
-- 		["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 			-- Disable virtual_text
-- 			virtual_text = false,
-- 		}),
-- 	},
-- 	filetypes = { "php" },
-- })
-- lspconfig.pyright.setup({
-- 	on_attach = on_attach,
-- 	settings = {
-- 		python = {
-- 			analysis = {
-- 				typeCheckingMode = "off",
-- 			},
-- 			files = {
-- 				"python",
-- 			},
-- 		},
-- 	},
-- })
--
-- -- lspconfig.intelephense.setup {
-- --
-- --   on_attach = on_attach,
-- --   capabilities = capabilities,
-- --   handlers = {
-- --     ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- --       -- Disable virtual_text
-- --       virtual_text = false,
-- --     }),
-- --   },
-- --   filetypes = { 'php' }
-- -- }
--
-- for _, lsp in ipairs(lspInlays) do
-- 	lspconfig[lsp].setup({
-- 		on_attach = function(client, bufnr)
-- 			on_attach(client, bufnr)
--
-- 			require("lsp-inlayhints").on_attach(client, bufnr)
-- 		end,
--
-- 		handlers = {
-- 			["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 				-- Disable virtual_text
-- 				virtual_text = false,
-- 			}),
-- 		},
-- 		capabilities = capabilities,
-- 		settings = {
-- 			typescript = {
-- 				inlayHints = {
-- 					includeInlayParameterNameHints = "all",
-- 					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
-- 					includeInlayFunctionParameterTypeHints = true,
-- 					includeInlayVariableTypeHints = true,
-- 					includeInlayPropertyDeclarationTypeHints = true,
-- 					includeInlayFunctionLikeReturnTypeHints = true,
-- 					includeInlayEnumMemberValueHints = true,
-- 				},
-- 			},
-- 			javascript = {
-- 				inlayHints = {
-- 					includeInlayParameterNameHints = "all",
-- 					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
-- 					includeInlayFunctionParameterTypeHints = true,
-- 					includeInlayVariableTypeHints = true,
-- 					includeInlayPropertyDeclarationTypeHints = true,
-- 					includeInlayFunctionLikeReturnTypeHints = true,
-- 					includeInlayEnumMemberValueHints = true,
-- 				},
-- 			},
-- 		},
-- 	})
-- end

-- lspconfig["emmet_ls"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
-- })
