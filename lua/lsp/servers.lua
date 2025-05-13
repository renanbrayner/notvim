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

-- 1. Definições Comuns de LSP (on_attach, capabilities)
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

-- 2. Configuração do `mason-lspconfig.nvim`
local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_ok then
  vim.notify('Error requiring mason-lspconfig', vim.log.levels.ERROR)
  return
end

mason_lspconfig.setup {
  ensure_installed = {
    -- CORRIGIDO: Usar nomes do LSPCONFIG aqui, conforme a nova mensagem de erro
    'lua_ls', -- Nome lspconfig (Mason pkg: lua-language-server)
    'volar', -- Nome lspconfig (Mason pkg: vue-language-server)
    'ts_ls', -- Nome lspconfig (Mason pkg: typescript-language-server) - ANTES ERA tsserver
    'html', -- Nome lspconfig (Mason pkg: html-lsp ou vscode-html-language-server)
    'cssls', -- Nome lspconfig (Mason pkg: css-lsp ou vscode-css-language-server)
  },
  automatic_enable = {
    -- lua_ls será habilitado automaticamente por mason-lspconfig.
    -- Os outros estão excluídos para setup manual detalhado abaixo.
    exclude = { 'volar', 'ts_ls', 'html', 'cssls', 'eslint' },
  },
}

-- 3. Configuração Manual dos Servidores LSP Excluídos
local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
  vim.notify('Error requiring lspconfig', vim.log.levels.ERROR)
  return
end

lspconfig.volar.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'vue' },
}

local global_npm_root = vim.fn.trim(vim.fn.system 'npm root -g')
local vue_plugin_location_base = global_npm_root .. '/@vue/language-server'
-- (A verificação de `isdirectory` ainda é recomendada aqui)
if vim.fn.isdirectory(vue_plugin_location_base) == 0 then
  vim.notify(
    'AVISO: Diretório base para @vue/typescript-plugin (via npm global @vue/language-server) não encontrado: '
      .. vue_plugin_location_base
      .. '\nVerifique `npm root -g` e a instalação global de `@vue/language-server`.',
    vim.log.levels.WARN,
    { title = 'LSP Config Vue' }
  )
end

-- ATENÇÃO: Mudança de tsserver para ts_ls aqui também!
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vue_plugin_location_base,
        languages = { 'javascript', 'typescript', 'vue' },
      },
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}

local servers_to_setup_manually = { 'html', 'cssls', 'eslint' }
for _, lsp_name in ipairs(servers_to_setup_manually) do
  lspconfig[lsp_name].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

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
  -- disable virtual text
  virtual_text = false,
  -- show signs
  signs = {
    active = signs,
  },
  -- delay update diagnsotics
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
