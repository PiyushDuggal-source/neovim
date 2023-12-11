-- local status_ok, telescope = pcall(require, "telescope")
-- if not status_ok then
--   return
-- end
--
-- local actions = require "telescope.actions"
-- -- telescope.load_extension("media_files")
--
-- telescope.setup {
--   defaults = {
--
--     prompt_prefix = " ",
--     selection_caret = " ",
--     path_display = { "smart" },
--     file_ignore_patterns = { ".git/", "node_modules" }, layout_config = {
--       preview_width = 0.7
--     },
--     mappings = {
--       i = {
--
--         ["<C-n>"] = actions.cycle_history_next,
--         ["<C-p>"] = actions.cycle_history_prev,
--
--         ["<C-j>"] = actions.move_selection_next,
--         ["<C-k>"] = actions.move_selection_previous,
--
--         ["<C-c>"] = actions.close,
--
--         ["<Down>"] = actions.move_selection_next,
--         ["<Up>"] = actions.move_selection_previous,
--
--         ["<CR>"] = actions.select_default,
--         ["<C-x>"] = actions.select_horizontal,
--         ["<C-v>"] = actions.select_vertical,
--         ["<C-t>"] = actions.select_tab,
--
--         ["<C-u>"] = actions.preview_scrolling_up,
--         ["<C-d>"] = actions.preview_scrolling_down,
--
--         ["<PageUp>"] = actions.results_scrolling_up,
--         ["<PageDown>"] = actions.results_scrolling_down,
--
--         ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
--         ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
--         ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
--         ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
--         ["<C-l>"] = actions.complete_tag,
--         ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
--       },
--       n = {
--         ["<esc>"] = actions.close,
--         ["<CR>"] = actions.select_default,
--         ["<C-x>"] = actions.select_horizontal,
--         ["<C-v>"] = actions.select_vertical,
--         ["<C-t>"] = actions.select_tab,
--
--         ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
--         ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
--         ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
--         ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
--
--         ["j"] = actions.move_selection_next,
--         ["k"] = actions.move_selection_previous,
--         ["H"] = actions.move_to_top,
--         ["M"] = actions.move_to_middle,
--         ["L"] = actions.move_to_bottom,
--
--         ["<Down>"] = actions.move_selection_next,
--         ["<Up>"] = actions.move_selection_previous,
--         ["gg"] = actions.move_to_top,
--         ["G"] = actions.move_to_bottom,
--
--         ["<C-u>"] = actions.preview_scrolling_up,
--         ["<C-d>"] = actions.preview_scrolling_down,
--
--         ["<PageUp>"] = actions.results_scrolling_up,
--         ["<PageDown>"] = actions.results_scrolling_down,
--
--         ["?"] = actions.which_key,
--       },
--     },
--   },
--   pickers = {
--     -- Default configuration for builtin pickers goes here:
--     -- picker_name = {
--     --   picker_config_key = value,
--     --   ...
--     -- }
--     -- Now the picker_config_key will be applied every time you call this
--     -- builtin picker
--   },
--   extensions = {
--     -- media_files = {
--       -- filetypes whitelist
--       -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
--     --  filetypes = { "png", "webp", "jpg", "jpeg" },
--     --  find_cmd = "rg" -- find command (defaults to `fd`)
--  --   }
--     -- Your extension configuration goes here:
--     -- extension_name = {
--     --   extension_config_key = value,
--     -- }
--     -- please take a look at the readme of the extension you want to configure
--   },
-- }
--

local present, telescope = pcall(require, "telescope")

if not present then
  return
end

local icons = require("user.icons")

vim.g.theme_switcher_loaded = true

local options = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    -- prompt_prefix = "   ",
    -- selection_caret = "  ",
    prompt_prefix = icons.ui.Search .. " ",
    selection_caret = icons.ui.ArrowRight .. " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.80,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },

  extensions_list = {
    "themes",
    "terms",
    fzf = {
      fuzzy = true,                     -- false will only do exact matching
      override_generic_sorter = true,   -- override the generic sorter
      override_file_sorter = true,      -- override the file sorter
      case_mode = "smart_case",         -- or "ignore_case" or "respect_case"
    },
  },

}

-- check for any override
-- options = require("core.utils").load_override(options, "nvim-telescope/telescope.nvim")
telescope.setup(options)

-- load extensions
-- pcall(function()
-- for _, ext in ipairs(options.extensions_list) do
-- 	telescope.load_extension(ext)
-- end
-- end)
