# railscasts.nvim

A dark Neovim colorscheme ported from the [RailsCasts Colour Scheme][original]
for Sublime Text / TextMate by Ryan Bates.

## Features

- Faithful port of the original `.tmTheme` colour values.
- Full support for `:h treesitter` highlight groups, diagnostics and LSP
  highlighting, `popup-menu`, `statusline`, `tabline`, diff / git sign and
  spell groups.
- Optional transparent background and configurable italics.
- No external dependencies (pure Lua, requires Neovim `>= 0.8`).

## Installation

Requires `termguicolors` for the true colour values to show correctly:

```lua
vim.opt.termguicolors = true
```

### lazy.nvim

```lua
{ "kaloyanm/railscasts-nvim", name = "railscasts", lazy = false, priority = 1000,
  config = function()
    vim.cmd.colorscheme("railscasts")
  end,
}
```

### LazyVim

LazyVim auto-imports every spec file in `lua/plugins/`. Put the plugin in
`lua/plugins/theme.lua` (replacing the active theme) and point LazyVim's
`colorscheme` option at it.

From GitHub:

```lua
return {
  {
    "kaloyanm/railscasts-nvim",
    name = "railscasts",
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "railscasts",
    },
  },
}
```

From a local checkout (no clone required):

```lua
return {
  {
    dir = "/path/to/railscasts-nvim-theme",
    name = "railscasts",
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "railscasts",
    },
  },
}
```

Keep only one file that sets `opts.colorscheme`, otherwise themes will fight
over the active one.

### packer.nvim

```lua
use({ "kaloyanm/railscasts-nvim", config = function()
  vim.cmd.colorscheme("railscasts")
end })
```

### Manual

Copy the `colors/` and `lua/` directories into your `~/.config/nvim/` and run:

```vim
colorscheme railscasts
```

## Options

Options can be passed through the global `g:railscasts` table before the
colorscheme is loaded:

```lua
vim.g.railscasts = {
  transparent = false, -- use the terminal background for Normal
  italic      = true,  -- italic comments / markup quotes
  terminal   = true,   -- set g:terminal_color_* palette
}
```

## Palette

| Colour     | Hex       | Usage                                |
| ---------- | --------- | ------------------------------------ |
| Background | `#282828` | editor background                    |
| Foreground | `#E6E1DC` | default text                         |
| Comment    | `#BC9458` | comments (italic)                    |
| Keyword    | `#CC7833` | keywords, storage, preprocessor      |
| Function   | `#FFC66D` | function names / definitions         |
| String     | `#A5C261` | strings, numbers                     |
| Constant   | `#6D9CBE` | constants, types                     |
| Variable   | `#D0D0FF` | variables                            |
| Tag        | `#E8BF6A` | markup tags / attributes             |
| Escape     | `#519F50` | string escapes, interpolation        |
| Red        | `#DA4939` | support functions, constant variables|
| Selection  | `#3D4456` | visual / selection                   |

## License

RailsCasts Colour Scheme is licensed under the
[Creative Commons Attribution-ShareAlike 3.0 License][license]. Based on
RailsCasts Theme by Ryan Bates (http://railscasts.com/).

[original]: https://github.com/tdm00/sublime-theme-railscasts
[license]: http://creativecommons.org/licenses/by-sa/3.0/
