local create_cmd = vim.api.nvim_create_user_command

create_cmd("EnableShade", function()
  require("shade").setup()
end, {})

create_cmd("SearchIssue", function()
  require("user.research").MenuBrowser()
end, {})
