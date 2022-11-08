local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  vim.notify('Error requiring nvim-treesitter.configs', error)
end

treesitter.setup {
  ensure_installed = 'all', -- one of "all", "maintained" (parsers with maintainers), or a list of languages
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
    disable = { 'sass', 'scss', 'css', 'yaml', 'svelte' }, -- list of language that will be disabled, sass, scss and css had errors with me
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
