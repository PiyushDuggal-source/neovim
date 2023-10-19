-- local status_ok, nvim_tree = pcall(require, "nvim-tree")
-- if not status_ok then
--   return
-- end
-- --
-- local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
-- if not config_status_ok then
-- 	return
-- end
--
-- local tree_cb = nvim_tree_config.nvim_tree_callback
--
-- nvim_tree.setup({
-- 	sort_by = "case_sensitive",
-- 	filters = {
-- 		dotfiles = false,
-- 	},
-- 	update_focused_file = {
-- 		enable = true,
-- 		update_cwd = true,
-- 		ignore_list = { "toggleterm", "term" },
-- 	},
-- 	hijack_cursor = true,
-- 	git = {
-- 		enable = true,
-- 		ignore = false,
-- 		timeout = 500,
-- 	},
-- 	renderer = {
-- 		root_folder_modifier = ":t",
-- 		icons = {
-- 			glyphs = {
-- 				default = "",
-- 				symlink = "",
-- 				folder = {
-- 					arrow_open = "",
-- 					arrow_closed = "",
-- 					default = "",
-- 					open = "",
-- 					empty = "",
-- 					empty_open = "",
-- 					symlink = "",
-- 					symlink_open = "",
-- 				},
-- 				git = {
-- 					unstaged = "",
-- 					staged = "",
-- 					unmerged = "",
-- 					renamed = "➜",
-- 					untracked = "U",
-- 					deleted = "",
-- 					ignored = "◌",
-- 				},
-- 			},
-- 		},
-- 	},
-- 	diagnostics = {
-- 		enable = true,
-- 		show_on_dirs = true,
-- 		icons = {
-- 			hint = "",
-- 			info = "",
-- 			warning = "",
-- 			error = "",
-- 		},
-- 	},
-- 	view = {
-- 		width = 30,
-- 		side = "left",
-- 		mappings = {
-- 			list = {
-- 				{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
-- 				{ key = "h", cb = tree_cb("close_node") },
-- 				{ key = "v", cb = tree_cb("vsplit") },
-- 			},
-- 		},
-- 	},
-- })
--

local icons = require("user.icons")

require("neo-tree").setup({
  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  enable_normal_mode_for_inputs = false,                             -- Enable normal mode for input dialogs.
  open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
  sort_case_insensitive = false,                                     -- used when sorting files and directories in the tree
  sort_function = nil,                                               -- use a custom function for sorting files and directories in the tree
  -- sort_function = function (a,b)
  --       if a.type == b.type then
  --           return a.path > b.path
  --       else
  --           return a.type > b.type
  --       end
  --   end , -- this sorts files and directories descendantly
  default_component_configs = {
    container = {
      enable_character_fade = true,
    },
    indent = {
      indent_size = 2,
      padding = 1, -- extra padding on left hand side
      -- indent guides
      with_markers = true,
      -- indent_marker = "│",
      indent_marker = icons.ui.DottedLine,
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      -- expander config, needed for nesting files
      with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      -- folder_closed = "󰉋",
      -- folder_open = "",
      folder_closed = icons.ui.Folder,
      folder_open = icons.ui.FolderOpen,
      -- folder_empty = "󰜌",
      -- folder_empty = "",
      folder_empty = icons.ui.EmptyFolder,
      -- empty_open = "",
      empty_open = icons.ui.EmptyFolderOpen,
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = "*",
      highlight = "NeoTreeFileIcon",
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        -- Change type
        added     = icons.ui.Plus,  -- or "✚", but this is redundant info if you use git_status_colors on the name
        modified  = "",             -- or "", but this is redundant info if you use git_status_colors on the name
        deleted   = icons.ui.Close, -- this can only be used in the git_status source
        -- renamed   = "󰁕",-- this can only be used in the git_status source
        renamed   = icons.git.FileRenamed,
        -- Status type
        untracked = icons.git.FileUntracked,
        ignored   = icons.git.FileIgnored,
        unstaged  = icons.git.FileUnstaged,
        -- staged    = "",
        conflict  = "",
        staged    = icons.git.FileStaged,
      },
    },
  },
  -- A list of functions, each representing a global custom command
  -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
  -- see `:h neo-tree-custom-commands-global`
  commands = {},
  window = {
    position = "left",
    width = 30,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["<space>"] = {
        "toggle_node",
        nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
      },
      ["<2-LeftMouse>"] = "open",
      ["l"] = "open",
      ["<esc>"] = "cancel", -- close preview or floating neo-tree window
      ["P"] = { "toggle_preview", config = { use_float = true } },
      ["<cr>"] = "focus_preview",
      ["S"] = "open_split",
      ["s"] = "open_vsplit",
      -- ["S"] = "split_with_window_picker",
      -- ["s"] = "vsplit_with_window_picker",
      ["t"] = "open_tabnew",
      -- ["<cr>"] = "open_drop",
      -- ["t"] = "open_tab_drop",
      ["w"] = "open_with_window_picker",
      --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
      ["h"] = "close_node",
      -- ['C'] = 'close_all_subnodes',
      ["z"] = "close_all_nodes",
      --["Z"] = "expand_all_nodes",
      ["a"] = {
        "add",
        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = "absolute", -- "none", "relative", "absolute"
        },
      },
      ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
      -- ["c"] = {
      --  "copy",
      --  config = {
      --    show_path = "none" -- "none", "relative", "absolute"
      --  }
      --}
      ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<"] = "prev_source",
      [">"] = "next_source",
    },
  },
  nesting_rules = {},
  filesystem = {
    filtered_items = {
      visible = false, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false, -- only works on Windows for hidden files/directories
      hide_by_name = {
        --"node_modules"
      },
      hide_by_pattern = { -- uses glob style patterns
        --"*.meta",
        --"*/src/*/tsconfig.json",
      },
      always_show = { -- remains visible even if other settings would normally hide it
        --".gitignored",
      },
      never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
        --".DS_Store",
        --"thumbs.db"
      },
      never_show_by_pattern = { -- uses glob style patterns
        --".null-ls_*",
      },
    },
    follow_current_file = {
      enabled = true,                       -- This will find and focus the file in the active buffer every time
      --               -- the current file is changed while the tree is open.
      leave_dirs_open = false,              -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    group_empty_dirs = false,               -- when true, empty folders will be grouped together
    hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
    -- in whatever position is specified in window.position
    -- "open_current",  -- netrw disabled, opening a directory opens within the
    -- window like netrw would, regardless of window.position
    -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
    use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
    -- instead of relying on nvim autocmd events.
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
        -- ["D"] = "fuzzy_sorter_directory",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
      },
      fuzzy_finder_mappings = {
        -- define keymaps for filter popup window in fuzzy_finder_mode
        ["<down>"] = "move_cursor_down",
        ["<C-n>"] = "move_cursor_down",
        ["<up>"] = "move_cursor_up",
        ["<C-p>"] = "move_cursor_up",
      },
    },

    commands = {}, -- Add a custom command or override a global one using the same function name
  },
  buffers = {
    follow_current_file = {
      enabled = true,          -- This will find and focus the file in the active buffer every time
      --              -- the current file is changed while the tree is open.
      leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    group_empty_dirs = true,   -- when true, empty folders will be grouped together
    show_unloaded = true,
    window = {
      mappings = {
        ["bd"] = "buffer_delete",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
      },
    },
  },
  git_status = {
    window = {
      position = "float",
      mappings = {
        ["A"] = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
      },
    },
  },
})


