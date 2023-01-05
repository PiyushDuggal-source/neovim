local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins
  use { "nvim-lua/popup.nvim" }
  use { "p00f/nvim-ts-rainbow" }
  -- use { "nvim-telescope/telescope-media-files.nvim" }
  use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim" }
  use { "JoosepAlviste/nvim-ts-context-commentstring" }
  use { "kyazdani42/nvim-web-devicons" }
  use { "kyazdani42/nvim-tree.lua" }
  use { "akinsho/bufferline.nvim" }
  use { "moll/vim-bbye" }
  use { "nvim-lualine/lualine.nvim" }
  use { "akinsho/toggleterm.nvim" }
  use { "ahmedkhalf/project.nvim" }
  -- use { 'nvim-telescope/telescope-project.nvim' }
  use { "lewis6991/impatient.nvim" }
  use { "lukas-reineke/indent-blankline.nvim" }
  use { "goolord/alpha-nvim" }

  -- Colorschemesq
  -- use { "folke/tokyonight.nvim", commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" }
  use { "lunarvim/darkplus.nvim" }
  use {
    "catppuccin/nvim",
    as = "catppuccin", }

  -- cmp plugins
  -- use { "hrsh7th/nvim-cmp"} -- The completion plugin
  -- use { "hrsh7th/cmp-buffer"} -- buffer completions
  -- use { "hrsh7th/cmp-path"} -- path completions
  -- use { "hrsh7th/cmp-vsnip"}
  -- use { "hrsh7th/vim-vsnip"}
  -- use { "saadparwaiz1/cmp_luasnip"} -- snippet completions
  -- use { "hrsh7th/cmp-nvim-lsp"}
  -- use { "hrsh7th/cmp-nvim-lua"}

  use "christianchiarulli/nvim-cmp"
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-emoji"
  use { "hrsh7th/cmp-nvim-lua", ft = { "lua" } }
  use 'ms-jpq/coq_nvim'
  use 'ms-jpq/coq.artifacts'
  -- use 'ms-jpq/coq.thirdparty'

  -- snippets
  use { "L3MON4D3/LuaSnip" } --snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

  -- LSP
  use { "williamboman/nvim-lsp-installer" } -- simple to use language server installer
  use { "neovim/nvim-lspconfig" } -- enable LSP
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }
  use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
  use { "RRethy/vim-illuminate" }
  -- use { "ms-jpq/coq_nvim" }
  -- use {
  --   "ray-x/lsp_signature.nvim",
  --   requires = {
  --     {
  --       "kosayoda/nvim-lightbulb",
  --       config = function()
  --         vim.api.nvim_command("highlight LightBulbVirtualText guifg=red")
  --       end
  --     },
  --     "nvim-lua/lsp-status.nvim",
  --     { "ojroques/nvim-lspfuzzy", config = require "lspfuzzy".setup {} },
  --     {
  --       "ray-x/lsp_signature.nvim",
  --       config = function()
  --         require "lsp_signature".on_attach()
  --       end
  --     }
  --   }
  -- }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim'
  }
  -- Treesitter
  use { "sharkdp/fd" }
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }

  --TagBar
  -- use 'preservim/tagbar'

  --Terminal
  use "voldikss/vim-floaterm"

  -- WhichKey
  use {
    "folke/which-key.nvim",
  }

  -- typescript
  use 'jose-elias-alvarez/typescript.nvim'

  -- -- Sessions
  use "mhinz/vim-startify"

  -- Status Line
  -- use "christianchiarulli/lualine.nvim"
  -- Git
  use { "lewis6991/gitsigns.nvim" }

  -- startup Time
  use { "dstein64/vim-startuptime" }

  use { "abecodes/tabout.nvim",
    wants = { 'nvim-treesitter' }, -- or require if not used so far
    after = { 'nvim-cmp' } -- if a completion plugin is using tabs load it before
  }

  -- -- Color Shower
  use { "norcalli/nvim-colorizer.lua" }

  -- autoSave
  use { "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        debounce_delay = 5000
      })
    end
  }

  -- surrounding
  use {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end
  }
  -- use { 'tpope/vim-surround' }
  --
  -- COLOR SCHEMES
  -- use ({ 'projekt0n/github-nvim-theme' })
  -- --
  --
  -- use { "cocopon/iceberg.vim" }

  -- use { 'Everblush/everblush.vim' }

  --
  -- use {'fcpg/vim-fahrenheit'}

  -- jest tester
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

  -- tags auto-completion
  use "windwp/nvim-ts-autotag"

  -- code actions
  use { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' }

  -- codi vim plugin - Like Quokkajs
  use { 'metakirby5/codi.vim' }

  -- scope for bufferline and Tabs
  use { "tiagovla/scope.nvim" }

  -- Import cost
  -- use { 'yardnsm/vim-import-cost', run = 'npm install' }

  -- Syntax highlighting
  use 'David-Kunz/markid'

  -- DAP
  -- use { "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" }
  -- use { "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" }
  -- use { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
