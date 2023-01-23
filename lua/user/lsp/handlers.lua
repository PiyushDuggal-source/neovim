-- local M = {}
-- local navic = require("nvim-navic")
-- M.setup = function()
--   local signs = {
--     { name = "DiagnosticSignError", text = "" },
--     { name = "DiagnosticSignWarn", text = "" },
--     { name = "DiagnosticSignHint", text = "" },
--     { name = "DiagnosticSignInfo", text = "" },
--   }
--   for _, sign in ipairs(signs) do
--     vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
--   end
--
--   local config = {
--     virtual_text = false, -- disable virtual text
--     signs = {
--       active = signs, -- show signs
--     },
--     update_in_insert = false,
--     underline = true,
--     severity_sort = false,
--     float = {
--       focusable = true,
--       style = "minimal",
--       border = "rounded",
--       source = "always",
--       header = "diagnostic",
--       prefix = "",
--     },
--   }
--
--   vim.diagnostic.config(config)
--
--   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--     border = "rounded",
--   })
--
--   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
--     border = "rounded", })
-- end
--
-- -- local function lsp_highlight_document(client)
-- --   -- Set autocommands conditional on server_capabilities
-- --   if client.server_capabilities.document_highlight then
-- --     vim.api.nvim_exec(
-- --       [[
-- --       augroup lsp_document_highlight
-- --       autocmd! * <buffer>
-- --       autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
-- --       autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
-- --       augroup END
-- --       ]],
-- --       false
-- --     )
-- --   end
-- -- end
--
-- local function lsp_keymaps(bufnr)
--   local opts = { noremap = true, silent = true }
--   local keymap = vim.api.nvim_buf_set_keymap
--   keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--   keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
--   keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
--   keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--   keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
--   keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float({border= 'rounded' })<CR>", opts)
--   keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
--   keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
--   keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
--   keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
--   keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
--   keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
--   keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
--   keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
--   keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
-- end
--
-- M.on_attach = function(client, bufnr)
--   if client.name == "tsserver" then
--     client.server_capabilities.document_formatting = true
--   end
--   lsp_keymaps(bufnr)
--   -- lsp_highlight_document(client)
-- if client.server_capabilities.documentSymbolProvider then
--         navic.attach(client, bufnr)
--     end
--
--   if client.name == "sumneko_lua" then
--     client.server_capabilities.document_formatting = false
--   end
--
--   M.capabilities = vim.lsp.protocol.make_client_capabilities()
--   local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
--   if not status_cmp_ok then
--     return
--   end
--   M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
--   M.capabilities.textDocument.completion.completionItem.snippetSupport = true
--
--   lsp_keymaps(bufnr)
--   local status_ok, illuminate = pcall(require, "illuminate")
--   if not status_ok then
--     return
--   end
--   illuminate.on_attach(client)
-- end
--
-- return M

local present, lspconfig = pcall(require, "lspconfig")

local navic = require("nvim-navic")
if not present then
	return
end

local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = false, -- disable virtual text
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "diagnostic",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float({border= 'rounded' })<CR>", opts)
	keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
	keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
	keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
	keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end
-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)
	if vim.version().major > 7 then
		-- nightly
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	else
		-- stable
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false
	end
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

lspconfig.sumneko_lua.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,

	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})

return M
