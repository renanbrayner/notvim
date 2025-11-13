local loader = require('utils.loader')

local autopairs_config = {
  check_ts = true,
  ts_config = {
    lua = { 'string' }, -- it will not add a pair on that treesitter node
    javascript = { 'template_string' },
    java = false, -- don't check treesitter on java
  },
}

local npairs = loader.safe_require('nvim-autopairs')
if not npairs then
  return
end

npairs.setup(autopairs_config)

local Rule = loader.safe_require('nvim-autopairs.rule', true) -- silent
local ts_conds = loader.safe_require('nvim-autopairs.ts-conds', true) -- silent

if Rule and ts_conds then
  npairs.add_rules {
    Rule('%', '%', 'lua'):with_pair(ts_conds.is_ts_node { 'string', 'comment' }),
    Rule('$', '$', 'lua'):with_pair(ts_conds.is_not_ts_node { 'function' }),
  }
end
