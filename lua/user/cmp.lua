--  local cmp_status_ok, cmp = pcall(require, "cmp")
--  if not cmp_status_ok then
--    return
--  end
--  local snip_status_ok, luasnip = pcall(require, "luasnip")
--  if not snip_status_ok then
--    return
--  end

-- require("luasnip/loaders/from_vscode").lazy_load({ path = { "./cool_snippets" } })
-- require("luasnip/loaders/from_vscode").lazy_load()

--  local check_backspace = function()
--    local col = vim.fn.col(".") - 1
--    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
--  end

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- local options ={
--    snippet = {
--      expand = function(args)
--        luasnip.lsp_expand(args.body) -- For `luasnip` users.
--      end,
--    },

--    mapping = cmp.mapping.preset.insert({
--      ["<C-k>"] = cmp.mapping.select_prev_item(),
--      ["<C-j>"] = cmp.mapping.select_next_item(),
--      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
--      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
--      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
--      ["<C-e>"] = cmp.mapping({
--        i = cmp.mapping.abort(),
--        c = cmp.mapping.close(),
--      }),
--      -- Accept currently selected item. If none selected, `select` first item.
--      -- Set `select` to `false` to only confirm explicitly selected items.
--      ["<CR>"] = cmp.mapping.confirm({ select = true }),
--      ["<Tab>"] = cmp.mapping(function(fallback)
--        if cmp.visible() then
--          cmp.select_next_item()
--        elseif luasnip.expandable() then
--          luasnip.expand()
--        elseif luasnip.expand_or_jumpable() then
--          luasnip.expand_or_jump()
--        elseif check_backspace() then
--          fallback()
--        else
--          fallback()
--        end
--      end, {
--        "i",
--        "s",
--      }),
--      ["<S-Tab>"] = cmp.mapping(function(fallback)
--        if cmp.visible() then
--          cmp.select_prev_item()
--        elseif luasnip.jumpable(-1) then
--          luasnip.jump(-1)
--        else
--          fallback()
--        end
--      end, {
--        "i",
--        "s",
--      }),
--    }),
--    formatting = {
--      fields = { "kind", "abbr", "menu" },
--      format = function(entry, vim_item)
--      	vim_item.kind = kind_icons[vim_item.kind]
--      	vim_item.menu = ({
--      		nvim_lsp = "[LSP]",
--      		nvim_lua = "[LSP_LUA]",
--      		luasnip = "[Snippet]",
--      		buffer = "[Buffer]",
--      		path = "[Path]",
--      		emoji = "",
--      	})[entry.source.name]
--      	return vim_item
--      end,
--      -- format = function(entry, vim_item)
--      --   if vim.tbl_contains({ 'path', "nvim_lua", 'luasnip' }, entry.source.name) then
--      --     local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
--      --     print(icon, hl_group)
--      --     if icon then
--      --       vim_item.kind = icon
--      --       vim_item.kind_hl_group = hl_group
--      --       return vim_item
--      --     end
--      --   end
--      --   return require('lspkind').cmp_format({ with_text = false })(entry, vim_item)
--      -- end
--    },
--    sources = {
--      { name = "nvim_lsp" },
--      { name = "nvim_lua" },
--      { name = "luasnip" },
--      { name = "npm", keyword_length = 4 },
--      { name = "path" },
--      { name = "buffer" },
--    },
--    -- confirm_opts = {
--    --   behavior = cmp.ConfirmBehavior.Replace,
--    --   select = false,
--    -- },
--    -- window = {
--    -- 	completion = cmp.config.window.bordered(),
--    -- 	documentation = cmp.config.window.bordered(),
--    -- },
--    experimental = {
--    	ghost_text = true,
--    },
--  }
--  cmp.setup({}
-- )
--
-- require("cmp-npm").setup({})
--
--

local present, cmp = pcall(require, "cmp")

if not present then
  return
end

require("luasnip/loaders/from_vscode").lazy_load({ path = { "./cool_snippets" } })
vim.opt.completeopt = "menuone,noselect"

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local cmp_window = require("cmp.utils.window")

cmp_window.info_ = cmp_window.info
cmp_window.info = function(self)
  local info = self:info_()
  info.scrollable = false
  return info
end

local options = {
  window = {
    completion = {
      border = border("CmpBorder"),
      winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
    },
    documentation = {
      border = border("CmpDocBorder"),
    },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.kind = kind_icons[vim_item.kind]
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[LSP_LUA]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
        emoji = "",
      })[entry.source.name]
      return vim_item
    end
  },
  -- formatting = {
  --   format = function(_, vim_item)
  --     local icons = kind_icons
  --     vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
  --     return vim_item
  --   end,
  -- },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "npm", keyword_length = 4 },
    { name = "path" },
    { name = "buffer" },
    --sources = {
    --	{ name = "luasnip" },
    --	{ name = "nvim_lsp" },
    --	{ name = "buffer" },
    --	{ name = "nvim_lua" },
    --	{ name = "path" },
  },
}

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    },
  }),
})
require("cmp-npm").setup({})
-- -- check for any override
-- options = require("core.utils").load_override(options, "hrsh7th/nvim-cmp")

cmp.setup(options)
