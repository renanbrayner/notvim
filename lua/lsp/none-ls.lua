local null_ls_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_ok then
  vim.notify('Error requiring null-ls', vim.log.levels.ERROR)
  return
end


local b = null_ls.builtins

local sources = {
  b.formatting.prettier.with {
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

  -- ESLint (configurado como um source único)
  b.eslint.with {       -- CORRIGIDO: Usar b.eslint diretamente
    command = 'node_modules/.bin/eslint',
    -- Se o comando acima falhar, o none-ls pode ter problemas para registrar o source.
    -- Verifique se `node_modules/.bin/eslint` existe e é executável no seu projeto.
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
    -- Para diagnósticos, o builtin eslint geralmente usa --format=json
    -- Para code_actions (fix), ele usa --fix-to-stdout ou similar.
    -- O builtin padrão deve lidar com isso.
  },

  b.formatting.stylua.with {},
  b.formatting.black.with {},
  b.diagnostics.shellcheck.with {},
}

null_ls.setup {
  debug = true,       -- MANTENHA true para depurar o ESLint!
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
