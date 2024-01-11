return  {
      'mhartington/formatter.nvim',
      config = function()
        local formatter_prettier = { require('formatter.defaults.prettier') }
        require("formatter").setup({
          filetype = {
            javascript      = formatter_prettier,
            javascriptreact = formatter_prettier,
            typescript      = formatter_prettier,
            typescriptreact = formatter_prettier,
          }
        })
        -- -- automatically format buffer before writing to disk:
        -- vim.api.nvim_create_augroup('BufWritePreFormatter', {})
        -- vim.api.nvim_create_autocmd('BufWritePre', {
        --   command = 'FormatWrite',
        --   group = 'BufWritePreFormatter',
        --   pattern = { '*.js', '*.jsx', '*.ts', '*.tsx' },
        -- })
      end,
      ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    }
