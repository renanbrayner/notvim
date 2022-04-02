local create = vim.highlight.create
local link = vim.highlight.link
local set = vim.opt

-- ATTENTION! If you are using the rest of my dotfiles there is a script called rice-ctrl
-- with rice-ctrl --set-theme-dracula or rice-ctrl --set-theme-gruvbox you can change
-- not just the nvim theme but also the xmobar, xmonad borders, alacritty etc
-- TODO: rice nord theme ans solarized theme

-- vim.cmd"colorscheme nord" -- SED_NORD
-- vim.cmd"colorscheme dracula" -- SED_DRACULA
-- vim.cmd"colorscheme gruvbox" -- SED_GRUVBOX
vim.cmd"colorscheme solarized" -- SED_SOLARIZED

vim.cmd([[
    if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
  ]])

set.cursorline = true
set.showmode = false
set.termguicolors = true

-- Meaning of terms:
--
-- format: "Buffer" + status + part
--
-- status:
--     *Current: current buffer
--     *Visible: visible but not current buffer
--    *Inactive: invisible but not current buffer
--
-- part:
--        *Icon: filetype icon
--       *Index: buffer index
--         *Mod: when modified
--        *Sign: the separator between buffers
--      *Target: letter in buffer-picking mode
--
-- BufferTabpages: tabpage indicator
-- BufferTabpageFill: filler after the buffer section
-- BufferOffset: offset section, created with set_offset()

local colors = {}

if vim.g.colors_name == "dracula" then
  colors = {
    fr = "#f8f8f2",
    cmt = "#6272a4",
    cya = "#8be9fd",
    grn = "#50fa7b",
    org = "#ffb86c",
    pnk = "#ff79c6",
    pur = "#bd93f9",
    red = "#ff5555",
    ylw = "#f1fa8c",
    -- These are different from the original
    bg = "#282a37",
    curli = "#363847",
    ntxt = "#44475a",
    dark = "#21222c",
    darker = "#1c1d26",
  }
elseif vim.g.colors_name == "gruvbox" then
  colors = {
    fr = "#ebdbb2",
    cmt = "#928374",
    cya = "#458588",
    grn = "#98971a",
    org = "#d65d0e",
    pnk = "#ff79c6", -- TODO: change this color
    pur = "#b16286",
    red = "#cc241d",
    ylw = "#d79921",
    bg = "#282828",
    curli = "#3c3836",
    ntxt = "#504945",
    dark = "#232425",
    darker = "#1d2021",
  }
elseif vim.g.colors_name == "solarized" then
  colors = {
    fr = "#839496",
    cmt = "#586e75",
    cya = "#2aa198",
    grn = "#859900",
    org = "#cb4b16",
    pnk = "#d33682",
    pur = "#6c71c4",
    red = "#dc322f",
    ylw = "#b58900",
    bg = "#002b36",
    curli = "#073642",
    ntxt = "#657b83",
    dark = "#00252e",
    darker = "#002129",
  }
else
  colors = {
    fr = "#f8f8f2",
    cmt = "#6272a4",
    cya = "#8be9fd",
    grn = "#50fa7b",
    org = "#ffb86c",
    pnk = "#ff79c6",
    pur = "#bd93f9",
    red = "#ff5555",
    ylw = "#f1fa8c",
    bg = "#282a37",
    curli = "#363847",
    ntxt = "#44475a",
    dark = "#21222c",
    darker = "#1c1d26",
  }
end

if vim.g.colors_name == "dracula" then
  -- General configs
  create("NonText", { guifg = colors.ntxt }, false)
  create("CursorLine", { guibg = colors.curli }, false)
  create("Normal", { guibg = colors.bg }, false)
  create("EndOfBuffer", { guifg = colors.bg }, false) --remove end of buffer ~
  -- create('VertSplit', { guibg=colors.bg, guifg=colors.bg }, false)

  -- Indent lines
  create("IndentBlanklineIndent1", { guifg = "#7e444f", gui = "nocombine" }, false)
  create("IndentBlanklineIndent2", { guifg = "#816e52", gui = "nocombine" }, false)
  create("IndentBlanklineIndent3", { guifg = "#5a7051", gui = "nocombine" }, false)
  create("IndentBlanklineIndent4", { guifg = "#396975", gui = "nocombine" }, false)
  create("IndentBlanklineIndent5", { guifg = "#3f668c", gui = "nocombine" }, false)
  create("IndentBlanklineIndent6", { guifg = "#714a83", gui = "nocombine" }, false)

  -- Barbar
  create("BufferTabpageFill", { guibg = colors.darker, guifg = colors.darker }, true)
  create("BufferInactive", { guibg = colors.dark, guifg = colors.ntxt }, true)
  create("BufferInactiveSign", { guibg = colors.dark, guifg = colors.dark })
  create("BufferInactiveMod", { guibg = colors.dark, guifg = colors.ylw }, false)
  create("BufferVisible", { guifg = colors.cmt })
  create("BufferVisibleSign", { guibg = colors.bg, guifg = colors.bg })
  create("BufferVisibleMod", { guifg = colors.ylw }, false)
  create("BufferCurrentSign", { guibg = colors.bg, guifg = colors.bg })
  create("BufferCurrentMod", { guifg = colors.org }, false)

  -- NvimTree
  create("NvimTreeNormal", { guibg = colors.darker }, false)
  create("NvimTreeVertSplit", { guibg = colors.darker }, false)
  create("NvimTreeEndOfBuffer", { guifg = colors.darker }, false)

  -- Git symbols at the side
  create("SignifySignDelete", { guifg = colors.red, gui = "NONE" })

