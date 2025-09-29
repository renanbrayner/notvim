local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  vim.notify('Error requiring nvim-treesitter.configs', vim.log.levels.ERROR)
end

treesitter.setup {
  ensure_installed = {
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
  },
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { '' }, -- List of parsers to ignore installing
  autotag = {
    enable = true,
  },
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { 'sass', 'scss', 'css', 'yaml' }, -- list of language that will be disabled, sass, scss and css had errors with me
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { 'yaml' } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  rainbow = {
    enable = false,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  },
}