-- local nvimtree_options = {
--   active = true,
--   on_config_done = nil,
--   setup = {
--     auto_reload_on_write = false,
--     disable_netrw = false,
--     hijack_cursor = false,
--     hijack_netrw = true,
--     hijack_unnamed_buffer_when_opening = false,
--     sort_by = "name",
--     root_dirs = {},
--     prefer_startup_root = false,
--     sync_root_with_cwd = true,
--     reload_on_bufenter = false,
--     respect_buf_cwd = false,
--     on_attach = "default",
--     select_prompts = false,
--     view = {
--       adaptive_size = false,
--       centralize_selection = true,
--       width = 30,
--       hide_root_folder = false,
--       side = "left",
--       preserve_window_proportions = false,
--       number = false,
--       relativenumber = false,
--       signcolumn = "yes",
--       float = {
--         enable = false,
--         quit_on_focus_loss = true,
--         open_win_config = {
--           relative = "editor",
--           border = "rounded",
--           width = 30,
--           height = 30,
--           row = 1,
--           col = 1,
--         },
--       },
--     },
--     renderer = {
--       add_trailing = false,
--       group_empty = false,
--       highlight_git = true,
--       full_name = false,
--       highlight_opened_files = "none",
--       root_folder_label = ":t",
--       indent_width = 2,
--       indent_markers = {
--         enable = false,
--         inline_arrows = true,
--         icons = {
--           corner = "└",
--           edge = "│",
--           item = "│",
--           none = " ",
--         },
--       },
--       icons = {
--         -- webdev_colors = use_icons,
--         git_placement = "before",
--         padding = " ",
--         symlink_arrow = " ➛ ",
--         show = {
--           -- file = use_icons,
--           -- folder = use_icons,
--           folder_arrow = use_icons,
--           git = use_icons,
--         },
--         glyphs = {
--           default = icons.ui.Text,
--           symlink = icons.ui.FileSymlink,
--           bookmark = icons.ui.BookMark,
--           folder = {
--             arrow_closed = icons.ui.TriangleShortArrowRight,
--             arrow_open = icons.ui.TriangleShortArrowDown,
--             default = icons.ui.Folder,
--             open = icons.ui.FolderOpen,
--             empty = icons.ui.EmptyFolder,
--             empty_open = icons.ui.EmptyFolderOpen,
--             symlink = icons.ui.FolderSymlink,
--             symlink_open = icons.ui.FolderOpen,
--           },
--           git = {
--             unstaged = icons.git.FileUnstaged,
--             staged = icons.git.FileStaged,
--             unmerged = icons.git.FileUnmerged,
--             renamed = icons.git.FileRenamed,
--             untracked = icons.git.FileUntracked,
--             deleted = icons.git.FileDeleted,
--             ignored = icons.git.FileIgnored,
--           },
--         },
--       },
--       special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
--       symlink_destination = true,
--     },
--     hijack_directories = {
--       enable = false,
--       auto_open = true,
--     },
--     update_focused_file = {
--       enable = true,
--       debounce_delay = 15,
--       update_root = true,
--       ignore_list = {},
--     },
--     diagnostics = {
--       enable = use_icons,
--       show_on_dirs = false,
--       show_on_open_dirs = true,
--       debounce_delay = 50,
--       severity = {
--         min = vim.diagnostic.severity.HINT,
--         max = vim.diagnostic.severity.ERROR,
--       },
--       icons = {
--         hint = icons.diagnostics.BoldHint,
--         info = icons.diagnostics.BoldInformation,
--         warning = icons.diagnostics.BoldWarning,
--         error = icons.diagnostics.BoldError,
--       },
--     },
--     filters = {
--       dotfiles = false,
--       git_clean = false,
--       no_buffer = false,
--       custom = { "node_modules", "\\.cache" },
--       exclude = {},
--     },
--     filesystem_watchers = {
--       enable = true,
--       debounce_delay = 50,
--       ignore_dirs = {},
--     },
--     git = {
--       enable = true,
--       ignore = false,
--       show_on_dirs = true,
--       show_on_open_dirs = true,
--       timeout = 200,
--     },
--     actions = {
--       use_system_clipboard = true,
--       change_dir = {
--         enable = true,
--         global = false,
--         restrict_above_cwd = false,
--       },
--       expand_all = {
--         max_folder_discovery = 300,
--         exclude = {},
--       },
--       file_popup = {
--         open_win_config = {
--           col = 1,
--           row = 1,
--           relative = "cursor",
--           border = "shadow",
--           style = "minimal",
--         },
--       },
--       open_file = {
--         quit_on_open = false,
--         resize_window = false,
--         window_picker = {
--           enable = true,
--           picker = "default",
--           chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
--           exclude = {
--             filetype = { "notify", "lazy", "qf", "diff", "fugitive", "fugitiveblame" },
--             buftype = { "nofile", "terminal", "help" },
--           },
--         },
--       },
--       remove_file = {
--         close_window = true,
--       },
--     },
--     trash = {
--       cmd = "trash",
--       require_confirm = true,
--     },
--     live_filter = {
--       prefix = "[FILTER]: ",
--       always_show_folders = true,
--     },
--     tab = {
--       sync = {
--         open = false,
--         close = false,
--         ignore = {},
--       },
--     },
--     notify = {
--       threshold = vim.log.levels.INFO,
--     },
--     log = {
--       enable = false,
--       truncate = false,
--       types = {
--         all = false,
--         config = false,
--         copy_paste = false,
--         dev = false,
--         diagnostics = false,
--         git = false,
--         profile = false,
--         watcher = false,
--       },
--     },
--     system_open = {
--       cmd = nil,
--       args = {},
--     },
--   },
-- }
--
-- nvim_tree.setup(nvimtree_options)
