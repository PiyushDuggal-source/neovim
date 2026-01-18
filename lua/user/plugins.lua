--[[
  plugins.lua - Packer Plugin Manager Configuration
  
  This file manages all Neovim plugins using Packer.nvim.
  Plugins are organized by category for easier maintenance.
  
  OPTIMIZATION NOTES:
  - Some plugins have been commented out for performance (marked with PERF:)
  - Use `:PackerSync` after making changes to install/update plugins
  - Use `:PackerCompile` to regenerate the compiled loader
--]]

local fn = vim.fn

-- Automatically install packer if not present
-- This enables bootstrapping on a fresh system
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- Uncomment this if you want auto-sync on save (can be slow)
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window for status display
packer.init({
  ensure_dependencies = true,
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
})

-- =============================================================================
-- PLUGIN DEFINITIONS
-- =============================================================================
return packer.startup(function(use)

  -- ===========================================================================
  -- CORE PLUGINS - Essential for basic functionality
  -- ===========================================================================
  
  use({ "wbthomason/packer.nvim" })           -- Have packer manage itself
  use({ "nvim-lua/plenary.nvim" })            -- Useful lua functions used by lots of plugins
  -- use({ "nvim-lua/popup.nvim" })           -- Popup API (legacy, mostly replaced by nui.nvim)
  -- use({ "p00f/nvim-ts-rainbow" })          -- Rainbow parentheses (archived, use ts-rainbow2 if needed)

  -- ===========================================================================
  -- EDITING ENHANCEMENTS
  -- ===========================================================================
  
  use({ "windwp/nvim-autopairs" })            -- Autopairs, integrates with both cmp and treesitter
  use({ "numToStr/Comment.nvim" })            -- Easy commenting with gc/gcc
  use({ "JoosepAlviste/nvim-ts-context-commentstring" }) -- Context-aware commentstring for TSX/JSX
  use({ "kylechui/nvim-surround",             -- Add/change/delete surrounding pairs
    config = function()
      require("nvim-surround").setup()
    end,
  })
  -- use { 'tpope/vim-surround' }             -- Classic surround (using nvim-surround instead)
  use("mg979/vim-visual-multi")               -- Multiple cursors support

  -- ===========================================================================
  -- UI COMPONENTS
  -- ===========================================================================
  
  use({ "kyazdani42/nvim-web-devicons" })     -- File icons (used by many plugins)
  -- use({ "onsails/lspkind.nvim" })          -- VSCode-like pictograms for completions
  use({ "akinsho/bufferline.nvim" })          -- Buffer line (tabs) at the top
  use({ "moll/vim-bbye" })                    -- Better buffer deletion (:Bdelete)
  use({ "nvim-lualine/lualine.nvim" })        -- Statusline at the bottom
  use({ "lukas-reineke/indent-blankline.nvim", -- Indent guides
    commit = "9637670896b68805430e2f72cf5d16be5b97a22a" 
  })
  use({ "echasnovski/mini.indentscope",       -- Animated indent scope indicator
    branch = "stable" 
  })
  use({ "tamton-aquib/flirt.nvim" })          -- Floating window animations

  -- Winbar and navigation breadcrumbs
  use("fgheng/winbar.nvim")
  use({
    "SmiteshP/nvim-navic",                    -- LSP-based breadcrumbs
    requires = "neovim/nvim-lspconfig",
  })

  -- ===========================================================================
  -- DASHBOARD / START SCREEN
  -- ===========================================================================
  
  use("goolord/alpha-nvim")                   -- Modern dashboard on startup
  -- PERF: Commented out - redundant with alpha-nvim
  use("mhinz/vim-startify")                -- Classic start screen (using alpha instead)

  -- ===========================================================================
  -- COLORSCHEMES
  -- ===========================================================================
  
  use("folke/tokyonight.nvim")                -- Primary colorscheme
  use({ "lunarvim/darkplus.nvim" })           -- VSCode-like dark theme
  use({
    "catppuccin/nvim",                        -- Pastel theme with flavours
    as = "catppuccin",
  })
  -- use ({ 'projekt0n/github-nvim-theme' })  -- GitHub theme
  -- use { "cocopon/iceberg.vim" }            -- Blue-ish theme
  -- use { 'Everblush/everblush.vim' }        -- Green-ish theme
  -- use {'fcpg/vim-fahrenheit'}              -- Warm theme

  -- ===========================================================================
  -- COMPLETION (nvim-cmp ecosystem)
  -- ===========================================================================
  
  use({
    "hrsh7th/nvim-cmp",                       -- The core completion plugin
    requires = {
      "Jezda1337/nvim-html-css",              -- HTML/CSS class completions
    },
  })
  use({ "hrsh7th/cmp-buffer" })               -- Buffer word completions
  use({ "hrsh7th/cmp-path" })                 -- Filesystem path completions
  use("David-Kunz/cmp-npm")                   -- npm package completions
  use("hrsh7th/cmp-cmdline")                  -- Command line completions
  use("saadparwaiz1/cmp_luasnip")             -- Snippet completions
  use("hrsh7th/cmp-nvim-lsp")                 -- LSP completions
  use({ "hrsh7th/cmp-nvim-lua", ft = { "lua" } }) -- Neovim Lua API completions
  use({ "Jezda1337/cmp_bootstrap" })          -- Bootstrap class completions
  
  -- Alternative completion engines (not using)
  -- use 'ms-jpq/coq_nvim'                    -- Coq completion (fast but different UX)
  -- use 'ms-jpq/coq.artifacts'
  -- use 'ms-jpq/coq.thirdparty'

  -- ===========================================================================
  -- SNIPPETS
  -- ===========================================================================
  
  use({ "L3MON4D3/LuaSnip" })                 -- Snippet engine
  use({ "rafamadriz/friendly-snippets" })     -- Community snippet collection
  use({ "epilande/vim-react-snippets" })      -- React-specific snippets
  use({ "honza/vim-snippets" })               -- Classic vim snippets

  -- ===========================================================================
  -- LSP (Language Server Protocol)
  -- ===========================================================================
  
  use({ "neovim/nvim-lspconfig" })            -- Core LSP configuration
  -- use({ "williamboman/nvim-lsp-installer" }) -- Deprecated, using mason instead
  use({
    "williamboman/mason.nvim",                -- LSP/DAP/Linter installer
    config = function()
      require("user.lsp.mason")
    end,
  })
  use({ "williamboman/mason-lspconfig.nvim",  -- Bridge between mason and lspconfig
    commit = "1a31f824b9cd5bc6f342fc29e9a53b60d74af245" 
  })
  use({ "mfussenegger/nvim-lint" })           -- Async linters (alternative to null-ls)
  use({ "RRethy/vim-illuminate" })            -- Highlight word under cursor across buffer
  use("lvimuser/lsp-inlayhints.nvim")         -- Inlay hints (for TS types, etc.)
  
  -- Formatting
  use({ "stevearc/conform.nvim" })            -- Modern formatter (replaces null-ls formatting)
  -- use("jose-elias-alvarez/null-ls.nvim")   -- Archived - using conform + nvim-lint instead

  -- ===========================================================================
  -- TELESCOPE (Fuzzy Finder)
  -- ===========================================================================
  
  use({
    "nvim-telescope/telescope.nvim",          -- Core fuzzy finder
  })
  -- OPTIMIZATION: Native fzf for 10-50x faster fuzzy matching
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",  -- Requires make and gcc to compile
  })
  use({ "sharkdp/fd" })                        -- Fast file finder (used by telescope)

  -- ===========================================================================
  -- TREESITTER (Syntax Highlighting & Parsing)
  -- ===========================================================================
  
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",                        -- Auto-update parsers
  })
  use("windwp/nvim-ts-autotag")               -- Auto close/rename HTML tags
  use("David-Kunz/markid")                    -- Highlight matching identifiers

  -- ===========================================================================
  -- FILE EXPLORER
  -- ===========================================================================
  
  -- PERF: Using neo-tree, nvim-tree commented out
  -- use({ "kyazdani42/nvim-tree.lua" })      -- Classic file tree (using neo-tree instead)
  use({
    "nvim-neo-tree/neo-tree.nvim",            -- Modern file explorer with more features
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  })

  -- ===========================================================================
  -- TERMINAL
  -- ===========================================================================
  
  use({ "akinsho/toggleterm.nvim" })          -- Toggle-able terminal windows
  -- PERF: Commented out - redundant with toggleterm
  -- use("voldikss/vim-floaterm")             -- Floating terminal (using toggleterm instead)

  -- ===========================================================================
  -- GIT INTEGRATION
  -- ===========================================================================
  
  use({ "lewis6991/gitsigns.nvim" })          -- Git signs in the gutter + hunk actions

  -- ===========================================================================
  -- NAVIGATION & CODE STRUCTURE
  -- ===========================================================================
  
  use({
    "folke/which-key.nvim",                   -- Keybinding popup helper
  })
  use({
    "stevearc/aerial.nvim",                   -- Code outline / symbol tree
    config = function()
      require("aerial").setup()
    end,
  })
  -- use 'preservim/tagbar'                   -- Classic tagbar (using aerial instead)
  use("rmagatti/goto-preview")                -- Preview definitions in floating window
  use({ "ahmedkhalf/project.nvim" })          -- Project management / auto-cd

  -- ===========================================================================
  -- CODE ACTIONS & DIAGNOSTICS
  -- ===========================================================================
  
  use({
    "aznhe21/actions-preview.nvim",           -- Preview code actions before applying
  })
  -- use({ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" })
  use({
    "folke/todo-comments.nvim",               -- Highlight TODO/FIXME/HACK comments
    requires = "nvim-lua/plenary.nvim",
  })
  -- use({
  --   "folke/trouble.nvim",                  -- Pretty diagnostics list
  --   requires = "kyazdani42/nvim-web-devicons",
  -- })

  -- ===========================================================================
  -- UI ENHANCEMENTS
  -- ===========================================================================
  
  use({
    "folke/noice.nvim",                       -- Redesigned UI for messages, cmdline, popups
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  })
  use("rcarriga/nvim-notify")                 -- Fancy notification popups
  use("MunifTanjim/nui.nvim")                 -- UI component library
  use("stevearc/dressing.nvim")               -- Better vim.ui.select and vim.ui.input
  use({
    "ziontee113/icon-picker.nvim",            -- Emoji/icon picker
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true,
      })
    end,
  })

  -- ===========================================================================
  -- COLOR & VISUAL AIDS
  -- ===========================================================================
  
  use({ "norcalli/nvim-colorizer.lua" })      -- Highlight color codes (#fff, rgb, etc.)
  -- use("xiyaowong/nvim-transparent")        -- Make background transparent
  use("sunjon/Shade.nvim")                    -- Dim inactive windows
  use("mawkler/modicator.nvim")               -- Mode-based cursorline coloring

  -- ===========================================================================
  -- TAB BEHAVIOR
  -- ===========================================================================
  
  use({
    "abecodes/tabout.nvim",                   -- Tab out of brackets/quotes
    config = function()
      require("tabout").setup({
        tabkey = "<Tab>",
        backwards_tabkey = "<S-Tab>",
        act_as_tab = true,
        act_as_shift_tab = false,
        default_tab = "<C-t>",
        default_shift_tab = "<C-d>",
        enable_backwards = true,
        completion = true,
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
        },
        ignore_beginning = true,
        exclude = {},
      })
    end,
    wants = { "nvim-treesitter" },
    after = { "nvim-cmp" },
  })
  use({ "tiagovla/scope.nvim" })              -- Scope buffers to tabs

  -- ===========================================================================
  -- AI ASSISTANTS
  -- ===========================================================================
  
  use({
    "Exafunction/codeium.vim",                -- AI code completion (free alternative to Copilot)
    config = function()
      -- Configure Codeium keybindings in codeium.lua
      -- vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true })
    end,
  })
  -- use("github/copilot.vim")                -- GitHub Copilot (paid)

  -- ===========================================================================
  -- LANGUAGE-SPECIFIC
  -- ===========================================================================
  
  -- TypeScript
  -- use("jose-elias-alvarez/typescript.nvim") -- Extra TS utilities (using ts_ls instead)
  
  -- Java
  use("mfussenegger/nvim-jdtls")              -- Enhanced Java LSP support
  
  -- Markdown
  use({
    "iamcco/markdown-preview.nvim",           -- Live markdown preview in browser
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })
  -- use({ 'toppair/peek.nvim', run = 'deno task --quiet build:fast' })
  
  -- JavaScript REPL
  use({ "metakirby5/codi.vim",                -- Live scratchpad like Quokka.js
    ft = { "javascript", "typescript" } 
  })

  -- ===========================================================================
  -- TESTING (Currently disabled)
  -- ===========================================================================
  
  -- use { 'klen/nvim-test' }
  -- use { 'David-Kunz/jester',
  --   config = function()
  --     require("jester").setup({
  --       cmd = "jest -t '$result' -- $file",
  --       dap = {
  --         console = "externalTerminal"
  --       }
  --     })
  --   end
  -- }

  -- ===========================================================================
  -- DEBUGGING (DAP - Currently disabled)
  -- ===========================================================================
  
  -- use { "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" }
  -- use { "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" }
  -- use { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" }

  -- ===========================================================================
  -- MISC / FUN
  -- ===========================================================================
  
  use({
    "giusgad/pets.nvim",                      -- Virtual pets in your editor!
    requires = {
      "giusgad/hologram.nvim",
      "MunifTanjim/nui.nvim",
    },
  })
  use({ "dstein64/vim-startuptime" })         -- Measure startup time (:StartupTime)
  use({
    "Pocco81/auto-save.nvim",                 -- Automatic file saving
    config = function()
      require("auto-save").setup({
        debounce_delay = 5000,                -- Wait 5 seconds after last edit
      })
    end,
  })
  use({ "mbbill/undotree" })                  -- Visualize undo history
  -- use({ "wakatime/vim-wakatime" })         -- Time tracking

  -- ===========================================================================
  -- END OF PLUGINS
  -- ===========================================================================
  
  -- Automatically set up your configuration after cloning packer.nvim
  -- if PACKER_BOOTSTRAP then
  --   require("packer").sync()
  -- end

end)
