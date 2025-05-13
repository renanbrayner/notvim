local null_ls_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_ok then
  vim.notify('Error requiring null-ls', vim.log.levels.ERROR)
  return
end

local b = null_ls.builtins

local sources = {
  b.formatting.prettier.with {
    command = "node_modules/.bin/prettier",
    extra_args = function(params)
      return { "--stdin-filepath", params.filename }
    end,
    filetypes = {
      "html", "markdown", "css", "scss", "less", "javascript",
      "javascriptreact", "typescript", "typescriptreact", "vue",
      "json", "yaml", "graphql",
    },
  },

  require("none-ls.diagnostics.eslint").with {
    command = "node_modules/.bin/eslint",
    filetypes = { "javascript", "typescript", "vue" },
  },

  require("none-ls.code_actions.eslint").with {
    command = "node_modules/.bin/eslint",
  },

  b.formatting.stylua,
  b.formatting.black,
  b.diagnostics.shellcheck,
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
