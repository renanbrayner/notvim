local colors = require("rice.init")
require("scrollbar").setup({
  handle = {
    color = colors.darker,
  },
  marks = {
    Search = {
      text = { "━", "═" },
      priority = 0,
      color = nil,
      cterm = nil,
      highlight = "Search",
    },
    Error = {
      text = { "━", "═" },
      priority = 1,
      color = nil,
      cterm = nil,
      highlight = "DiagnosticVirtualTextError",
    },
    Warn = {
      text = { "━", "═" },
      priority = 2,
      color = nil,
      cterm = nil,
      highlight = "DiagnosticVirtualTextWarn",
    },
    Info = {
      text = { "━", "═" },
      priority = 3,
      color = nil,
      cterm = nil,
      highlight = "DiagnosticVirtualTextInfo",
    },
    Hint = {
      text = { "━", "═" },
      priority = 4,
      color = nil,
      cterm = nil,
      highlight = "DiagnosticVirtualTextHint",
    },
    Misc = {
      text = { "━", "═" },
      priority = 5,
      color = nil,
      cterm = nil,
      highlight = "Normal",
    },
  },
})
require("scrollbar.handlers.search").setup({
  nearest_only = true,
})
