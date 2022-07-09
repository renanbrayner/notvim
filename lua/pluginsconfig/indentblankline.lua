vim.g.indent_blankline_filetype_exclude = {
    'alpha',
    'coc-explorer',
    'help',
    'packer',
    'NvimTree',
    'lsp-installer',
    'lspinfo',
    'toggleterm'
}

require("indent_blankline").setup {
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}
