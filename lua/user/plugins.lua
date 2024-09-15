local fn = vim.fn

-- Automatically install packer
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
--
-- -- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
	git = {
		clone_timeout = 300, -- Timeout, in seconds, for git clones
	},
})
-- Install your plugins here

return packer.startup(function(use)
	-- My plugins here
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
	-- use({ "nvim-lua/popup.nvim" })
	-- use({ "p00f/nvim-ts-rainbow" })
	use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "numToStr/Comment.nvim" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({ "kyazdani42/nvim-web-devicons" })
	-- use({ "onsails/lspkind.nvim" })
	-- use({ "kyazdani42/nvim-tree.lua" })
	use({ "akinsho/bufferline.nvim" })
	use({ "moll/vim-bbye" })
	use({ "nvim-lualine/lualine.nvim" })
	use({ "akinsho/toggleterm.nvim" })
	use({ "ahmedkhalf/project.nvim" })
	use({ "lewis6991/impatient.nvim" })
	use({ "lukas-reineke/indent-blankline.nvim", commit = "9637670896b68805430e2f72cf5d16be5b97a22a" })
	use("goolord/alpha-nvim")

	-- Colorschemesq
	use({ "lunarvim/darkplus.nvim" })
	use({
		"catppuccin/nvim",
		as = "catppuccin",
	})

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	use("David-Kunz/cmp-npm")
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use({ "hrsh7th/cmp-nvim-lua", ft = { "lua" } })
	-- use 'ms-jpq/coq_nvim'
	-- use 'ms-jpq/coq.artifacts'
	-- use 'ms-jpq/coq.thirdparty'
	use({ "epilande/vim-react-snippets" })
	use({ "honza/vim-snippets" })

	-- snippets
	use({ "L3MON4D3/LuaSnip" }) --snippet engine
	use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

	-- LSP
	use({ "neovim/nvim-lspconfig" }) -- enable LSP
	-- use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
	use({
		"williamboman/mason.nvim",
		config = function()
			require("user.lsp.mason")
		end,
	})
	use({ "williamboman/mason-lspconfig.nvim" })
	-- no need for null-ls, using lsp-config
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate" })
	use("lvimuser/lsp-inlayhints.nvim")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
	})
	-- Treesitter
	use({ "sharkdp/fd" })
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	--TagBar
	-- use 'preservim/tagbar'
	use({
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup()
		end,
	})
	--Terminal
	use("voldikss/vim-floaterm")

	-- WhichKey
	use({
		"folke/which-key.nvim",
	})

	-- typescript
	-- use("jose-elias-alvarez/typescript.nvim")

	-- -- Sessions
	use("mhinz/vim-startify")

	-- Status Line
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})

	-- Git
	use({ "lewis6991/gitsigns.nvim" })

	-- startup Time
	use({ "dstein64/vim-startuptime" })

	use({
		"abecodes/tabout.nvim",
		config = function()
			require("tabout").setup({
				tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
				backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
				act_as_tab = true, -- shift content if tab out is not possible
				act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
				default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
				default_shift_tab = "<C-d>", -- reverse shift default action,
				enable_backwards = true, -- well ...
				completion = true, -- if the tabkey is used in a completion pum
				tabouts = {
					{ open = "'", close = "'" },
					{ open = '"', close = '"' },
					{ open = "`", close = "`" },
					{ open = "(", close = ")" },
					{ open = "[", close = "]" },
					{ open = "{", close = "}" },
				},
				ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
				exclude = {}, -- tabout will ignore these filetypes
			})
		end,
		wants = { "nvim-treesitter" }, -- or require if not used so far
		after = { "nvim-cmp" }, -- if a completion plugin is using tabs load it before
	})

	-- -- Color Shower
	use({ "norcalli/nvim-colorizer.lua" })
	use("folke/tokyonight.nvim")

	-- autoSave
	use({
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({
				debounce_delay = 5000,
			})
		end,
	})

	use("mawkler/modicator.nvim")

	-- surrounding
	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	})
	-- use { 'tpope/vim-surround' }
	--
	-- NOTE: COLOR SCHEMES

	-- use ({ 'projekt0n/github-nvim-theme' })
	-- use { "cocopon/iceberg.vim" }
	-- use { 'Everblush/everblush.vim' }
	-- use {'fcpg/vim-fahrenheit'}

	-- NOTE: jest tester

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
	use("windwp/nvim-ts-autotag")

	-- Transparent
	-- use("xiyaowong/nvim-transparent")

	-- code actions
	use({
		"aznhe21/actions-preview.nvim",
		-- config = function()
		--   vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
		-- end,
	})
	-- use({ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" })

	-- codi vim plugin - Like Quokkajs
	use({ "metakirby5/codi.vim", ft = { "javascript", "typescript" } })

	-- scope for bufferline and Tabs
	use({ "tiagovla/scope.nvim" })

	-- Import cost
	-- use({ "barrett-ruth/import-cost.nvim", run = "sh install.sh npm" })

	-- Syntax highlighting
	use("David-Kunz/markid")

	use("rcarriga/nvim-notify")

	use("MunifTanjim/nui.nvim")

	use("rmagatti/goto-preview")

	use("sunjon/Shade.nvim")
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
	})

	-- use({
	--   "folke/trouble.nvim",
	--   requires = "kyazdani42/nvim-web-devicons",
	-- })

	use("fgheng/winbar.nvim")

	use({
		"folke/noice.nvim",
		requires = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	})

	-- Markdown
	-- install without yarn or npm
	-- use({
	--     "iamcco/markdown-preview.nvim",
	--     run = function() vim.fn["mkdp#util#install"]() end,
	-- })

	-- Pets
	use({
		"giusgad/pets.nvim",
		requires = {
			"giusgad/hologram.nvim",
			"MunifTanjim/nui.nvim",
		},
	})

	use({
		"Exafunction/codeium.vim",
		config = function()
			-- Change '<C-g>' here to any keycode you like.
			-- vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true })
		end,
	})

	use({
		"nvim-neo-tree/neo-tree.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	})
	use("stevearc/dressing.nvim")
	use({
		"ziontee113/icon-picker.nvim",
		config = function()
			require("icon-picker").setup({
				disable_legacy_commands = true,
			})
		end,
	})

	-- use("github/copilot.vim")

	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})
	-- use({ 'toppair/peek.nvim', run = 'deno task --quiet build:fast' })

	-- use({ "wakatime/vim-wakatime" })

	-- DAP
	-- use { "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" }
	-- use { "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" }
	-- use { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" }

	-- for intent line animation
	use({ "echasnovski/mini.indentscope", branch = "stable" })
	use({ "tamton-aquib/flirt.nvim" })

	-- conform for formatting
	use { 'stevearc/conform.nvim' }

	use({ "mbbill/undotree" })
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	-- if PACKER_BOOTSTRAP then
	--   require("packer").sync()
	-- end

	-- Java
	use("mfussenegger/nvim-jdtls")
end)
