local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
  vim.notify('Error requiring mason', vim.log.levels.ERROR)
  return
end

mason.setup {
  ui = {
    border = 'rounded',
    icons = {
      package_installed = '✓',
    },
  },
}

local coq_ok, coq = pcall(require, 'coq')
if not coq_ok then
  vim.notify('Error requiring coq', vim.log.levels.ERROR)
  return
end

local capabilities = coq.lsp_ensure_capabilities()
-- local function on_attach(client, bufnr)
--   print('LSP Client Attached: ' .. client.name)
--   local map = function(mode, lhs, rhs, desc)
--     if desc then
--       desc = 'LSP: ' .. desc
--     end
--     vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
--   end
--   map('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
--   map('n', 'gr', vim.lsp.buf.references, '[G]oto [R]eferences')
--   map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--   map('n', 'gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
--   map('n', 'K', vim.lsp.buf.hover({ border = 'rounded' }), 'Hover Documentation')
--   map('n', '<leader>ls', vim.lsp.buf.signature_help, 'Signature Help')
--   map('n', '<leader>lr', vim.lsp.buf.rename, '[R]ename')
--   map('n', '<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction')
--   map('n', '<leader>ld', vim.diagnostic.open_float, 'Line [D]iagnostics')
--   map('n', '[d', vim.diagnostic.goto_prev, 'Prev Diagnostic')
--   map('n', ']d', vim.diagnostic.goto_next, 'Next Diagnostic')
-- end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_ok then
  vim.notify('Error requiring mason-lspconfig', vim.log.levels.ERROR)
  return
end

mason_lspconfig.setup {
  ensure_installed = {
    'lua_ls', -- Nome lspconfig (Mason pkg: lua-language-server)
    'vue_ls', -- Nome lspconfig (Mason pkg: vue-language-server)
    'vtsls',
    'html', -- Nome lspconfig (Mason pkg: html-lsp ou vscode-html-language-server)
    'cssls', -- Nome lspconfig (Mason pkg: css-lsp ou vscode-css-language-server)
    'eslint', -- Nome lspconfig (Mason pkg: eslint-lsp)
  },
  handlers = {
    function(server_name)
      if not vim.tbl_contains({ 'html', 'cssls', 'eslint', 'vue_ls' }, server_name) then
        vim.lsp.enable(server_name, {
          capabilities = capabilities,
          root_dir = vim.fs.root(0, { '.git' }),
        })
      end
    end,
  },
}

local function setup_html()
  vim.lsp.enable('html', {
    root_dir = vim.fs.root(0, { 'package.json', '.git' }),
    capabilities = capabilities,
    filetypes = { 'html', 'xhtml', 'htmldjango' },
  })
end

local function setup_cssls()
  vim.lsp.enable('cssls', {
    root_dir = vim.fs.root(0, { 'package.json', '.git' }),
    capabilities = capabilities,
    filetypes = { 'css', 'scss', 'less', 'sass' },
  })
end

local function setup_eslint()
  vim.lsp.enable('eslint', {
    root_dir = vim.fs.root(0, { '.git', 'package.json' }),
    capabilities = capabilities,
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    settings = {
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = 'separateLine',
        },
        showDocumentation = {
          enable = true,
        },
      },
      codeActionOnSave = {
        enable = false,
        mode = 'all',
      },
      experimental = {
        useFlatConfig = false,
      },
      format = true,
      nodePath = '',
      onIgnoredFiles = 'off',
      problems = {
        shortenToSingleLine = false,
      },
      quiet = false,
      rulesCustomizations = {},
      run = 'onType',
      useESLintClass = false,
      validate = 'on',
      workingDirectory = {
        mode = 'location',
      },
    },
  })
end

local function setup_vtsls()
  local vue_language_server_path = vim.fn.stdpath 'data'
    .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'

  vim.lsp.config('vtsls', {
    cmd = { 'vtsls', '--stdio' },
    root_markers = { 'package.json', 'tsconfig.json', '.git' },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    capabilities = capabilities,
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            {
              name = '@vue/typescript-plugin',
              location = vue_language_server_path,
              languages = { 'vue' },
              configNamespace = 'typescript',
              enableForWorkspaceTypeScriptVersions = true,
            },
          },
        },
      },
    },
  })
  vim.lsp.enable 'vtsls'
end

local function setup_vue()
  vim.lsp.config('vue_ls', {
    cmd = { 'vue-language-server', '--stdio' },
    root_markers = { 'package.json', '.git' },
    filetypes = { 'vue' },
    capabilities = capabilities,
    handlers = {
      ['tsserver/request'] = function(err, result, context, config)
        local vtsls_clients = vim.lsp.get_clients { bufnr = context.bufnr, name = 'vtsls' }

        if #vtsls_clients == 0 then
          vim.notify('vtsls não encontrado! vue_ls precisa dele.', vim.log.levels.ERROR)
          return
        end

        local vtsls_client = vtsls_clients[1]
        local param = unpack(result)
        local id, command, payload = unpack(param)

        vtsls_client:exec_cmd({
          title = 'vue_request_forward',
          command = 'typescript.tsserverRequest',
          arguments = { command, payload },
        }, { bufnr = context.bufnr }, function(_, r)
          local response = r and r.body
          local response_data = { { id, response } }
          local client = vim.lsp.get_client_by_id(context.client_id)
          if client then
            client:notify('tsserver/response', response_data)
          end
        end)
      end,
    },
  })
  vim.lsp.enable 'vue_ls'
end

setup_html()
setup_cssls()
setup_eslint()
setup_vtsls()
setup_vue()

local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn', text = '' },
  { name = 'DiagnosticSignHint', text = '' },
  { name = 'DiagnosticSignInfo', text = '' },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

vim.diagnostic.config {
  virtual_text = false,
  signs = {
    active = signs,
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
  },
}
