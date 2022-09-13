require("nvim-surround").setup({
  keymaps = {
    insert = "<C-g>s",
    insert_line = "<C-g>S",
    normal = "Ys",
    normal_cur = "Yss",
    normal_line = "YS",
    normal_cur_line = "YSS",
    visual = "S",
    visual_line = "gS",
    delete = "Yds",
    change = "Ycs",
  },
})
