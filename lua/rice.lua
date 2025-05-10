local highlight = vim.api.nvim_set_hl
local link = vim.hl.link
local set = vim.opt

-- ATTENTION! If you are using the rest of my dotfiles there is a script called rice-ctrl
-- with rice-ctrl you can change the theme by running the command rice-ctrl --set-theme-name where name is the name of the theme

-- THEME_START
vim.cmd 'colorscheme dracula'
-- THEME_END

vim.cmd [[
    if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
  ]]

set.cursorline = true
set.showmode = false
set.termguicolors = true

-- TODO: remove all these "ifs" and use the rice-ctrl script ???

local colors = {}

if vim.g.colors_name == 'dracula' then
  colors = {
    fr = '#f8f8f2',
    cmt = '#6272a4',
    cya = '#8be9fd',
    grn = '#50fa7b',
    org = '#ffb86c',
    pnk = '#ff79c6',
    pur = '#bd93f9',
    red = '#ff5555',
    ylw = '#f1fa8c',
    -- These are different from the original
    curli = '#363847',
    bg = '#282a37',
    ntxt = '#44475a',
    dark = '#21222c',
    darker = '#1c1d26',
  }
elseif vim.g.colors_name == 'gruvbox' then
  colors = {
    fr = '#ebdbb2',
    cmt = '#928374',
    cya = '#458588',
    grn = '#98971a',
    org = '#d65d0e',
    pnk = '#ff79c6', -- TODO: change this color
    pur = '#b16286',
    red = '#cc241d',
    ylw = '#d79921',
    bg = '#282828',
    curli = '#3c3836',
    ntxt = '#504945',
    dark = '#232425',
    darker = '#1d2021',
  }
elseif vim.g.colors_name == 'solarized' then
  colors = {
    fr = '#839496',
    cmt = '#586e75',
    cya = '#2aa198',
    grn = '#859900',
    org = '#cb4b16',
    pnk = '#d33682',
    pur = '#6c71c4',
    red = '#dc322f',
    ylw = '#b58900',
    bg = '#002b36',
    curli = '#073642',
    ntxt = '#657b83',
    dark = '#00252e',
    darker = '#002129',
  }
elseif vim.g.colors_name == 'nord' then
  colors = {
    fr = '#D8DEE9',
    cmt = '#616e88',
    cya = '#88C0D0',
    grn = '#A3BE8C',
    org = '#D08770',
    pnk = '#cf638b',
    pur = '#B48EAD',
    red = '#BF616A',
    ylw = '#EBCB8B',
    bg = '#2e3440',
    curli = '#3b4252',
    ntxt = '#485164',
    dark = '#242a33',
    darker = '#21252e',
  }
else
  colors = {
    fr = '#f8f8f2',
    cmt = '#6272a4',
    cya = '#8be9fd',
    grn = '#50fa7b',
    org = '#ffb86c',
    pnk = '#ff79c6',
    pur = '#bd93f9',
    red = '#ff5555',
    ylw = '#f1fa8c',
    bg = '#282a37',
    curli = '#363847',
    ntxt = '#44475a',
    dark = '#21222c',
    darker = '#1c1d26',
  }
end

-- All themes (can be overridden)
highlight(0, 'NvimTreeNormal', { bg = colors.darker })
highlight(0, 'NvimTreeVertSplit', { bg = colors.darker })
highlight(0, 'NvimTreeEndOfBuffer', { fg = colors.darker })

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

highlight(0, 'rainbowcol1', { fg = colors.red })
highlight(0, 'rainbowcol2', { fg = colors.org })
highlight(0, 'rainbowcol3', { fg = colors.ylw })
highlight(0, 'rainbowcol4', { fg = colors.grn })
highlight(0, 'rainbowcol5', { fg = colors.cya })
highlight(0, 'rainbowcol6', { fg = colors.pur })
highlight(0, 'rainbowcol7', { fg = colors.pnk })

highlight(0, 'BufferTabpageFill', { bg = colors.darker, fg = colors.darker })
highlight(0, 'BufferInactive', { bg = colors.dark, fg = colors.ntxt })
highlight(0, 'BufferInactiveSign', { bg = colors.dark, fg = colors.dark })
highlight(0, 'BufferInactiveMod', { bg = colors.dark, fg = colors.ylw })
highlight(0, 'BufferVisible', { fg = colors.cmt })
highlight(0, 'BufferVisibleSign', { bg = colors.bg, fg = colors.bg })
highlight(0, 'BufferVisibleMod', { fg = colors.ylw })
highlight(0, 'BufferCurrent', { fg = colors.fg, bg = colors.bg })
highlight(0, 'BufferCurrentSign', { bg = colors.bg, fg = colors.bg })
highlight(0, 'BufferCurrentMod', { fg = colors.org })

highlight(0, 'QuickScopeSecondary', { link = 'healthWarning' })
highlight(0, 'QuickScopePrimary', { link = 'healthSuccess' })

