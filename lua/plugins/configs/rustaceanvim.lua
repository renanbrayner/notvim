-- Configuração completa do rustaceanvim com todas as funcionalidades
vim.g.rustaceanvim = {
  server = {
    cmd = function()
      return { 'rust-analyzer' }
    end,
    -- Configuração completa com todas as funcionalidades habilitadas
    settings = {
      ['rust-analyzer'] = {
        -- Habilitar check/clippy para análise completa
        check = {
          command = "check",
          extraArgs = {},
        },
        -- Configuração completa de Cargo
        cargo = {
          allFeatures = true,
          features = "all",
          loadOutDirsFromCheck = true,
          autoreload = true,
        },
        -- Habilitar todas as features úteis
        inlayHints = {
          enable = true,
          display = {
            parameterHints = true,
            typeHints = true,
            chainingHints = true,
            maxLength = 25,
          },
          bindingModeHints = {
            enable = true,
          },
          closingBraceHints = {
            enable = true,
            minLines = 25,
          },
          lifetimeElisionHints = {
            enable = "skip_trivial",
          },
        },
        lens = {
          enable = true,
          run = {
            enable = true,
          },
          debug = {
            enable = true,
          },
          implementations = {
            enable = true,
          },
          methodReferences = {
            enable = true,
          },
          references = {
            enable = true,
          },
          enumVariantReferences = {
            enable = true,
          },
        },
        hover = {
          actions = {
            enable = true,
            implementations = {
              enable = true,
            },
            references = {
              enable = true,
            },
            run = {
              enable = true,
            },
            debug = {
              enable = true,
            },
            gotoTypeDef = {
              enable = true,
            },
          },
        },
        -- Configurações de formatação
        rustfmt = {
          extraArgs = { "--edition", "2021" },
          overrideCommand = nil,
        },
        -- Habilitar proc macros para funcionalidade completa
        procMacro = {
          enable = true,
          ignored = {},
          attributes = {
            enable = true,
          },
        },
        -- Habilitar diagnostics completos
        diagnostics = {
          enable = true,
          enableExperimental = false,
          disabled = {},
          warningsAsHint = {},
          warningsAsInfo = {},
        },
        -- Outras configurações úteis
        completion = {
          addCallParentheses = true,
          addCallArgumentSnippets = true,
          postfix = {
            enable = true,
          },
          autoimport = {
            enable = true,
          },
        },
        semanticHighlighting = {
          strings = {
            enable = true,
          },
          punctuation = {
            enable = true,
            separate = {
              macro = {
                enable = true,
              },
            },
            specialize = {
              enable = true,
            },
          },
        },
      },
    },
    -- on_attach com todas as funcionalidades LSP e Coq
    on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }
      -- Keymaps básicos de LSP
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, opts)

      -- Coq integration se disponível
      if require('coq') then
        require('coq').lsp_ensure_capabilities()
      end
    end,
    capabilities = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- Adicionar Coq capabilities se disponível
      local ok, coq = pcall(require, 'coq')
      if ok then
        capabilities = coq.lsp_ensure_capabilities(capabilities)
      end
      return capabilities
    end,
  },

  -- root_dir robusto para projetos e arquivos standalone
  root_dir = function()
    local cargo_root = vim.fs.root(0, { 'Cargo.toml' })
    if cargo_root then
      return cargo_root
    end

    -- Para arquivos .rs sem Cargo.toml, usar diretório do arquivo
    local filename = vim.fn.expand('%:t')
    if filename:match('%.rs$') then
      return vim.fn.expand('%:p:h')
    end

    return vim.fn.getcwd()
  end,

  -- Habilitar todas as ferramentas úteis
  tools = {
    executor = {
      enable = true,
    },
    test = {
      enable = true,
    },
    hover_actions = {
      enable = true,
      replace_builtin_hover = true,
    },
    inlay_hints = {
      auto = true,
      only_current_line = false,
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
      highlight = "LspInlayHint",
    },
    code_actions = {
      ui_select_fallback = true,
    },
    crate_graph = {
      enable = true,
      backend = "dot",
      output = nil,
      full = true,
      enabled_graphviz_backends = {
        "dot",
        "circo",
        "fdp",
        "neato",
        "twopi",
      },
      pipe = nil,
    },
    open_wsdl = {
      enable = true,
    },
    move_item = {
      enable = true,
      mover = {
        char = {
          enable = true,
          left = "<C-h>",
          right = "<C-l>",
        },
        line = {
          enable = true,
          down = "<C-j>",
          up = "<C-k>",
        },
        prev = false,
        next = false,
      },
    },
  },

  -- Habilitar DAP para debug
  dap = {
    adapter = {
      type = "executable",
      command = "lldb-vscode",
      name = "rt_lldb",
    },
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