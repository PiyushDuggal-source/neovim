local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local icons = require("user.icons")

local setup = {
  plugins = {
    marks = true,       -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false,      -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true,       -- default bindings on <c-w>
      nav = true,           -- misc bindings to work with windows
      z = true,             -- bindings for folds, spelling and others prefixed with z
      g = true,             -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  -- key_labels = {
  -- 	-- override the label used to display some keys. It doesn't effect WK in any other way.
  -- 	-- For example:
  -- 	-- ["<space>"] = "SPC",
  -- 	-- ["<cr>"] = "RET",
  -- 	-- ["<tab>"] = "TAB",
  -- },
  icons = {
    -- breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    -- separator = "➜", -- symbol used between a key and it's label
    -- group = "+", -- symbol prepended to a group
    breadcrumb = icons.ui.DoubleChevronRight, -- symbol used in the command line area that shows your active key combo
    separator = icons.ui.BoldArrowRight,      -- symbol used between a key and it's label
    group = icons.ui.Plus,                    -- symbol prepended to a group
  },
  keys = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>",   -- binding to scroll up inside the popup
  },
  win = {
    -- don't allow the popup to overlap with the cursor
    no_overlap = true,
    -- width = 1,
    height = { min = 4, max = 25 },
    -- col = 4,
    -- row = math.huge,
    border = "rounded", -- none, single, double, shadow
    padding = { 2, 2 }, -- extra window padding [top/bottom, right/left]
    title = true,
    title_pos = "center",
    zindex = 1000,
    -- Additional vim.wo and vim.bo options
    bo = {},
    wo = {
      winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
    },
  },
  -- win = {
  -- border = "rounded", -- none, single, double, shadow
  -- position = "bottom", -- bottom, top
  -- margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
  -- padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  -- winblend = 0,
  -- },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3,                    -- spacing between columns
    align = "left",                 -- align columns left, center or right
  },
  show_help = true,                 -- show help message on the command line when the popup is visible
  triggers = { "<leader>" },        -- or specify a list manually
}

local opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

