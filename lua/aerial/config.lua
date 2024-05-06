local default_options = {
  -- Priority list of preferred backends for aerial.
  -- This can be a filetype map (see :help aerial-filetype-map)
  backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },

  layout = {
    -- These control the width of the aerial window.
    -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_width and max_width can be a list of mixed types.
    -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
    max_width = { 40, 0.2 },
    width = nil,
    min_width = 10,

    -- key-value pairs of window-local options for aerial window (e.g. winhl)
    win_opts = {},

    -- Determines the default direction to open the aerial window. The 'prefer'
    -- options will open the window in the other direction *if* there is a
    -- different buffer in the way of the preferred direction
    -- Enum: prefer_right, prefer_left, right, left, float
    default_direction = "prefer_right",

    -- Determines where the aerial window will be opened
    --   edge   - open aerial at the far right/left of the editor
    --   window - open aerial to the right/left of the current window
    placement = "window",

    -- When the symbols change, resize the aerial window (within min/max constraints) to fit
    resize_to_content = true,

    -- Preserve window size equality with (:help CTRL-W_=)
    preserve_equality = false,
  },

  -- Determines how the aerial window decides which buffer to display symbols for
  --   window - aerial window will display symbols for the buffer in the window from which it was opened
  --   global - aerial window will display symbols for the current window
  attach_mode = "window",

  -- List of enum values that configure when to auto-close the aerial window
  --   unfocus       - close aerial when you leave the original source window
  --   switch_buffer - close aerial when you change buffers in the source window
  --   unsupported   - close aerial when attaching to a buffer that has no symbol source
  close_automatic_events = {},

  -- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
  -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
  -- Additionally, if it is a string that matches "actions.<name>",
  -- it will use the mapping at require("aerial.actions").<name>
  -- Set to `false` to remove a keymap
  keymaps = {
    ["?"] = "actions.show_help",
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.jump",
    ["<2-LeftMouse>"] = "actions.jump",
    ["<C-v>"] = "actions.jump_vsplit",
    ["<C-s>"] = "actions.jump_split",
    ["p"] = "actions.scroll",
    ["<C-j>"] = "actions.down_and_scroll",
    ["<C-k>"] = "actions.up_and_scroll",
    ["{"] = "actions.prev",
    ["}"] = "actions.next",
    ["[["] = "actions.prev_up",
    ["]]"] = "actions.next_up",
    ["q"] = "actions.close",
    ["o"] = "actions.tree_toggle",
    ["za"] = "actions.tree_toggle",
    ["O"] = "actions.tree_toggle_recursive",
    ["zA"] = "actions.tree_toggle_recursive",
    ["l"] = "actions.tree_open",
    ["zo"] = "actions.tree_open",
    ["L"] = "actions.tree_open_recursive",
    ["zO"] = "actions.tree_open_recursive",
    ["h"] = "actions.tree_close",
    ["zc"] = "actions.tree_close",
    ["H"] = "actions.tree_close_recursive",
    ["zC"] = "actions.tree_close_recursive",
    ["zr"] = "actions.tree_increase_fold_level",
    ["zR"] = "actions.tree_open_all",
    ["zm"] = "actions.tree_decrease_fold_level",
    ["zM"] = "actions.tree_close_all",
    ["zx"] = "actions.tree_sync_folds",
    ["zX"] = "actions.tree_sync_folds",
  },

  -- When true, don't load aerial until a command or function is called
  -- Defaults to true, unless `on_attach` is provided, then it defaults to false
  lazy_load = true,

  -- Disable aerial on files with this many lines
  disable_max_lines = 10000,

  -- Disable aerial on files this size or larger (in bytes)
  disable_max_size = 2000000, -- Default 2MB

  -- A list of all symbols to display. Set to false to display all symbols.
  -- This can be a filetype map (see :help aerial-filetype-map)
  -- To see all available values, see :help SymbolKind
  filter_kind = {
    "Class",
    "Constructor",
    "Enum",
    "Function",
    "Interface",
    "Module",
    "Method",
    "Struct",
  },

  -- Determines line highlighting mode when multiple splits are visible.
  -- split_width   Each open window will have its cursor location marked in the
  --               aerial buffer. Each line will only be partially highlighted
  --               to indicate which window is at that location.
  -- full_width    Each open window will have its cursor location marked as a
  --               full-width highlight in the aerial buffer.
  -- last          Only the most-recently focused window will have its location
  --               marked in the aerial buffer.
  -- none          Do not show the cursor locations in the aerial window.
  highlight_mode = "split_width",

  -- Highlight the closest symbol if the cursor is not exactly on one.
  highlight_closest = true,

  -- Highlight the symbol in the source buffer when cursor is in the aerial win
  highlight_on_hover = false,

  -- When jumping to a symbol, highlight the line for this many ms.
  -- Set to false to disable
  highlight_on_jump = 300,

  -- Jump to symbol in source window when the cursor moves
  autojump = false,

  -- Define symbol icons. You can also specify "<Symbol>Collapsed" to change the
  -- icon when the tree is collapsed at that symbol, or "Collapsed" to specify a
  -- default collapsed icon. The default icon set is determined by the
  -- "nerd_font" option below.
  -- If you have lspkind-nvim installed, it will be the default icon set.
  -- This can be a filetype map (see :help aerial-filetype-map)
  icons = {},

  -- Control which windows and buffers aerial should ignore.
  -- Aerial will not open when these are focused, and existing aerial windows will not be updated
  ignore = {
    -- Ignore unlisted buffers. See :help buflisted
    unlisted_buffers = false,

    -- Ignore diff windows (setting to false will allow aerial in diff windows)
    diff_windows = true,

    -- List of filetypes to ignore.
    filetypes = {},

    -- Ignored buftypes.
    -- Can be one of the following:
    -- false or nil - No buftypes are ignored.
    -- "special"    - All buffers other than normal, help and man page buffers are ignored.
    -- table        - A list of buftypes to ignore. See :help buftype for the
    --                possible values.
    -- function     - A function that returns true if the buffer should be
    --                ignored or false if it should not be ignored.
    --                Takes two arguments, `bufnr` and `buftype`.
    buftypes = "special",

    -- Ignored wintypes.
    -- Can be one of the following:
    -- false or nil - No wintypes are ignored.
    -- "special"    - All windows other than normal windows are ignored.
    -- table        - A list of wintypes to ignore. See :help win_gettype() for the
    --                possible values.
    -- function     - A function that returns true if the window should be
    --                ignored or false if it should not be ignored.
    --                Takes two arguments, `winid` and `wintype`.
    wintypes = "special",
  },

  -- Use symbol tree for folding. Set to true or false to enable/disable
  -- Set to "auto" to manage folds if your previous foldmethod was 'manual'
  -- This can be a filetype map (see :help aerial-filetype-map)
  manage_folds = false,

  -- When you fold code with za, zo, or zc, update the aerial tree as well.
  -- Only works when manage_folds = true
  link_folds_to_tree = false,

  -- Fold code when you open/collapse symbols in the tree.
  link_tree_to_folds = true,

  -- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
  -- "auto" will set it to true if nvim-web-devicons or lspkind-nvim is installed.
  nerd_font = "auto",

  -- Call this function when aerial attaches to a buffer.
  on_attach = function(bufnr) end,

  -- Call this function when aerial first sets symbols on a buffer.
  on_first_symbols = function(bufnr) end,

  -- Call this function each time aerial sets symbols on a buffer.
  -- If Aerial falls back from one backend to another, this function
  -- will be called each time, whereas on_first_symbols will only be
  -- called once.
  on_set_symbols = function(bufnr) end,

  -- Automatically open aerial when entering supported buffers.
  -- This can be a function (see :help aerial-open-automatic)
  open_automatic = false,

  -- Run this command after jumping to a symbol (false will disable)
  post_jump_cmd = "normal! zz",

  -- Invoked after each symbol is parsed, can be used to modify the parsed item,
  -- or to filter it by returning false.
  --
  -- bufnr: a neovim buffer number
  -- item: of type aerial.Symbol
  -- ctx: a record containing the following fields:
  --   * backend_name: treesitter, lsp, man...
  --   * lang: info about the language
  --   * symbols?: specific to the lsp backend
  --   * symbol?: specific to the lsp backend
  --   * syntax_tree?: specific to the treesitter backend
  --   * match?: specific to the treesitter backend, TS query match
  post_parse_symbol = function(bufnr, item, ctx)
    return true
  end,

  -- Invoked after all symbols have been parsed and post-processed,
  -- allows to modify the symbol structure before final display
  --
  -- bufnr: a neovim buffer number
  -- items: a collection of aerial.Symbol items, organized in a tree,
  --        with 'parent' and 'children' fields
  -- ctx: a record containing the following fields:
  --   * backend_name: treesitter, lsp, man...
  --   * lang: info about the language
  --   * symbols?: specific to the lsp backend
  --   * syntax_tree?: specific to the treesitter backend
  post_add_all_symbols = function(bufnr, items, ctx)
    return items
  end,

  -- When true, aerial will automatically close after jumping to a symbol
  close_on_select = false,

  -- The autocmds that trigger symbols update (not used for LSP backend)
  update_events = "TextChanged,InsertLeave",

  -- Show box drawing characters for the tree hierarchy
  show_guides = false,

  -- Customize the characters used when show_guides = true
  guides = {
    -- When the child item has a sibling below it
    mid_item = "├─",
    -- When the child item is the last in the list
    last_item = "└─",
    -- When there are nested child guides to the right
    nested_top = "│ ",
    -- Raw indentation
    whitespace = "  ",
  },

  -- Set this function to override the highlight groups for certain symbols
  get_highlight = function(symbol, is_icon, is_collapsed)
    -- return "MyHighlight" .. symbol.kind
  end,

  -- Options for opening aerial in a floating win
  float = {
    -- Controls border appearance. Passed to nvim_open_win
    border = "rounded",

    -- Determines location of floating window
    --   cursor - Opens float on top of the cursor
    --   editor - Opens float centered in the editor
    --   win    - Opens float centered in the window
    relative = "cursor",

    -- These control the height of the floating window.
    -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_height and max_height can be a list of mixed types.
    -- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
    max_height = 0.9,
    height = nil,
    min_height = { 8, 0.1 },

    override = function(conf, source_winid)
      -- This is the config that will be passed to nvim_open_win.
      -- Change values here to customize the layout
      return conf
    end,
  },

  -- Options for the floating nav windows
  nav = {
    border = "rounded",
    max_height = 0.9,
    min_height = { 10, 0.1 },
    max_width = 0.5,
    min_width = { 0.2, 20 },
    win_opts = {
      cursorline = true,
      winblend = 10,
    },
    -- Jump to symbol in source window when the cursor moves
    autojump = false,
    -- Show a preview of the code in the right column, when there are no child symbols
    preview = false,
    -- Keymaps in the nav window
    keymaps = {
      ["<CR>"] = "actions.jump",
      ["<2-LeftMouse>"] = "actions.jump",
      ["<C-v>"] = "actions.jump_vsplit",
      ["<C-s>"] = "actions.jump_split",
      ["h"] = "actions.left",
      ["l"] = "actions.right",
      ["<C-c>"] = "actions.close",
    },
  },

  lsp = {
    -- If true, fetch document symbols when LSP diagnostics update.
    diagnostics_trigger_update = false,

    -- Set to false to not update the symbols when there are LSP errors
    update_when_errors = true,

    -- How long to wait (in ms) after a buffer change before updating
    -- Only used when diagnostics_trigger_update = false
    update_delay = 300,

    -- Map of LSP client name to priority. Default value is 10.
    -- Clients with higher (larger) priority will be used before those with lower priority.
    -- Set to -1 to never use the client.
    priority = {
      -- pyright = 10,
    },
  },

  treesitter = {
    -- How long to wait (in ms) after a buffer change before updating
    update_delay = 300,
  },

  markdown = {
    -- How long to wait (in ms) after a buffer change before updating
    update_delay = 300,
  },

  asciidoc = {
    -- How long to wait (in ms) after a buffer change before updating
    update_delay = 300,
  },

  man = {
    -- How long to wait (in ms) after a buffer change before updating
    update_delay = 300,
  },
}

