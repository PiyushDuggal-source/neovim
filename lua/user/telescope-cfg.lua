--[[
  telescope-cfg.lua - Telescope Fuzzy Finder Configuration
  
  PERFORMANCE OPTIMIZATIONS:
    1. telescope-fzf-native for 10-50x faster fuzzy matching
    2. Debounce on live_grep (150ms)
    3. Extended file ignore patterns
    4. Result limits per file
--]]

local present, telescope = pcall(require, "telescope")

if not present then
  return
end

local actions = require("telescope.actions")
local icons = require("user.icons")

vim.g.theme_switcher_loaded = true

-- Show line numbers in Telescope preview
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function()
    vim.wo.number = true
  end,
})

-- Lazy-load previewers to avoid upfront require cost
local previewers = nil
local function get_previewers()
  if not previewers then
    previewers = require("telescope.previewers")
  end
  return previewers
end

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
      "--hidden",
      "--glob", "!.git/",
      "--trim",
      "--threads=4", -- Limit threads to prevent CPU spikes
    },
    
    prompt_prefix = icons.ui.Search .. " ",
    selection_caret = icons.ui.ArrowRight .. " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    
    -- Cache picker results for instant re-opening
    cache_picker = {
      num_pickers = 10,
      limit_entries = 500,
    },
    
    -- Floating window layout
    layout_strategy = "flex",
    layout_config = {
      flex = {
        flip_columns = 120,
      },
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      vertical = {
        mirror = true,
      },
      width = 0.85,
      height = 0.80,
      preview_cutoff = 40,
    },
    
    file_ignore_patterns = { 
      "node_modules",
      ".git/",
      "%.lock",
      "dist/",
      "build/",
      "%.min.js",
      "%.min.css",
      "package%-lock.json",
      "yarn.lock",
      "__pycache__/",
      "%.pyc",
      "%.class",
      "%.jar",
      "target/",
      "vendor/",
      -- "%.svg",
      "%.png",
      "%.jpg",
      "%.jpeg",
      "%.gif",
      "%.woff",
      "%.woff2",
      "%.ttf",
    },
    
    path_display = { "truncate" },
    winblend = 8, -- Slight transparency for glass-like effect
    border = {},
    -- Premium double-line border characters
    borderchars = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" },
    
    -- Lazy-loaded previewers
    file_previewer = function(...) return get_previewers().vim_buffer_cat.new(...) end,
    grep_previewer = function(...) return get_previewers().vim_buffer_vimgrep.new(...) end,
    qflist_previewer = function(...) return get_previewers().vim_buffer_qflist.new(...) end,
    buffer_previewer_maker = function(...) return get_previewers().buffer_previewer_maker(...) end,
    
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<Esc>"] = actions.close,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<C-h>"] = actions.preview_scrolling_left,
        ["<C-l>"] = actions.preview_scrolling_right,
      },
      n = { 
        ["q"] = actions.close,
      },
    },
  },

  pickers = {
    live_grep = {
      debounce = 150,
      additional_args = function()
        return { 
          "--max-count=100",
          "--max-columns=150",
          "--max-columns-preview",
        }
      end,
    },
    grep_string = {
      debounce = 150,
      additional_args = function()
        return {
          "--max-count=100",
          "--max-columns=150",
          "--max-columns-preview",
        }
      end,
    },
    find_files = {
      hidden = true,
      find_command = { 
        "fd", "--type", "f", 
        "--strip-cwd-prefix", 
        "--hidden", 
        "--exclude", ".git",
      },
    },
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
    },
  },

  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
}

telescope.setup(options)

-- Load extensions
pcall(function() telescope.load_extension("fzf") end)
pcall(function() telescope.load_extension("projects") end)