local mappingsV3 = {

  {
    "<leader>a",
    "<cmd>Alpha<cr>",
    desc = "Alpha",
  },
  {
    "<leader>b",
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    desc = "Buffers",
  },
  {
    "<leader>e",
    "<cmd>Neotree toggle<cr>",
    desc = "Explorer",
  },
  {
    "<leader>w",
    "<cmd>w!<CR>",
    desc = "Save",
  },
  {
    "<leader>q",
    "<cmd>q!<CR>",
    desc = "Quit",
  },
  {
    "<leader>/",
    "<cmd>lua require('Comment').toggle()<CR>",
    desc = "Comment",
  },
  {
    "<leader>c",
    "<cmd>lua require('actions-preview').code_actions()<CR>",
    desc = "Code Action",
  },
  {
    "<leader>h",
    "<cmd>nohlsearch<CR>",
    desc = "No Highlight",
  },
  {
    "<leader>P",
    ":lua require('telescope').extensions.projects.projects()<CR>",
    desc = "Projects",
  },
  {
    "<leader>f",
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({}))<cr>",
    desc = "Find files",
  },

  -- Find group
  { "<leader>F", group = "Find" },
  {
    "<leader>Ff",
    "<cmd>Telescope find_files<cr>",
    desc = "Find files",
  },
  {
    "<leader>FF",
    "<cmd>Telescope live_grep theme=ivy<cr>",
    desc = "Find Text",
  },
  {
    "<leader>Fb",
    "<cmd>Telescope git_branches<cr>",
    desc = "Checkout branch",
  },
  {
    "<leader>Fc",
    "<cmd>Telescope colorscheme<cr>",
    desc = "Colorscheme",
  },
  {
    "<leader>FP",
    "<cmd>Telescope projects<cr>",
    desc = "Projects",
  },
  {
    "<leader>Fs",
    "<cmd>Telescope grep_string<cr>",
    desc = "Find String",
  },
  {
    "<leader>Fh",
    "<cmd>Telescope help_tags<cr>",
    desc = "Help",
  },
  {
    "<leader>FH",
    "<cmd>Telescope highlights<cr>",
    desc = "Highlights",
  },
  {
    "<leader>Fi",
    "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>",
    desc = "Media",
  },
  {
    "<leader>Fl",
    "<cmd>Telescope resume<cr>",
    desc = "Last Search",
  },
  {
    "<leader>FM",
    "<cmd>Telescope man_pages<cr>",
    desc = "Man Pages",
  },
  {
    "<leader>Fr",
    "<cmd>Telescope oldfiles<cr>",
    desc = "Recent File",
  },
  {
    "<leader>FR",
    "<cmd>Telescope registers<cr>",
    desc = "Registers",
  },
  {
    "<leader>Fk",
    "<cmd>Telescope keymaps<cr>",
    desc = "Keymaps",
  },
  {
    "<leader>FC",
    "<cmd>Telescope commands<cr>",
    desc = "Commands",
  },

  -- Packer group
  { "<leader>p", group = "Packer" },
  {
    "<leader>pc",
    "<cmd>PackerCompile<cr>",
    desc = "Compile",
  },
  {
    "<leader>pi",
    "<cmd>PackerInstall<cr>",
    desc = "Install",
  },
  {
    "<leader>ps",
    "<cmd>PackerSync<cr>",
    desc = "Sync",
  },
  {
    "<leader>pS",
    "<cmd>PackerStatus<cr>",
    desc = "Status",
  },
  {
    "<leader>pu",
    "<cmd>PackerUpdate<cr>",
    desc = "Update",
  },

  -- Git group
  { "<leader>g", group = "Git" },
  {
    "<leader>gg",
    "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
    desc = "Lazygit",
  },
  {
    "<leader>gj",
    "<cmd>lua require 'gitsigns'.next_hunk()<cr>",
    desc = "Next Hunk",
  },
  {
    "<leader>gk",
    "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
    desc = "Prev Hunk",
  },
  {
    "<leader>gl",
    "<cmd>lua require 'gitsigns'.blame_line()<cr>",
    desc = "Blame",
  },
  {
    "<leader>gp",
    "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
    desc = "Preview Hunk",
  },
  {
    "<leader>gr",
    "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
    desc = "Reset Hunk",
  },
  {
    "<leader>gR",
    "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
    desc = "Reset Buffer",
  },
  {
    "<leader>gs",
    "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
    desc = "Stage Hunk",
  },
  {
    "<leader>gu",
    "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
    desc = "Undo Stage Hunk",
  },
  {
    "<leader>go",
    "<cmd>Telescope git_status<cr>",
    desc = "Open changed file",
  },
  {
    "<leader>gb",
    "<cmd>Telescope git_branches<cr>",
    desc = "Checkout branch",
  },
  {
    "<leader>gc",
    "<cmd>Telescope git_commits<cr>",
    desc = "Checkout commit",
  },
  {
    "<leader>gd",
    "<cmd>Gitsigns diffthis HEAD<cr>",
    desc = "Diff",
  },

  -- LSP group
  { "<leader>l", group = "LSP" },
  {
    "<leader>la",
    "<cmd>lua vim.lsp.buf.code_action()<cr>",
    desc = "Code Action",
  },
  {
    "<leader>ld",
    "<cmd>Telescope lsp_document_diagnostics<cr>",
    desc = "Document Diagnostics",
  },
  {
    "<leader>lw",
    "<cmd>Telescope lsp_workspace_diagnostics<cr>",
    desc = "Workspace Diagnostics",
  },
  {
    "<leader>lf",
    function()
      print("Key mapping triggered")
      -- require('conform').format({ async = true })
    end,
    desc = "Format (Conform)",
  },
  -- {
  -- 	"<leader>lf",
  -- 	"<cmd>lua vim.lsp.buf.format({async = true})<cr>",
  -- 	desc = "Format",
  -- },
  {
    "<leader>li",
    "<cmd>LspInfo<cr>",
    desc = "Info",
  },
  {
    "<leader>lI",
    "<cmd>LspInstallInfo<cr>",
    desc = "Installer Info",
  },
  {
    "<leader>lj",
    "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
    desc = "Next Diagnostic",
  },
  {
    "<leader>lk",
    "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
    desc = "Prev Diagnostic",
  },
  {
    "<leader>ll",
    "<cmd>lua vim.lsp.codelens.run()<cr>",
    desc = "CodeLens Action",
  },
  {
    "<leader>lq",
    "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>",
    desc = "Quickfix",
  },
  {
    "<leader>lr",
    "<cmd>lua vim.lsp.buf.rename()<cr>",
    desc = "Rename",
  },
  {
    "<leader>ls",
    "<cmd>Telescope lsp_document_symbols<cr>",
    desc = "Document Symbols",
  },
  {
    "<leader>lS",
    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    desc = "Workspace Symbols",
  },

  -- Search group
  { "<leader>s", group = "Search" },
  {
    "<leader>sb",
    "<cmd>Telescope git_branches<cr>",
    desc = "Checkout branch",
  },
  {
    "<leader>sc",
    "<cmd>Telescope colorscheme<cr>",
    desc = "Colorscheme",
  },
  {
    "<leader>sh",
    "<cmd>Telescope help_tags<cr>",
    desc = "Find Help",
  },
  {
    "<leader>sM",
    "<cmd>Telescope man_pages<cr>",
    desc = "Man Pages",
  },
  {
    "<leader>sr",
    "<cmd>Telescope oldfiles<cr>",
    desc = "Open Recent File",
  },
  {
    "<leader>sR",
    "<cmd>Telescope registers<cr>",
    desc = "Registers",
  },
  {
    "<leader>sk",
    "<cmd>Telescope keymaps<cr>",
    desc = "Keymaps",
  },
  {
    "<leader>sC",
    "<cmd>Telescope commands<cr>",
    desc = "Commands",
  },

  -- Terminal group
  { "<leader>t", group = "Terminal" },
  {
    "<leader>tn",
    "<cmd>lua _NODE_TOGGLE()<cr>",
    desc = "Node",
  },
  {
    "<leader>tu",
    "<cmd>lua _NCDU_TOGGLE()<cr>",
    desc = "NCDU",
  },
  {
    "<leader>tt",
    "<cmd>:ToggleTermToggleAll<cr>",
    desc = "Htop",
  },
  {
    "<leader>tp",
    "<cmd>lua _PYTHON_TOGGLE()<cr>",
    desc = "Python",
  },
  {
    "<leader>tf",
    "<cmd>ToggleTerm direction=float<cr>",
    desc = "Float",
  },
  {
    "<leader>th",
    "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
    desc = "Horizontal",
  },
  {
    "<leader>tv",
    "<cmd>ToggleTerm size=80 direction=vertical<cr>",
    desc = "Vertical",
  },
}