if vim.g.colors_name == 'dracula' then
  -- General configs
  highlight(0, 'NonText', { fg = colors.ntxt })
  highlight(0, 'CursorLine', { bg = colors.curli })
  highlight(0, 'Normal', { bg = colors.bg })
  highlight(0, 'EndOfBuffer', { fg = colors.bg }) --remove end of buffer ~
  -- create(0, 'VertSplit', { bg=colors.bg, fg=colors.bg })

  -- Indent lines
  highlight(0, 'IndentBlanklineIndent1', { fg = '#7e444f' })
  highlight(0, 'IndentBlanklineIndent2', { fg = '#816e52' })
  highlight(0, 'IndentBlanklineIndent3', { fg = '#5a7051' })
  highlight(0, 'IndentBlanklineIndent4', { fg = '#396975' })
  highlight(0, 'IndentBlanklineIndent5', { fg = '#3f668c' })
  highlight(0, 'IndentBlanklineIndent6', { fg = '#714a83' })

  -- Git symbols at the side
  highlight(0, 'SignifySignDelete', { fg = colors.red })
elseif vim.g.colors_name == 'gruvbox' then
  -- Indent lines
  highlight(0, 'IndentBlanklineIndent1', { fg = '#864b4f' })
  highlight(0, 'IndentBlanklineIndent2', { fg = '#887652' })
  highlight(0, 'IndentBlanklineIndent3', { fg = '#617751' })
  highlight(0, 'IndentBlanklineIndent4', { fg = '#3f7077' })
  highlight(0, 'IndentBlanklineIndent5', { fg = '#456d8d' })
  highlight(0, 'IndentBlanklineIndent6', { fg = '#795184' })

  -- cleaner visual
  highlight(0, 'EndOfBuffer', { fg = colors.bg }) --remove end of buffer ~
  highlight(0, 'SignColumn', { link = 'Normal' })
elseif vim.g.colors_name == 'solarized' then
  highlight(0, 'IndentBlanklineContextChar', { fg = '#b1cc00' })
  highlight(0, 'IndentBlanklineIndent1', { fg = '#6e2f33' })
  highlight(0, 'IndentBlanklineIndent2', { fg = '#5b5a1b' })
  highlight(0, 'IndentBlanklineIndent3', { fg = '#43621b' })
  highlight(0, 'IndentBlanklineIndent4', { fg = '#156667' })
  highlight(0, 'IndentBlanklineIndent5', { fg = '#364e7d' })
  highlight(0, 'IndentBlanklineIndent6', { fg = '#6a315c' })

  -- quickscope colors
  highlight(0, 'QuickScopeSecondary', { link = 'ReplaceMode' })
  highlight(0, 'QuickScopePrimary', { link = 'InsertMode' })

  -- cleaner visual
  highlight(0, 'EndOfBuffer', { fg = colors.bg }) --remove end of buffer ~
  highlight(0, 'LineNr', { bg = colors.bg })
  highlight(0, 'GitSignsChange', { bg = colors.bg, fg = colors.ylw })
  highlight(0, 'GitSignsAdd', { bg = colors.bg, fg = colors.grn })
  highlight(0, 'GitSignsDelete', { bg = colors.bg, fg = colors.red })
elseif vim.g.colors_name == 'nord' then
  highlight(0, 'NonText', { fg = colors.ntxt })

  highlight(0, 'IndentBlanklineIndent1', { fg = '#774b55' })
  highlight(0, 'IndentBlanklineIndent2', { fg = '#7f5e58' })
  highlight(0, 'IndentBlanklineIndent3', { fg = '#8d8066' })
  highlight(0, 'IndentBlanklineIndent4', { fg = '#697966' })
  highlight(0, 'IndentBlanklineIndent5', { fg = '#5b7a88' })
  highlight(0, 'IndentBlanklineIndent6', { fg = '#716177' })

  highlight(0, 'Folded', { link = 'Visual' })

  vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = '#88C0D0' })

  highlight(0, 'VertSplit', { bg = colors.bg, fg = colors.curli })

  highlight(0, 'QuickScopeSecondary', { link = 'LeapLabelPrimary' })
  highlight(0, 'QuickScopePrimary', { link = 'LeapLabelPrimary' })

  highlight(0, 'EndOfBuffer', { fg = colors.bg }) --remove end of buffer ~
else
  highlight(0, 'IndentBlanklineIndent1', { fg = '#E06C75' })
  highlight(0, 'IndentBlanklineIndent2', { fg = '#E5C07B' })
  highlight(0, 'IndentBlanklineIndent3', { fg = '#98C379' })
  highlight(0, 'IndentBlanklineIndent4', { fg = '#56B6C2' })
  highlight(0, 'IndentBlanklineIndent5', { fg = '#61AFEF' })
  highlight(0, 'IndentBlanklineIndent6', { fg = '#C678DD' })

  -- cleaner visual
  highlight(0, 'EndOfBuffer', { fg = colors.bg })
end

-- Every theme
-- Fzf (SpellLocal = orange)
vim.g['fzf_colors'] = {
  ['fg+'] = { 'fg', 'Normal', 'CursorColumn', 'Normal' },
  ['bg+'] = { 'bg', 'Normal', 'CursorColumn' },
  ['hl+'] = { 'fg', 'SpellLocal' },
  fg = { 'fg', 'Normal' },
  bg = { 'bg', 'Normal' },
  hl = { 'fg', 'Function' },
  info = { 'fg', 'PreProc' },
  border = { 'fg', 'Comment' },
  prompt = { 'fg', 'Function' },
  pointer = { 'fg', 'Exception' },
  marker = { 'fg', 'Keyword' },
  spinner = { 'fg', 'Label' },
  header = { 'fg', 'Comment' },
}

return colors
