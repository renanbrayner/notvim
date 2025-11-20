-- Configuração robusta do rustaceanvim
vim.g.rustaceanvim = {
  server = {
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          autoreload = false,
          buildScripts = { enable = true },
        },
        checkOnSave = { command = 'clippy' },
        diagnostics = { enable = true },
        inlayHints = {
          enable = true,
          showParameterNames = true,
          parameterHintsPrefix = '-> ',
          otherHintsPrefix = '=> ',
        },
        procMacro = { enable = true },
        rustfmt = { extraArgs = { '+nightly' } },
      },
    },
  },
  tools = {
    hover_actions = { auto_focus = true },
  },
  dap = {
    adapter = {
      type = 'executable',
      command = 'lldb-vscode',
      name = 'rt_lldb',
    },
  },
}

-- Configurações específicas para modo standalone
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  callback = function()
    vim.opt_local.commentstring = '// %s'
  end,
})

-- Habilitar inlay hints automaticamente em buffers Rust
vim.api.nvim_create_autocmd('LspAttach', {
  pattern = '*.rs',
  callback = function(args)
    vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
  end,
})