-- stylua: ignore
local plain_icons = {
  Array         = "[a]",
  Boolean       = "[b]",
  Class         = "[C]",
  Constant      = "[const]",
  Constructor   = "[Co]",
  Enum          = "[E]",
  EnumMember    = "[em]",
  Event         = "[Ev]",
  Field         = "[Fld]",
  File          = "[File]",
  Function      = "[F]",
  Interface     = "[I]",
  Key           = "[K]",
  Method        = "[M]",
  Module        = "[Mod]",
  Namespace     = "[NS]",
  Null          = "[-]",
  Number        = "[n]",
  Object        = "[o]",
  Operator      = "[+]",
  Package       = "[Pkg]",
  Property      = "[P]",
  String        = "[str]",
  Struct        = "[S]",
  TypeParameter = "[T]",
  Variable      = "[V]",
  Collapsed     = "▶",
}

-- stylua: ignore
local nerd_icons = {
  Array         = "󱡠 ",
  Boolean       = "󰨙 ",
  Class         = "󰆧 ",
  Constant      = "󰏿 ",
  Constructor   = " ",
  Enum          = " ",
  EnumMember    = " ",
  Event         = " ",
  Field         = " ",
  File          = "󰈙 ",
  Function      = "󰊕 ",
  Interface     = " ",
  Key           = "󰌋 ",
  Method        = "󰊕 ",
  Module        = " ",
  Namespace     = "󰦮 ",
  Null          = "󰟢 ",
  Number        = "󰎠 ",
  Object        = " ",
  Operator      = "󰆕 ",
  Package       = " ",
  Property      = " ",
  String        = " ",
  Struct        = "󰆼 ",
  TypeParameter = "󰗴 ",
  Variable      = "󰀫 ",
  Collapsed     = " ",
}

