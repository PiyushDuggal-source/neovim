return {
  "iamcco/markdown-preview.nvim",
  run = "cd app && npm install",
  setup = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
}
