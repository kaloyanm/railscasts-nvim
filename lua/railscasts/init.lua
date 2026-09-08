local M = {}

local p = require("railscasts.palette")

local config = {
  transparent = false,
  italic = true,
  terminal = true,
}

function M.setup(opts)
  opts = opts or {}
  if opts.transparent ~= nil then config.transparent = opts.transparent end
  if opts.italic ~= nil then config.italic = opts.italic end
  if opts.terminal ~= nil then config.terminal = opts.terminal end
end

local function hl(group, spec)
  vim.api.nvim_set_hl(0, group, spec)
end

local function apply()
  local bg = p.bg
  if config.transparent then bg = nil end

  local editor = {
    Normal         = { fg = p.fg, bg = bg },
    NormalNC       = { fg = p.fg, bg = bg },
    NormalFloat    = { fg = p.fg, bg = p.bg_float },
    NormalSB       = { fg = p.fg, bg = p.bg_float },
    EndOfBuffer    = { fg = p.bg },
    ColorColumn    = { bg = p.bg_float },
    Conceal        = { fg = p.gray_dim },
    Cursor         = { fg = p.bg, bg = p.caret },
    lCursor        = { fg = p.bg, bg = p.caret },
    CursorIM       = { fg = p.bg, bg = p.caret },
    CursorColumn   = { bg = p.bg_float },
    CursorLine     = { bg = p.bg_float },
    CursorLineNr   = { fg = p.func, bg = p.bg_float },
    LineNr         = { fg = p.linenr, bg = bg },
    SignColumn     = { fg = p.gray, bg = bg },
    FoldColumn     = { fg = p.gray_dim, bg = bg },
    Folded         = { fg = p.gray, bg = p.bg_alt },
    VertSplit      = { fg = p.border, bg = bg },
    WinSeparator   = { fg = p.border, bg = bg },
    Whitespace     = { fg = p.invisible },
    NonText        = { fg = p.gray_dim },
    SpecialKey     = { fg = p.invisible },
    MatchParen     = { fg = p.bg, bg = p.keyword },
    Search         = { fg = p.bg, bg = p.tag },
    IncSearch      = { fg = p.bg, bg = p.func },
    CurSearch      = { fg = p.bg, bg = p.keyword },
    Visual         = { fg = p.fg, bg = p.bg_selection },
    VisualNOS      = { fg = p.fg, bg = p.bg_selection },
    QuickFixLine   = { fg = p.fg, bg = p.bg_float },
  }

  local messages = {
    ModeMsg       = { fg = p.fg },
    MsgArea       = { fg = p.fg },
    MsgSeparator  = { fg = p.gray_dim, bg = p.bg_alt },
    MoreMsg       = { fg = p.string },
    Question      = { fg = p.func },
    WarningMsg    = { fg = p.tag },
    ErrorMsg      = { fg = p.white, bg = p.error_bg },
    InfoMsg       = { fg = p.constant },
    Title         = { fg = p.white, bold = true },
  }

  local popup = {
    Pmenu          = { fg = p.fg, bg = p.bg_float },
    PmenuSel       = { fg = p.white, bg = p.bg_selection },
    PmenuKind      = { fg = p.func, bg = p.bg_float },
    PmenuKindSel   = { fg = p.func, bg = p.bg_selection },
    PmenuExtra     = { fg = p.gray, bg = p.bg_float },
    PmenuExtraSel  = { fg = p.gray, bg = p.bg_selection },
    PmenuSbar      = { bg = p.bg_alt },
    PmenuThumb     = { bg = p.gray_dim },
    WildMenu       = { fg = p.white, bg = p.bg_selection },
    FloatBorder    = { fg = p.gray_dim, bg = p.bg_float },
    FloatTitle     = { fg = p.fg, bg = p.bg_selection },
    FloatFooter    = { fg = p.gray, bg = p.bg_float },
  }

  local statusline = {
    StatusLine       = { fg = p.fg, bg = p.bg_float },
    StatusLineNC     = { fg = p.gray_dim, bg = p.bg_alt },
    StatusLineTerm   = { fg = p.fg, bg = p.bg_float },
    StatusLineTermNC = { fg = p.gray_dim, bg = p.bg_alt },
    WinBar           = { fg = p.fg, bg = p.bg_float },
    WinBarNC         = { fg = p.gray_dim, bg = p.bg_alt },
    TabLine          = { fg = p.gray, bg = p.bg_alt },
    TabLineFill      = { bg = bg },
    TabLineSel       = { fg = p.white, bg = p.bg_selection },
  }

  local syntax = {
    Comment        = { fg = p.comment },
    SpecialComment = { fg = p.comment },
    Constant       = { fg = p.constant },
    String         = { fg = p.string },
    Character      = { fg = p.string },
    Number         = { fg = p.string },
    Float          = { fg = p.string },
    Boolean        = { fg = p.constant_b },
    Identifier     = { fg = p.fg },
    Function       = { fg = p.func },
    Statement      = { fg = p.keyword },
    Conditional    = { fg = p.keyword },
    Repeat         = { fg = p.keyword },
    Label          = { fg = p.func },
    Operator       = { fg = p.fg },
    Keyword        = { fg = p.keyword },
    Exception      = { fg = p.keyword },
    Include        = { fg = p.keyword },
    PreProc        = { fg = p.keyword },
    Define         = { fg = p.keyword },
    Macro          = { fg = p.keyword },
    PreCondit      = { fg = p.keyword },
    StorageClass   = { fg = p.keyword },
    Structure      = { fg = p.keyword },
    Type           = { fg = p.constant_b },
    Typedef        = { fg = p.constant_b },
    Special        = { fg = p.constant },
    SpecialChar    = { fg = p.escape },
    Tag            = { fg = p.tag },
    Delimiter      = { fg = p.fg },
    Debug          = { fg = p.func },
    Underlined     = { fg = p.constant, underline = true },
    Ignore         = { fg = p.invisible },
    Error          = { fg = p.white, bg = p.error_bg },
    Todo           = { fg = p.func, bold = true },
    Directory      = { fg = p.constant },
    qfLineNr       = { fg = p.func },
    qfError        = { fg = p.red_bright },
  }

  local diff = {
    DiffAdd    = { fg = p.green_bright, bg = p.diff_add_bg },
    DiffDelete = { fg = p.red_bright, bg = p.diff_del_bg },
    DiffChange = { fg = p.violet, bg = p.bg_alt },
    DiffText   = { fg = p.fg, bg = p.diff_header },
    Added      = { fg = p.green_bright, bg = p.diff_add_bg },
    Changed    = { fg = p.violet, bg = p.bg_alt },
    Removed    = { fg = p.red_bright, bg = p.diff_del_bg },
  }

  local vcs = {
    GitSignsAdd                = { fg = p.green_bright },
    GitSignsAddLn              = { fg = p.green_bright },
    GitSignsAddNr              = { fg = p.green_bright },
    GitSignsChange             = { fg = p.violet },
    GitSignsChangeLn           = { fg = p.violet },
    GitSignsChangeNr           = { fg = p.violet },
    GitSignsDelete             = { fg = p.red_bright },
    GitSignsDeleteLn           = { fg = p.red_bright },
    GitSignsDeleteNr           = { fg = p.red_bright },
    GitSignsTopdelete          = { fg = p.red_bright },
    GitSignsChangedelete       = { fg = p.violet },
    GitSignsUntracked          = { fg = p.string },
    SignifySignAdd             = { fg = p.green_bright },
    SignifySignChange          = { fg = p.violet },
    SignifySignDelete          = { fg = p.red_bright },
    SignifySignAddFirstLine    = { fg = p.green_bright },
    SignifySignChangeFirstLine = { fg = p.violet },
    SignifySignDeleteFirstLine = { fg = p.red_bright },
  }

  local diagnostics = {
    DiagnosticError              = { fg = p.red },
    DiagnosticWarn               = { fg = p.keyword },
    DiagnosticInfo               = { fg = p.constant },
    DiagnosticHint               = { fg = p.gray },
    DiagnosticOk                 = { fg = p.string },
    DiagnosticUnderlineError     = { undercurl = true, sp = p.red },
    DiagnosticUnderlineWarn      = { undercurl = true, sp = p.keyword },
    DiagnosticUnderlineInfo      = { undercurl = true, sp = p.constant },
    DiagnosticUnderlineHint      = { undercurl = true, sp = p.gray },
    DiagnosticUnderlineOk        = { undercurl = true, sp = p.string },
    DiagnosticSignError          = { fg = p.red },
    DiagnosticSignWarn           = { fg = p.keyword },
    DiagnosticSignInfo           = { fg = p.constant },
    DiagnosticSignHint           = { fg = p.gray },
    DiagnosticSignOk             = { fg = p.string },
    DiagnosticVirtualTextError   = { fg = p.red },
    DiagnosticVirtualTextWarn    = { fg = p.keyword },
    DiagnosticVirtualTextInfo    = { fg = p.constant },
    DiagnosticVirtualTextHint    = { fg = p.gray },
    DiagnosticVirtualTextOk      = { fg = p.string },
    DiagnosticFloatingError      = { fg = p.red },
    DiagnosticFloatingWarn       = { fg = p.keyword },
    DiagnosticFloatingInfo       = { fg = p.constant },
    DiagnosticFloatingHint       = { fg = p.gray },
    DiagnosticFloatingOk         = { fg = p.string },
  }

  local lsp = {
    LspReferenceText            = { bg = p.bg_selection },
    LspReferenceRead            = { bg = p.bg_selection },
    LspReferenceWrite           = { bg = p.bg_selection },
    LspCodeLens                 = { fg = p.gray_dim },
    LspCodeLensSign             = { fg = p.gray_dim },
    LspSignatureActiveParameter = { fg = p.func, bg = p.bg_selection },
  }

  local spell = {
    SpellBad   = { undercurl = true, sp = p.red_bright },
    SpellCap   = { undercurl = true, sp = p.func },
    SpellLocal = { undercurl = true, sp = p.escape },
    SpellRare  = { undercurl = true, sp = p.constant },
  }

  local legacy = {
    LspDiagnosticsDefaultError          = { fg = p.red },
    LspDiagnosticsDefaultWarning        = { fg = p.keyword },
    LspDiagnosticsDefaultInformation    = { fg = p.constant },
    LspDiagnosticsDefaultHint           = { fg = p.gray },
    LspDiagnosticsUnderlineError        = { undercurl = true, sp = p.red },
    LspDiagnosticsUnderlineWarning      = { undercurl = true, sp = p.keyword },
    LspDiagnosticsUnderlineInformation  = { undercurl = true, sp = p.constant },
    LspDiagnosticsUnderlineHint         = { undercurl = true, sp = p.gray },
  }

  local treesitter = {
    ["@comment"]              = { fg = p.comment },
    ["@comment.error"]        = { fg = p.red },
    ["@comment.warning"]      = { fg = p.keyword },
    ["@comment.todo"]         = { fg = p.func },
    ["@comment.note"]         = { fg = p.constant },
    ["@comment.hint"]         = { fg = p.gray },
    ["@comment.documentation"] = { fg = p.comment },
    ["@error"]                = { fg = p.red_bright },
    ["@punctuation.delimiter"] = { fg = p.fg },
    ["@punctuation.bracket"]  = { fg = p.fg },
    ["@punctuation.special"]  = { fg = p.func },
    ["@string"]               = { fg = p.string },
    ["@string.escape"]        = { fg = p.escape },
    ["@string.regexp"]        = { fg = p.string },
    ["@string.special"]       = { fg = p.escape },
    ["@string.special.symbol"] = { fg = p.constant },
    ["@string.special.url"]   = { fg = p.constant, underline = true },
    ["@character"]            = { fg = p.string },
    ["@character.special"]    = { fg = p.escape },
    ["@number"]               = { fg = p.string },
    ["@number.float"]         = { fg = p.string },
    ["@boolean"]              = { fg = p.constant_b },
    ["@function"]             = { fg = p.func },
    ["@function.builtin"]     = { fg = p.red },
    ["@function.call"]        = { fg = p.func },
    ["@function.macro"]       = { fg = p.keyword },
    ["@function.method"]      = { fg = p.func },
    ["@function.method.call"] = { fg = p.func },
    ["@method"]               = { fg = p.func },
    ["@method.call"]          = { fg = p.func },
    ["@constructor"]          = { fg = p.func },
    ["@conditional"]          = { fg = p.keyword },
    ["@repeat"]               = { fg = p.keyword },
    ["@label"]                = { fg = p.func },
    ["@operator"]             = { fg = p.fg },
    ["@keyword"]              = { fg = p.keyword },
    ["@keyword.coroutine"]    = { fg = p.keyword },
    ["@keyword.function"]     = { fg = p.keyword },
    ["@keyword.operator"]     = { fg = p.keyword },
    ["@keyword.import"]       = { fg = p.keyword },
    ["@keyword.return"]       = { fg = p.keyword },
    ["@keyword.repeat"]       = { fg = p.keyword },
    ["@keyword.exception"]    = { fg = p.keyword },
    ["@keyword.type"]         = { fg = p.keyword },
    ["@keyword.storage"]      = { fg = p.keyword },
    ["@keyword.directive"]    = { fg = p.keyword },
    ["@keyword.debugger"]     = { fg = p.keyword },
    ["@exception"]            = { fg = p.keyword },
    ["@type"]                 = { fg = p.constant_b },
    ["@type.builtin"]         = { fg = p.constant_b },
    ["@type.definition"]      = { fg = p.white },
    ["@type.qualifier"]       = { fg = p.keyword },
    ["@storageclass"]         = { fg = p.keyword },
    ["@namespace"]            = { fg = p.white },
    ["@include"]              = { fg = p.keyword },
    ["@preproc"]              = { fg = p.keyword },
    ["@define"]               = { fg = p.keyword },
    ["@constant"]             = { fg = p.constant },
    ["@constant.builtin"]     = { fg = p.constant_b },
    ["@constant.macro"]       = { fg = p.red },
    ["@variable"]             = { fg = p.variable },
    ["@variable.builtin"]     = { fg = p.variable },
    ["@variable.member"]      = { fg = p.fg },
    ["@variable.parameter"]   = { fg = p.fg },
    ["@variable.special"]     = { fg = p.variable },
    ["@property"]             = { fg = p.fg },
    ["@field"]                = { fg = p.fg },
    ["@parameter"]            = { fg = p.fg },
    ["@argument"]             = { fg = p.fg },
    ["@attribute"]            = { fg = p.keyword },
    ["@annotation"]           = { fg = p.func },
    ["@tag"]                  = { fg = p.tag },
    ["@tag.attribute"]        = { fg = p.tag },
    ["@tag.delimiter"]        = { fg = p.tag },
  }

  local markup = {
    ["@text"]                    = { fg = p.fg },
    ["@text.strong"]             = { fg = p.fg, bold = true },
    ["@text.emphasis"]           = { fg = p.fg },
    ["@text.underline"]          = { underline = true },
    ["@text.strike"]             = { strikethrough = true },
    ["@text.title"]              = { fg = p.func, bold = true },
    ["@text.literal"]            = { fg = p.string },
    ["@text.uri"]                = { fg = p.constant, underline = true },
    ["@text.link"]               = { fg = p.constant, underline = true },
    ["@text.reference"]          = { fg = p.comment },
    ["@text.math"]               = { fg = p.constant },
    ["@text.environment"]        = { fg = p.constant_b },
    ["@text.environment.name"]   = { fg = p.red },
    ["@text.todo"]               = { fg = p.func },
    ["@text.note"]               = { fg = p.tag },
    ["@text.warning"]            = { fg = p.keyword },
    ["@text.danger"]             = { fg = p.red },
    ["@markup.heading"]          = { fg = p.func, bold = true },
    ["@markup.strong"]           = { fg = p.fg, bold = true },
    ["@markup.italic"]           = { fg = p.fg },
    ["@markup.strikethrough"]    = { strikethrough = true },
    ["@markup.underline"]        = { underline = true },
    ["@markup.link.url"]         = { fg = p.constant, underline = true },
    ["@markup.link.label"]       = { fg = p.tag },
    ["@markup.list"]             = { fg = p.keyword },
    ["@markup.list.checked"]     = { fg = p.string },
    ["@markup.list.unchecked"]   = { fg = p.gray },
    ["@markup.raw"]              = { fg = p.string },
    ["@markup.inline"]           = { fg = p.string },
    ["@markup.quote"]            = { fg = p.comment },
    ["@markup.math"]             = { fg = p.constant },
    ["@markup.environment"]      = { fg = p.constant_b },
    ["@markup.environment.name"] = { fg = p.red },
    ["@markup.code"]             = { fg = p.string },
    ["@markup.error"]            = { fg = p.red_bright, bold = true },
    ["@markup.delimiter"]        = { fg = p.gray_dim },
    ["@diff.plus"]               = { fg = p.green_bright },
    ["@diff.minus"]              = { fg = p.red_bright },
    ["@diff.delta"]              = { fg = p.violet },
    ["@diff.differ"]             = { fg = p.red },
  }

  for _, section in pairs({ editor, messages, popup, statusline, syntax, diff, vcs, diagnostics, lsp, spell, legacy }) do
    for group, spec in pairs(section) do
      hl(group, spec)
    end
  end

  for group, spec in pairs(treesitter) do
    hl(group, spec)
  end

  for group, spec in pairs(markup) do
    hl(group, spec)
  end

  if config.terminal then
    local terminal = {
      ["0"] = p.bg, ["1"] = p.red, ["2"] = p.string, ["3"] = p.func,
      ["4"] = p.constant, ["5"] = p.keyword, ["6"] = p.escape, ["7"] = p.fg,
      ["8"] = p.gray_dim, ["9"] = p.red_bright, ["10"] = p.green_bright,
      ["11"] = p.tag, ["12"] = p.constant_b, ["13"] = p.variable,
      ["14"] = p.violet, ["15"] = p.white,
    }
    for idx, color in pairs(terminal) do
      vim.g["terminal_color_" .. idx] = color
    end
  end

  local italic_groups = {
    "Comment", "SpecialComment", "Folded",
    "@comment", "@comment.documentation", "@comment.todo",
    "@comment.error", "@comment.warning", "@comment.note", "@comment.hint",
    "@text.note", "@markup.quote",
  }

  for _, name in ipairs(italic_groups) do
    local ok, g = pcall(vim.api.nvim_get_hl, 0, { name = name })
    if ok and next(g) then
      g.italic = config.italic
      vim.api.nvim_set_hl(0, name, g)
    end
  end
end

function M.load(opts)
  M.setup(opts)
  apply()
end

return M