local islist = vim.islist or vim.tbl_islist
local M = {}

M.get_filetypes = function(bufnr)
  local ft = vim.bo[bufnr or 0].filetype
  return vim.split(ft, "%.")
end

---@param name string
---@param option any
---@param default any
local function create_filetype_opt_getter(name, option, default)
  local buffer_option_name = string.format("aerial_%s", name)
  if type(option) ~= "table" or islist(option) then
    return function(bufnr)
      local has_buf_option, buf_option = pcall(vim.api.nvim_buf_get_var, bufnr, buffer_option_name)
      if has_buf_option then
        return buf_option
      else
        return option
      end
    end
  else
    return function(bufnr)
      local has_buf_option, buf_option = pcall(vim.api.nvim_buf_get_var, bufnr, buffer_option_name)
      if has_buf_option then
        return buf_option
      end
      for _, ft in ipairs(M.get_filetypes(bufnr)) do
        if option[ft] ~= nil then
          return option[ft]
        end
      end
      if option["_"] ~= nil then
        return option["_"]
      else
        return default
      end
    end
  end
end

---@param value string
---@param values string[]
---@param opts? {allow_nil: boolean}
local function assert_enum(value, values, opts)
  opts = opts or {}
  local valid
  if value == nil then
    valid = opts.allow_nil
  else
    valid = vim.tbl_contains(values, value)
  end
  if valid then
    return value
  else
    vim.notify(
      string.format("Aerial got '%s', expected one of %s", value, table.concat(values, ", ")),
      vim.log.levels.WARN
    )
    return values[1]
  end