local mappings = {
  ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Buffers",
  },
  -- ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["e"] = { "<cmd>Neotree toggle<cr>", "Explorer" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["/"] = { "<cmd>lua require('Comment').toggle()<CR>", "Comment" },
  ["c"] = { "<cmd>lua require('actions-preview').code_actions()<CR>", "Code Action" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["P"] = { ":lua require('telescope').extensions.projects.projects()<CR>", "Projects" },
  -- ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  ["f"] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({}))<cr>",
    "Find files",
  },
  -- f = {
  --   f = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
  --     "Find files", },
  --   F =  { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  -- },
  F = {
    name = "Find",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    F = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
    f = { "<cmd>Telescope find_files<cr>", "Find files" },
    P = { "<cmd>Telescope projects<cr>", "Projects" },
    s = { "<cmd>Telescope grep_string<cr>", "Find String" },
    h = { "<cmd>Telescope help_tags<cr>", "Help" },
    H = { "<cmd>Telescope highlights<cr>", "Highlights" },
    i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
    l = { "<cmd>Telescope resume<cr>", "Last Search" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Instaliler Info" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },

  t = {
    name = "Terminal",
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>:ToggleTermToggleAll<cr>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },

  -- j = {
  -- j = { "<cmd>:TestSuite<cr>", "This line Test" }
  --   }
}

--local vopts = {
--mode = "v", -- VISUAL mode
--prefix = "<leader>",
--buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--silent = true, -- use `silent` when creating keymaps
--noremap = true, -- use `noremap` when creating keymaps
--nowait = true, -- use `nowait` when creating keymaps
--}
--local vmappings = {
--["/"] = { "<ESC><CMD>lua require('Comment.api').gc(vim.fn.visualmode())<CR>", "Comment" },
--}

which_key.setup(setup)
-- which_key.register(mappings, opts)
which_key.add(mappingsV3, opts)
--which_key.register(vmappings, vopts)
