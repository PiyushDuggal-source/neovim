--[[
  init.lua - Neovim Configuration Entry Point
  
  This file loads all configuration modules in the correct order.
  Module organization:
    - user/options.lua     : Vim options (set commands)
    - user/plugins.lua     : Plugin definitions (Packer)
    - user/keymaps.lua     : Key mappings
    - user/lsp/            : Language Server Protocol configuration
    - user/treesitter.lua  : Syntax highlighting
    - user/cmp.lua         : Completion engine
    ...and more
    
  OPTIMIZATION: vim.loader.enable() MUST be first for bytecode caching
--]]

-- =============================================================================
-- PERFORMANCE: Enable Lua byte-code cache FIRST
-- This caches compiled Lua modules for faster subsequent loads
-- MUST be called before any require() statements
-- =============================================================================
vim.loader.enable()

-- =============================================================================
-- CORE CONFIGURATION
-- Load order matters! Options and plugins should come first
-- =============================================================================
require("user.options")           -- Vim settings (tabstop, clipboard, etc.)
require("user.plugins")           -- Plugin manager and plugin list
require("user.keymaps")           -- Key bindings

-- =============================================================================
-- LSP & SYNTAX
-- Language intelligence and syntax highlighting
-- =============================================================================
require("user.lsp")               -- Language Server Protocol setup
require("user.treesitter")        -- Treesitter syntax highlighting
require("user.cmp")               -- Completion engine (nvim-cmp)

-- =============================================================================
-- EDITOR BEHAVIOR
-- Autocommands and automatic features
-- =============================================================================
require("user.autocommands")      -- Auto-commands (format on save, etc.)
require("user.colorscheme")       -- Color scheme configuration
require("user.autopairs")         -- Auto-close brackets/quotes

-- =============================================================================
-- UI COMPONENTS
-- Visual elements and navigation
-- =============================================================================
require("user.telescope-cfg")     -- Fuzzy finder configuration
require("user.gitsigns")          -- Git integration in gutter
require("user.nvim-tree")            -- File explorer
require("user.bufferline")        -- Buffer tabs at top
require("user.lualine")           -- Status line at bottom
require("user.indentline")        -- Indent guides
require("user.alpha")             -- Dashboard / start screen
require("user.illuminate")        -- Highlight word under cursor
require("user.navic")             -- Breadcrumbs in winbar
require("user.winbar")            -- Window bar configuration

-- =============================================================================
-- TERMINAL & PROJECT
-- External tool integration
-- =============================================================================
require("user.toggleterm")        -- Terminal toggle
require("user.project")           -- Project management

-- =============================================================================
-- SNIPPETS & COMPLETION EXTRAS
-- =============================================================================
require("user.luasnip_setup")     -- Snippet engine configuration

-- =============================================================================
-- AI ASSISTANCE
-- =============================================================================
-- require("user.copilot")        -- GitHub Copilot (disabled)
require("user.codeium")           -- Codeium AI completions

-- =============================================================================
-- ADDITIONAL FEATURES
-- =============================================================================
require("user.commands")          -- Custom commands
-- require("user.modicator")      -- Mode-based cursorline (disabled)
require("user.noice")             -- Modern UI for messages/cmdline
require("user.conform")           -- Code formatting
-- require("user.lint")           -- Linting (disabled, using LSP)
-- require("user.notify")         -- Notifications (using noice instead)
-- require("user.research")       -- Research mode (disabled)
require("user.todo-comments")     -- Highlight TODO/FIXME/etc.
-- require("user.trouble")        -- Diagnostics list (disabled)
-- require("user.shade")          -- Dim inactive windows (disabled)
-- require("user.dap")            -- Debugger (disabled)
-- require("user.coqCmp")         -- Coq completion (not using)
require("user.whichKey")          -- Keybinding help popup
-- require("user.import-cost")    -- Show import sizes (disabled)
-- require("user.typescript")     -- Extra TS features (disabled)
-- require("user.tabout")         -- Tab out of brackets (disabled)

-- =============================================================================
-- PLUGIN SETUP CALLS
-- Some plugins need setup() called directly
-- =============================================================================
require("scope").setup()          -- Scope buffers to tabs
require("user.comment")           -- Comment toggling
require("user.colorizer")         -- Color code highlighting
require("user.nvim-ts-autotag")   -- Auto-close HTML tags

-- Pets - fun virtual pet in editor
require("pets").setup({})

-- =============================================================================
-- FINAL SETTINGS
-- Applied after all plugins are loaded
-- =============================================================================

-- Global statusline (single statusline for all windows)
vim.cmd([[:set laststatus=3]])

-- Set colorscheme (after plugins are loaded)
vim.cmd.colorscheme("tokyonight-night")

-- Custom highlight overrides
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = "#6d7493" })
vim.api.nvim_set_hl(0, "IlluminateWordRead", { bg = "#333752" })

-- =============================================================================
-- DISABLED / EXPERIMENTAL
-- =============================================================================
-- vim.cmd(":COQnow --shut-up")   -- Coq completion startup
-- vim.cmd([[:PetsNew newPet]])   -- Create pet on startup
-- require("flirt").setup()      -- Window animations
