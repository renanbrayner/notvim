local null_ls_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_ok then
  vim.notify('Error requiring null-ls', vim.log.levels.ERROR)
  return
end

-- Usando require direto para os builtins (padrão moderno)
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

-- Carregar ESLint do none-ls-extras
local eslint_diagnostics = require 'none-ls.diagnostics.eslint'
local eslint_code_actions = require 'none-ls.code_actions.eslint'

local sources = {
  -- Prettier formatter
  formatting.prettier.with {
    command = 'node_modules/.bin/prettier',
    extra_args = function(params)
      return { '--stdin-filepath', params.filename }
    end,
    filetypes = {
      'html',
      'markdown',
      'css',
      'scss',
      'less',
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'vue',
      'json',
      'yaml',
      'graphql',
    },
  },

  -- ESLint diagnostics usando none-ls-extras
  eslint_diagnostics.with {
    command = 'node_modules/.bin/eslint',
    filetypes = { 'javascript', 'typescript', 'vue' },
  },

  -- ESLint code actions usando none-ls-extras
  eslint_code_actions.with {
    command = 'node_modules/.bin/eslint',
  },

  -- Other formatters (commented out if not installed)
  formatting.stylua,
  formatting.black,

  -- Shellcheck diagnostics and code actions
  (function()
    local shellcheck_diagnostics_ok, shellcheck_diagnostics = pcall(require, 'none-ls-shellcheck.diagnostics')
    if shellcheck_diagnostics_ok then
      return shellcheck_diagnostics
    else
      vim.notify('Error loading none-ls-shellcheck diagnostics', vim.log.levels.ERROR)
      return nil
    end
  end)(),

  (function()
    local shellcheck_code_actions_ok, shellcheck_code_actions = pcall(require, 'none-ls-shellcheck.code_actions')
    if shellcheck_code_actions_ok then
      return shellcheck_code_actions
    else
      vim.notify('Error loading none-ls-shellcheck code actions', vim.log.levels.ERROR)
      return nil
    end
  end)(),
}

null_ls.setup {
  debug = true, -- MANTENHA true para depurar o ESLint!
  sources = sources,
  on_attach = function(client, bufnr)
    -- ... (sua função on_attach completa para none-ls aqui, como no comentário anterior) ...
    if client.supports_method 'textDocument/formatting' then
      local augroup_format = vim.api.nvim_create_augroup('NullLsFormatOnSave', { clear = true })
      vim.api.nvim_clear_autocmds { group = augroup_format, buffer = bufnr }
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup_format,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format {
            bufnr = bufnr,
            filter = function(c)
              return c.id == client.id
            end,
            async = false,
            timeout_ms = 2000,
          }
        end,
      })
    end
    if client.supports_method 'textDocument/codeAction' then
      vim.keymap.set({ 'n', 'v' }, '<leader>la', function()
        vim.lsp.buf.code_action { bufnr = bufnr, context = { only = { 'quickfix', 'refactor', 'source' } } }
      end, { buffer = bufnr, noremap = true, silent = true, desc = 'None-LS Code Action' })
      vim.keymap.set('n', '<leader>lf', function()
        vim.lsp.buf.code_action {
          bufnr = bufnr,
          context = {
            diagnostics = vim.diagnostic.get(bufnr, { severity = { min = vim.diagnostic.severity.WARN } }),
            only = { 'source.fixAll.eslint' },
          },
          apply = true,
        }
      end, { buffer = bufnr, noremap = true, silent = true, desc = 'None-LS Fix All (ESLint)' })
    end
  end,
}
