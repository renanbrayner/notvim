-- Configuração do git-blame.nvim
require('gitblame').setup {
  enabled = true,
  highlight_group = 'GitBlameVirtualText',  -- Usar nosso highlight customizado
  message_template = ' <summary> • <date> • <author> • <<sha>>',
  date_format = '%m-%d-%Y %H:%M:%S',
  virtual_text_column = 1,
  ignored_filetypes = {
    'NvimTree',
    'CHADTree',
    'alpha',
    'dashboard',
    'floaterm',
    'TelescopePrompt',
    'gitcommit',
    'gitrebase',
  },
  delay = 200,
}

-- Git-blame apenas em normal mode
local augroup = vim.api.nvim_create_augroup('GitBlameModeControl', { clear = true })

vim.api.nvim_create_autocmd('ModeChanged', {
  group = augroup,
  callback = function()
    if vim.fn.mode() == 'n' then
      require('gitblame').enable()
    else
      require('gitblame').disable()
    end
  end,
})