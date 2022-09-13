local autopairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
autopairs.setup({
  check_ts = true,
  enable_check_bracket_line = true,
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "Search",
    highlight_grey = "Comment",
  },
  ts_config = {
    lua = { "string" }, -- it will not add a pair on that treesitter node
    javascript = { "template_string" },
    java = false, -- don't check treesitter on java
  },
})

local ts_conditionals = require("nvim-autopairs.ts-conds")
autopairs.add_rules({
  Rule("%", "%", "lua"):with_pair(ts_conditionals.is_ts_node({ "string", "comment" })),
  Rule("$", "$", "lua"):with_pair(ts_conditionals.is_not_ts_node({ "function" })),
})
