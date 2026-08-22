local kind_icons = {
  Text = '󰊄',
  Method = ' ',
  Function = '󰊕',
  Constructor = ' ',
  Field = ' ',
  Variable = ' ',
  Class = ' ',
  Interface = ' ',
  Module = ' ',
  Property = ' ',
  Unit = '󰺾 ',
  Value = '󰘦 ',
  Enum = ' ',
  Keyword = ' ',
  Snippet = ' ',
  Color = ' ',
  File = ' ',
  Reference = ' ',
  Folder = ' ',
  EnumMember = ' ',
  Constant = ' ',
  Struct = ' ',
  Event = '',
  Operator = ' ',
  TypeParameter = ' ',
}

vim.g.coq_settings = {
  -- auto_start removido no coq v2
  display = {
    ['ghost_text.context'] = { '  ❬ ', ' ❭ ' },
    pum = {
      -- fast_close removido no coq v2
      -- kind_context removido no coq v2
      source_context = { '⌈ ', ' ⌋' },
    },
    icons = {
      mappings = kind_icons,
      -- aliases = kind_aliases,
    },
  },
  -- keymap removido no v2 (jump_to_mark e repeat foram removidos);
  -- jump_to_mark tem bind manual abaixo usando vim.snippet.jump
}

vim.keymap.set({ 'i', 's' }, '<c-b>', function()
  if vim.snippet and vim.snippet.jump then
    vim.snippet.jump(1)
  end
end, { silent = true, desc = 'coq: jump to next mark' })
