local loader = require('utils.loader')

local languages = {
  'javascript',
  'typescript',
  'tsx',
  'vue',
  'html',
  'css',
  'scss',
  'astro',
  'svelte',
  'rust',
  'python',
  'c',
  'cpp',
  'c_sharp',
  'go',
  'java',
  'kotlin',
  'dart',
  'haskell',
  'ocaml',
  'elixir',
  'fsharp',
  'lua',
  'bash',
  'fish',
  'nu',
  'json',
  'toml',
  'yaml',
  'dockerfile',
  'markdown',
  'xml',
  'sql',
  'graphql',
  'regex',
  'comment',
  'gitignore',
  'gitcommit',
  'http',
  'diff',
}

-- Setup do nvim-treesitter (nova API minimalista — branch main)
loader.safe_setup('nvim-treesitter', {
  install_dir = vim.fn.stdpath('data') .. '/site',
})

-- Instala parsers em background na primeira inicialização / em :TSUpdate
vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    require('nvim-treesitter').install(vim.list_extend({}, languages))
  end,
})

-- Ativa syntax highlighting via Neovim nativo (queries vêm do runtimepath do nvim-treesitter)
vim.api.nvim_create_autocmd('FileType', {
  pattern = languages,
  callback = function(args)
    pcall(vim.treesitter.start, nil, args.buf)
  end,
})
