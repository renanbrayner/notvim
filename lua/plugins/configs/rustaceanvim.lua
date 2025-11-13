-- Configuração do rustaceanvim para modo STANDALONE sem features nightly
vim.g.rustaceanvim = {
  server = {
    cmd = function()
      return { 'rust-analyzer' }
    end,
    -- Configuração específica para modo standalone sem nightly features
    settings = {
      ['rust-analyzer'] = {
        -- Desabilitar completamente check/clippy para evitar erros em standalone
        check = {
          command = nil,  -- Desabilitado para modo standalone
        },
        -- Configuração mínima de Cargo para standalone
        cargo = {
          allFeatures = false,
          features = nil,  -- Sem features para evitar problemas
          loadOutDirsFromCheck = false,
          autoreload = false,
        },
        -- Desabilitar features que podem causar problemas
        inlayHints = {
          enable = false,
        },
        lens = {
          enable = false,
        },
        hover = {
          actions = {
            enable = false,  -- Desabilitar actions que podem tentar compilar
          },
        },
        -- Configurações de formatação seguras para stable
        rustfmt = {
          extraArgs = { "--edition", "2021" },  -- Edition segura para stable
        },
        -- Proc macros podem causar problemas em standalone
        procMacro = {
          enable = false,
        },
        -- Diagnostics podem tentar compilar
        diagnostics = {
          enable = false,
        },
      },
    },
    -- on_attach essencial sem funcionalidades problemáticas
    on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }
      -- Apenas keymaps básicos de LSP
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    end,
  },

  -- root_dir para modo standalone
  root_dir = function()
    local cargo_root = vim.fs.root(0, { 'Cargo.toml' })
    if cargo_root then
      return cargo_root  -- Modo projeto
    end

    -- Modo standalone para arquivos .rs sem Cargo.toml
    local filename = vim.fn.expand('%:t')
    if filename:match('%.rs$') then
      vim.notify('Rust standalone mode - Cargo.toml not found', vim.log.levels.INFO)
      return nil  -- Explicitamente nil para standalone
    end

    return vim.fn.expand('%:p:h')
  end,

  -- Desabilitar ferramentas que podem tentar compilar
  tools = {
    executor = {
      enable = false,
    },
    test = {
      enable = false,
    },
    hover_actions = {
      enable = false,
    },
    inlay_hints = {
      auto = false,
    },
    code_actions = {
      ui_select_fallback = false,
    },
    crate_graph = {
      enable = false,
    },
  },

  -- Desabilitar DAP para evitar tentativas de compilação
  dap = {
    adapter = nil,
  },
}

-- Configurações específicas para modo standalone
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  callback = function()
    vim.opt_local.commentstring = '// %s'
    vim.opt_local.makeprg = 'rustc %:S -o %:r'
    -- Apenas configurações básicas, sem tentativas de compilação automática
  end,
})