end

M.setup = function(opts)
  opts = opts or {}

  local newconf = vim.tbl_deep_extend("force", default_options, opts)

  -- Asserts for all enum values
  newconf.layout.default_direction = assert_enum(
    newconf.layout.default_direction,
    { "prefer_right", "prefer_left", "right", "left", "float" }
  )
  newconf.layout.placement = assert_enum(newconf.layout.placement, { "window", "edge" })
  newconf.attach_mode = assert_enum(newconf.attach_mode, { "window", "global" })
  for i, v in ipairs(newconf.close_automatic_events) do
    newconf.close_automatic_events[i] =
      assert_enum(v, { "unfocus", "switch_buffer", "unsupported" })
  end
  newconf.highlight_mode =
    assert_enum(newconf.highlight_mode, { "split_width", "full_width", "last", "none" })

  if newconf.nerd_font == "auto" then
    local has_devicons = pcall(require, "nvim-web-devicons")
    local has_lspkind = pcall(require, "lspkind")
    newconf.nerd_font = has_devicons or has_lspkind
  end

  -- Add lookup to close_automatic_events
  for i, v in ipairs(newconf.close_automatic_events) do
    newconf.close_automatic_events[v] = i
  end

  -- Undocumented use_lspkind option for tests. End users can simply provide
  -- their own icons
  if newconf.use_lspkind == nil then
    newconf.use_lspkind = true
  end

  newconf.default_icons = newconf.nerd_font and nerd_icons or plain_icons

  if type(newconf.open_automatic) == "boolean" then
    local open_automatic = newconf.open_automatic
    newconf.open_automatic = function(bufnr)
      return open_automatic and not require("aerial.util").is_ignored_buf(bufnr)
    end
  elseif type(newconf.open_automatic) ~= "function" then
    vim.notify_once(
      "aerial.config.open_automatic should be a boolean or function. See :help aerial-open-automatic.",
      vim.log.levels.WARN
    )
    newconf.open_automatic = function(bufnr)
      return false
    end
  end

  for k, v in pairs(newconf) do
    M[k] = v
  end
  M.manage_folds =
    create_filetype_opt_getter("manage_folds", M.manage_folds, default_options.manage_folds)
  M.backends = create_filetype_opt_getter("backends", M.backends, default_options.backends)
  local get_filter_kind_list =
    create_filetype_opt_getter("filter_kind", M.filter_kind, default_options.filter_kind)
  ---@param bufnr integer
  M.get_filter_kind_map = function(bufnr)
    local fk = get_filter_kind_list(bufnr)
    if fk == false or fk == 0 then
      return setmetatable({}, {
        __index = function()
          return true
        end,
        __tostring = function()
          return "all symbols"
        end,
      })
    else
      local ret = {}
      for _, kind in ipairs(fk) do
        ret[kind] = true
      end
      return setmetatable(ret, {
        __tostring = function()
          return table.concat(fk, ", ")
        end,
      })
    end
  end
end

local function get_icon(kind, filetypes)
  for _, ft in ipairs(filetypes) do
    local icon_map = M.icons[ft]
    local icon = icon_map and icon_map[kind]
    if icon then
      return icon
    end
  end
  return M.icons[kind]
end

M.get_icon = function(bufnr, kind, collapsed)
  if collapsed then
    kind = kind .. "Collapsed"
  end
  local icon
  -- Slight optimization for users that don't specify icons
  if not vim.tbl_isempty(M.icons) then
    local filetypes = M.get_filetypes(bufnr)
    table.insert(filetypes, "_")
    icon = get_icon(kind, filetypes)
    if not icon and collapsed then
      icon = get_icon("Collapsed", filetypes)
    end
    if icon then
      return icon
    end
  end

  local has_lspkind, lspkind = pcall(require, "lspkind")
  if has_lspkind and M.use_lspkind and not collapsed then
    icon = lspkind.symbolic(kind, { with_text = false })
    if icon and icon ~= "" then
      return icon
    end
  end
  icon = M.default_icons[kind]
  if not icon and collapsed then
    icon = M.default_icons.Collapsed
  end
  return icon or " "
end

return M