elseif vim.g.colors_name == "gruvbox" then
  -- Indent lines
  create("IndentBlanklineIndent1", { guifg = "#864b4f", gui = "nocombine" }, false)
  create("IndentBlanklineIndent2", { guifg = "#887652", gui = "nocombine" }, false)
  create("IndentBlanklineIndent3", { guifg = "#617751", gui = "nocombine" }, false)
  create("IndentBlanklineIndent4", { guifg = "#3f7077", gui = "nocombine" }, false)
  create("IndentBlanklineIndent5", { guifg = "#456d8d", gui = "nocombine" }, false)
  create("IndentBlanklineIndent6", { guifg = "#795184", gui = "nocombine" }, false)

  -- barbar
  create("BufferTabpageFill", { guibg = colors.darker, guifg = colors.darker }, true)
  create("BufferInactive", { guibg = colors.dark, guifg = colors.ntxt }, true)
  create("BufferInactiveSign", { guibg = colors.dark, guifg = colors.dark })
  create("BufferInactiveMod", { guibg = colors.dark, guifg = colors.ylw }, false)
  create("BufferVisible", { guifg = colors.cmt })
  create("BufferVisibleSign", { guibg = colors.bg, guifg = colors.bg })
  create("BufferVisibleMod", { guifg = colors.ylw }, false)
  create("BufferCurrentSign", { guibg = colors.bg, guifg = colors.bg })
  create("BufferCurrentMod", { guifg = colors.org }, false)

  -- nvimtree
  create("NvimTreeNormal", { guibg = colors.darker }, false)
  create("NvimTreeVertSplit", { guibg = colors.darker }, false)
  create("NvimTreeEndOfBuffer", { guifg = colors.darker }, false)


  -- cleaner visual
  create("EndOfBuffer", { guifg = colors.bg }, false) --remove end of buffer ~
  link("SignColumn", "Normal", true)
elseif vim.g.colors_name == "solarized" then
  create("IndentBlanklineIndent1", { guifg = "#6e2f33", gui = "nocombine" }, false)
  create("IndentBlanklineIndent2", { guifg = "#5b5a1b", gui = "nocombine" }, false)
  create("IndentBlanklineIndent3", { guifg = "#43621b", gui = "nocombine" }, false)
  create("IndentBlanklineIndent4", { guifg = "#156667", gui = "nocombine" }, false)
  create("IndentBlanklineIndent5", { guifg = "#364e7d", gui = "nocombine" }, false)
  create("IndentBlanklineIndent6", { guifg = "#6a315c", gui = "nocombine" }, false)

  -- barbar
  create("BufferTabpageFill", { guibg = colors.darker, guifg = colors.darker }, true)
  create("BufferInactive", { guibg = colors.dark, guifg = colors.ntxt }, true)
  create("BufferInactiveSign", { guibg = colors.dark, guifg = colors.dark })
  create("BufferInactiveMod", { guibg = colors.dark, guifg = colors.ylw }, false)
  create("BufferVisible", { guifg = colors.cmt })
  create("BufferVisibleSign", { guibg = colors.bg, guifg = colors.bg })
  create("BufferVisibleMod", { guifg = colors.ylw }, false)
  create("BufferCurrentSign", { guibg = colors.bg, guifg = colors.bg })
  create("BufferCurrentMod", { guifg = colors.org }, false)

  -- nvimtree
  create("NvimTreeNormal", { guibg = colors.darker }, false)
  create("NvimTreeVertSplit", { guibg = colors.darker }, false)
  create("NvimTreeEndOfBuffer", { guifg = colors.darker }, false)

  -- cleaner visual
  create("EndOfBuffer", { guifg = colors.bg }, false) --remove end of buffer ~
  create("LineNr", { guibg = colors.bg }, false)
else
  create("IndentBlanklineIndent1", { guifg = "#E06C75", gui = "nocombine" }, false)
  create("IndentBlanklineIndent2", { guifg = "#E5C07B", gui = "nocombine" }, false)
  create("IndentBlanklineIndent3", { guifg = "#98C379", gui = "nocombine" }, false)
  create("IndentBlanklineIndent4", { guifg = "#56B6C2", gui = "nocombine" }, false)
  create("IndentBlanklineIndent5", { guifg = "#61AFEF", gui = "nocombine" }, false)
  create("IndentBlanklineIndent6", { guifg = "#C678DD", gui = "nocombine" }, false)

  -- cleaner visual
  create("EndOfBuffer", { guifg = colors.bg }, false) --remove end of buffer ~
end

-- Every theme
-- Fzf (SpellLocal = orange)
vim.g["fzf_colors"] = {
  ["fg+"] = { "fg", "Normal", "CursorColumn", "Normal" },
  ["bg+"] = { "bg", "Normal", "CursorColumn" },
  ["hl+"] = { "fg", "SpellLocal" },
  fg = { "fg", "Normal" },
  bg = { "bg", "Normal" },
  hl = { "fg", "Function" },
  info = { "fg", "PreProc" },
  border = { "fg", "Comment" },
  prompt = { "fg", "Function" },
  pointer = { "fg", "Exception" },
  marker = { "fg", "Keyword" },
  spinner = { "fg", "Label" },
  header = { "fg", "Comment" },
}

-- QuickScope colors
  link("QuickScopeSecondary", "healthWarning", true)
  link("QuickScopePrimary", "healthSuccess", true)
