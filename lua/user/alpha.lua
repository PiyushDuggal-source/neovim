local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local icons = require "user.icons"

local thingy = io.popen('echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"')
if thingy == nil then return end
local date = thingy:read("*a")
thingy:close()

local datetime = os.date " %H:%M"


local hi_top_section = {
  type = "text",
  val = "┌─────────── " .. icons.ui.Calendar .. " Today is " .. date .. " ──────────────┐",
  opts = {
    position = "center",
    hl = "Include"
  }
}

local hi_middle_section = {
  type = "text",
  val = "│                                                │",
  opts = {
    position = "center",
    hl = "Include"
  }
}
local hi_bottom_section = {
  type = "text",
  val = "└───══───══───══───  " ..
      icons.misc.Watch .. datetime .. "  ───══───══───══────┘",
  opts = {
    position = "center",
    hl = "Include"
  }
}
local dashboard = require "alpha.themes.dashboard"

headers = {
  {
    [[                                                 ]],
    [[                               __                ]],
    [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
    [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
    [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
    [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
    [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    [[                                                 ]],
  },
  {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
  },
  -- {
  --   -- "                                        ",
  -- "                                        ",
  -- "                                        ",
  -- "                                        ",
  -- "                                        ",
  -- "                                        ",
  -- "         //                 /*          ",
  -- "      ,(/(//,               *###        ",
  -- "    ((((((////.             /####%*     ",
  -- " ,/(((((((/////*            /########   ",
  -- "/*///((((((//////.          *#########/ ",
  -- "//////((((((((((((/         *#########/.",
  -- "////////((((((((((((*       *#########/.",
  -- "/////////(/(((((((((((      *#########(.",
  -- "//////////.,((((((((((/(    *#########(.",
  -- "//////////.  /(((((((((((,  *#########(.",
  -- "(////////(.    (((((((((((( *#########(.",
  -- "(////////(.     ,#((((((((((##########(.",
  -- "((//////((.       /#((((((((##%%######(.",
  -- "((((((((((.         #(((((((####%%##%#(.",
  -- "((((((((((.          ,((((((#####%%%%%(.",
  -- " .#(((((((.            (((((#######%%   ",
  -- "    /(((((.             .(((#%##%%/*    ",
  -- "      ,(((.               /(#%%#        ",
  -- "        ./.                 #*          ",
  -- "                                        ",
  -- "                                        ",
  -- "                                        ",
  -- "                                        ",
  -- "                                        ",
  -- },
  {
    [[███    ██ ███████  ██████  ██    ██ ██ ███    ███]],
    [[████   ██ ██      ██    ██ ██    ██ ██ ████  ████]],
    [[██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██]],
    [[██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██]],
    [[██   ████ ███████  ██████    ████   ██ ██      ██]]
  },
  {
    [[ _______             ____   ____.__         ]],
    [[ \      \   ____  ___\   \ /   /|__| _____  ]],
    [[ /   |   \_/ __ \/  _ \   Y   / |  |/     \ ]],
    [[/    |    \  ___(  <_> )     /  |  |  Y Y  \]],
    [[\____|__  /\___  >____/ \___/   |__|__|_|  /]],
    [[        \/     \/                        \/ ]],
  },
  {
    [[]],
    [[       ]],
    [[      ████ ██████           █████ ██]],
    [[     ███████████             █████           ]],
    [[    █████████  ███████████████████ ███   ███████████]],
    [[   █████████   ███    █████████████ █████ ██████████████]],
    [[  █████████  ██████████ █████████ █████ █████ ████ █████]],
    [[ ███████████ ███    ███ █████████ █████ █████ ████ █████]],
    [[██████  █████████████████████ ████ █████ █████ ████ ██████]],

  },
  -- {
  --   '▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▓██▓▓▓▓▓▒▓███▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░',
  --   '▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▓█████████████▓█▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░',
  --   '▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒░░░░░░░░░░▓▓███████████████▓██▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░',
  --   '▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░░███████████▓▓▓▓▓▓▓▓▓▒▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░',
  --   '▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▓██████████▓▓▓▓▓▓▓▒▒▒░▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░',
  --   '▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░██████████▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░',
  --   '▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░████████▓▓▓▓▓███▓▓▒▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▒░',
  --   '▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓███▓███▓▓▓▓▓▓▓█▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒░',
  --   '▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓██▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░',
  --   '▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█████▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░',
  --   '▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█████▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░',
  --   '▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░',
  --   '▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░█▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒',
  --   '▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓██▓▓▓▓▓▓▓▓▓▓▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒',
  --   '▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓██▓▒▒▓▓▓▓▓▓▓▓▒▒▒░▒▓▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒',
  --   '▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓█████▒▒▒▒▒▓▓▓▓▓▒░░░▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒░▒▒▒▒▒▒▒',
  --   '▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓██████████▓▒▒▒▒▓▓█▓▒░░░░█████▓▓▒▒░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒',
  --   '▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓████████████████████▒▒▓█████▓▓▒░▒███████▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░',
  --   '▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒██████████████████████▓▒▒▓▓███▓▓░▒▓█████████▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░',
  --   '▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓███████████████████████▒▒▓▓███▓▓░▒█████████████▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░',
  --   '▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒████████████████████████▒▒▓███▓▓▓░▓██████████████████▓░░░░░░░░░░░░░░░░░░░',
  --   '▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████████████████████████▓▒████▓▓▓▒███████████████████▓░░░░░░░░░░░░░░░░░░░',
  --   '▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██████████████████████████▒█████▓▓▒████████████████████░░░░░░░░░░░░░░░░░░░',
  --   '▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████████████████████████████████▓▓█████████████████████░░░░░░░░░░░░░░░░░░░',
  --   '▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████████████████████████████████▓▓█████████████████████░░░░░░░░░░░░░░░░░░░',
  --   '▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█████████████████████████████████▓██████████████████████░░░░░░░░░░░░░░░░░░░',
  --   '▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████████████████████████████████████████████████████████▒░░░░░░░░░░░░░░░░░░',
  --   '▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████████████████████████████████████████████████████████▓░░░░░░░░░░░░░░░░░░',
  --   '▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█████████████████████████████████████████████████████████░░░░░░░░░░░░░░░░░░',
  --
  -- },


  {
    '                     .:::!~!!!!!:.',
    '                  .xUHWH!! !!?M88WHX:.',
    '                .X*#M@$!!  !X!M$$$$$$WWx:.',
    '               :!!!!!!?H! :!$!$$$$$$$$$$8X:',
    '              !!~  ~:~!! :~!$!#$$$$$$$$$$8X:',
    '             :!~::!H!<   ~.U$X!?R$$$$$$$$MM!',
    '             ~!~!!!!~~ .:XW$$$U!!?$$$$$$RMM!',
    '               !:~~~ .:!M"T#$$$$WX??#MRRMMM!',
    '               ~?WuxiW*`   `"#$$$$8!!!!??!!!',
    '             :X- M$$$$       `"T#$T~!8$WUXU~',
    '            :%`  ~#$$$m:        ~!~ ?$$$$$$',
    '          :!`.-   ~T$$$$8xx.  .xWW- ~""##*"',
    '.....   -~~:<` !    ~?T#$$@@W@*?$$      /`',
    'W$@@M!!! .!~~ !!     .:XUW$W!~ `"~:    :',
    '#"~~`.:x%`!!  !H:   !WM$$$$Ti.: .!WUn+!`',
    ':::~:!!`:X~ .: ?H.!u "$$$B$$$!W:U!T$$M~',
    '.~~   :X@!.-~   ?@WTWo("*$$$W$TH$! `',
    'Wi.~!X$?!-~   :: ?$$$B$Wu("**$RM!',
    '$R@i.~~ !    ::   ~$$$$$B$$en:``',
    '?MXT@Wx.~   ::     ~"##*$$$$M'
  },
  {

    [[          ▀████▀▄▄              ▄█ ]],
    [[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ]],
    [[    ▄        █          ▀▀▀▀▄  ▄▀  ]],
    [[   ▄▀ ▀▄      ▀▄              ▀▄▀  ]],
    [[  ▄▀    █     █▀   ▄█▀▄      ▄█    ]],
    [[  ▀▄     ▀▄  █     ▀██▀     ██▄█   ]],
    [[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ]],
    [[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ]],
    [[   █   █  █      ▄▄           ▄▀   ]],

  }
}


-- dashboard.section.header.val = {
--   [[                                                 ]],
--   [[                               __                ]],
--   [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
--   [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
--   [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
--   [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
--   [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
--   [[                                                 ]],
-- }

dashboard.section.header.val = headers[math.random(7)]

dashboard.section.buttons.val = {
  dashboard.button("b", ' ' .. " Sessions", ":SLoad<CR>"),
  -- dashboard.button("T", ' ' .. " New Terminal", ":ToggleTerm size=40 dir=~/Piyush direction=horizontal<CR>"),
  dashboard.button("p", " " .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
  dashboard.button("T", ' ' .. " New Terminal", ":!kitty<CR>"),
  dashboard.button("r", "󰄉 " .. " Recent files", ":Telescope oldfiles <CR>"),
  dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
  dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
  -- dashboard.button("t", " " .. " Find text", ":Telescope live_grep <CR>"),
  dashboard.button("c", " " .. " Neovim Config", ":e ~/.config/nvim/init.lua <CR>"),
  dashboard.button("t", icons.ui.Settings .. "  Kitty Config", ":e ~/.config/kitty/kitty.conf <CR>"),
  dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}
local function footer()
  -- Number of plugins
  -- local total_plugins = #vim.tbl_keys(packer_plugins)
  -- local plugins_text = "   "
  --   .. total_plugins
  --   .. " plugins"
  --   .. "   v"
  --   .. vim.version().major
  --   .. "."
  --   .. vim.version().minor
  --   .. "."
  --   .. vim.version().patch
  --   .. "   "
  --   .. datetime

  -- Quote
  local fortune = require "alpha.fortune"
  local quote = table.concat(fortune(), "\n\n")

  local line = "                 ───══───══───══────"
  local plugins_count = vim.fn.len(vim.fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))
  -- local total_plugins = #vim.tbl_keys(packer_plugins)
  local plugins_text = "\n\n          Loaded "
      .. "`"
      .. plugins_count
      .. "`"
      .. " plugins"
      .. "  v"
      .. vim.version().major
      .. "."
      .. vim.version().minor
      .. "."
      .. vim.version().patch
      .. "  "
  -- .. "  "

  return line .. "\n" .. quote .. plugins_text
end

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.section.footer.opts = {
  position = "center",
  hl = "Include"
}

local section = {
  header = dashboard.section.header,
  hi_top_section = hi_top_section,
  hi_middle_section = hi_middle_section,
  hi_bottom_section = hi_bottom_section,
  buttons = dashboard.section.buttons,
  footer = dashboard.section.footer,
}
local opts = {
  layout = {
    { type = "padding", val = 3 },
    section.header,
    { type = "padding", val = 1 },
    section.hi_top_section,
    section.hi_middle_section,
    section.hi_bottom_section,
    { type = "padding", val = 2 },
    section.buttons,
    section.footer,
  },
  opts = {
    margin = 5
  },
}

-- dashboard.section.header.hi_top_section = hi_top_section
-- dashboard.section.header.hi_middle_section = hi_middle_section
-- dashboard.section.header.hi_bottom_section = hi_bottom_section

dashboard.opts.opts.noautocmd = true
alpha.setup(opts)
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.section.footer.opts = {
  position = "center",
  hl = "Include"
}

local section = {
  header = dashboard.section.header,
  hi_top_section = hi_top_section,
  hi_middle_section = hi_middle_section,
  hi_bottom_section = hi_bottom_section,
  buttons = dashboard.section.buttons,
  footer = dashboard.section.footer,
}
local opts = {
  layout = {
    { type = "padding", val = 3 },
    section.header,
    { type = "padding", val = 1 },
    section.hi_top_section,
    section.hi_middle_section,
    section.hi_bottom_section,
    { type = "padding", val = 2 },
    section.buttons,
    section.footer,
  },
  opts = {
    margin = 5
  },
}

-- dashboard.section.header.hi_top_section = hi_top_section
-- dashboard.section.header.hi_middle_section = hi_middle_section
-- dashboard.section.header.hi_bottom_section = hi_bottom_section

dashboard.opts.opts.noautocmd = true
alpha.setup(opts)
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.section.footer.opts = {
  position = "center",
  hl = "Include"
}

local section = {
  header = dashboard.section.header,
  hi_top_section = hi_top_section,
  hi_middle_section = hi_middle_section,
  hi_bottom_section = hi_bottom_section,
  buttons = dashboard.section.buttons,
  footer = dashboard.section.footer,
}
local opts = {
  layout = {
    { type = "padding", val = 3 },
    section.header,
    { type = "padding", val = 1 },
    section.hi_top_section,
    section.hi_middle_section,
    section.hi_bottom_section,
    { type = "padding", val = 2 },
    section.buttons,
    section.footer,
  },
  opts = {
    margin = 5
  },
}

-- dashboard.section.header.hi_top_section = hi_top_section
-- dashboard.section.header.hi_middle_section = hi_middle_section
-- dashboard.section.header.hi_bottom_section = hi_bottom_section

dashboard.opts.opts.noautocmd = true
alpha.setup(opts)
