local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity

local opts = {

  debug = false,
  sources = {
    -- formatting.prettier.with({
    --   extra_filetypes = { "toml", 'vue' },
    --   extra_args = { "--single-quote",
    --     '--tab-width', '4' },
    --   filetypes = { "typescript", "typescriptreact", "javascript", "vue", "javascriptreact" },
    -- }),
    formatting.prettier,
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.stylua,
    formatting.clang_format,
    null_ls.builtins.code_actions.eslint,
    -- formatting.google_java_format, diagnostics.flake8,
  }
}

if vim.fn.has "mac" == 1 then
  table.insert(opts,
    formatting.prettier
  )
else
  table.insert(opts,
    formatting.prettierd
  )
end

null_ls.setup(opts)

-- local present, null_ls = pcall(require, "null-ls")
--
-- if not present then
--   return
-- end
--
-- local b = null_ls.builtins
--
-- local sources = {
--   -- Spell
--   b.completion.spell,
--   --b.diagnostics.misspell,
--   -- webdev stuff
--   b.formatting.prettier.with({
--     filetypes = {
--       "javascript",
--       "javascriptreact",
--       "typescript",
--       "typescriptreact",
--       --			"vue",
--       "css",
--       --			"scss",
--       "less",
--       "html",
--       "json",
--       -- "jsonc",
--       -- "yaml",
--       "markdown",
--       -- "graphql",
--       -- "php",
--     },
--     extra_args = { "--double-quote", "--jsx-single-quote", "--single-quote" },
--   }),
--   -- Lua
--   b.formatting.stylua,
--   -- b.diagnostics.luacheck,
--
--   -- Shell
--   b.formatting.shfmt,
--   b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
--
--   -- cpp
--   b.formatting.clang_format,
--
--   -- docker
--   --b.diagnostics.hadolint,
--
--   -- php
--   -- b.formatting.phpcsfixer,
-- }
--
-- null_ls.setup({
--   debug = true,
--   sources = sources,
--   on_attach = function(client)
--     -- if vim.version().major > 7 then
--     if client.server_capabilities.documentFormattingProvider then
--       vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
--       vim.o.laststatus = 3
--     end
--     -- else
--     --   if client.server_capabilities.document_formatting then
--     --     vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
--     --
--     --     vim.o.laststatus = 3
--     --   end
--     -- end
--   end,
-- })
