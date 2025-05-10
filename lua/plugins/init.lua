local status_ok, packer = pcall(require, 'packer')

if not status_ok then
  vim.notify('Error requiring packer', vim.log.levels.ERROR)
  return
end

-- AUTO SYNC ON SAVE THIS FILE
vim.cmd [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost lua/plugins/init.lua source <afile> | PackerSync
  augroup end
]]

packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

packer.reset()

-- Before all plugins set the configuration for notifications
local notify_ok, notify = pcall(require, 'notify')
if notify_ok then
  vim.notify = notify.notify -- em vez de vim.notify = notify
  require 'plugins.configs.nvim-notify'
end

return packer.startup(function(use)
  use {
    'rest-nvim/rest.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'plugins.configs.rest-client'
    end,
  }
  use 'wbthomason/packer.nvim' -- Plugin manager
  use {
    -- Notifications
    'rcarriga/nvim-notify',
  }
  use {
    -- File tree
    'ms-jpq/chadtree',
    branch = 'chad',
    run = {
      'python3 -m chadtree deps',
      ':CHADdeps',
    },
    config = function()
      require 'plugins.configs.chadtree'
    end,
  }
  use {
    'kylechui/nvim-surround',
    tag = '*', -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require('nvim-surround').setup()
    end,
  }
  use {
    -- Commands cheatsheet at the bottom
    'folke/which-key.nvim',
    requires = { 'echasnovski/mini.icons', 'kyazdani42/nvim-web-devicons' },
    config = function()
      require 'plugins.configs.whichkey'
      require 'plugins.keymaps.whichkey'
    end,
  }
  -- use {
  --   'leafOfTree/vim-svelte-plugin'
  -- }
  use {
    -- Highlighter and stuff
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'plugins.configs.treesitter'
    end,
  }
  use {
    'renanbrayner/nvim-cheat.sh',
    requires = 'RishabhRD/popfix',
    setup = function()
      require 'plugins.configs.nvim-cheat'
    end,
  }
  use {
    -- Press Ctrl + p
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require 'plugins.configs.telescope'
    end,
  }
  use {
    -- Tabs
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'plugins.configs.bufferline'
    end,
  }
  use {
    -- Status bar
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require 'plugins.configs.lualine'
    end,
  }
  use {
    -- foating terminal
    'voldikss/vim-floaterm',
    config = function()
      require('plugins.configs.floaterm').setup()
    end,
  }
  use {
    -- Startup dashboard
    'goolord/alpha-nvim',
    config = function()
      require 'plugins.configs.alpha'
    end,
  }
  use {
    -- Session manager
    'Shatur/neovim-session-manager',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'plugins.configs.sessionmanager'
    end,
  }
  use {
    -- Better interface for selections etc
    'stevearc/dressing.nvim',
    config = function()
      require 'plugins.configs.dressing'
    end,
  }
  use {
    'smoka7/hop.nvim',
    tag = '*', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require('hop').setup()
    end,
  }
  use {
    -- Indent lines highlight
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require('plugins.configs.indentblankline').setup()
    end,
  }
  use {
    -- Better fFtT
    'unblevable/quick-scope',
    config = function()
      vim.g['qs_highlight_on_keys'] = { 'f', 'F', 't', 'T' }
    end,
  }
  use {
    -- Color codes highlight example: #FF0000
    'NvChad/nvim-colorizer.lua',
    config = function()
      require 'plugins.configs.colorizer'
    end,
  }
  use {
    -- Press Ctrl + /
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  }
  use {
    -- Editorconfig parsing
    'gpanders/editorconfig.nvim',
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'plugins.configs.gitsigns'
    end,
  }
  -- use {
  --   'steelsojka/pears.nvim',
  --   config = function()
  --     require 'plugins.configs.pears'
  --   end,
  -- }
  use {
    -- TODO: configure
    'windwp/nvim-ts-autotag',
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup { map_cr = true }
    end,
  }
  -- [[ LSP ]]
  use {
    'mason-org/mason-lspconfig.nvim',
    -- Certifique-se de que estas dependências sejam carregadas antes ou junto
    requires = { 'neovim/nvim-lspconfig', 'mason-org/mason.nvim' },
    config = function()
      require('mason').setup()
      -- Certifique-se que o mason.setup() seja chamado ANTES do mason-lspconfig.setup()
      -- Se 'mason.nvim' é um plugin separado na sua lista do Packer, o setup dele deve ocorrer antes.
      -- Se você não tem um 'use' separado para 'mason.nvim' com seu próprio config,
      -- você precisará adicionar ou garantir a ordem.
      -- Assumindo que o setup do Mason já ocorreu ou será cuidado pela ordem do Packer.
      -- Se 'mason.nvim' não tiver seu próprio bloco `use { ... config = ... }` antes deste,
      -- você pode precisar chamar require('mason').setup() aqui, mas o ideal é que
      -- 'mason.nvim' tenha seu próprio bloco de configuração.
      -- Para este exemplo, vou assumir que o setup do Mason é chamado em outro lugar antes.
      -- Se não, descomente a linha abaixo (mas verifique se não há setup duplicado):
      -- require('mason').setup()

      -- 1. Definições Comuns de LSP (on_attach, capabilities)
      local coq = require 'coq'
      local capabilities = coq.lsp_ensure_capabilities()
      local function on_attach(client, bufnr)
        print('LSP Client Attached: ' .. client.name)
        local map = function(mode, lhs, rhs, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
        end
        map('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        map('n', 'gr', vim.lsp.buf.references, '[G]oto [R]eferences')
        map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('n', 'gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
        map('n', '<leader>ls', vim.lsp.buf.signature_help, 'Signature Help')
        map('n', '<leader>lr', vim.lsp.buf.rename, '[R]ename')
        map('n', '<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('n', '<leader>ld', vim.diagnostic.open_float, 'Line [D]iagnostics')
        map('n', '[d', vim.diagnostic.goto_prev, 'Prev Diagnostic')
        map('n', ']d', vim.diagnostic.goto_next, 'Next Diagnostic')
      end

      -- 2. Configuração do `mason-lspconfig.nvim`
      require('mason-lspconfig').setup {
        ensure_installed = {
          -- CORRIGIDO: Usar nomes do LSPCONFIG aqui, conforme a nova mensagem de erro
          'lua_ls',     -- Nome lspconfig (Mason pkg: lua-language-server)
          'volar',      -- Nome lspconfig (Mason pkg: vue-language-server)
          'ts_ls',      -- Nome lspconfig (Mason pkg: typescript-language-server) - ANTES ERA tsserver
          'html',       -- Nome lspconfig (Mason pkg: html-lsp ou vscode-html-language-server)
          'cssls',      -- Nome lspconfig (Mason pkg: css-lsp ou vscode-css-language-server)
        },
        automatic_enable = {
          -- lua_ls será habilitado automaticamente por mason-lspconfig.
          -- Os outros estão excluídos para setup manual detalhado abaixo.
          exclude = { 'volar', 'ts_ls', 'html', 'cssls', 'eslint' },
        },
      }

      -- 3. Configuração Manual dos Servidores LSP Excluídos
      local lspconfig = require 'lspconfig'

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
    end,
  }

  use {
    'folke/lazydev.nvim',
    ft = 'lua', -- Carrega o plugin apenas em arquivos Lua
    config = function()
      require('lazydev').setup {
        library = {
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      }
    end,
  }

  -- No seu arquivo de configuração de plugins, dentro do bloco 'nvimtools/none-ls.nvim'
  use {
    'nvimtools/none-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim' }, -- Adicionando plenary como dependência opcional/recomendada
    config = function()
      local null_ls = require 'null-ls'
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
        b.eslint.with { -- CORRIGIDO: Usar b.eslint diretamente
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
    end,
  }

  -- [[ Auto completion ]]
  use {
    'ms-jpq/coq_nvim',
    -- 'renanbrayner/coq_nvim', -- my fork to avoid using old coq version and fix bug bellow
    branch = 'coq',
    -- commit = '5eddd31bf8a98d1b893b0101047d0bb31ed20c49', -- This solves the css autocomplete bug
    run = {
      ':COQdeps',
    },
    setup = function()
      require 'plugins.configs.coq'
    end,
    config = function()
      -- Load LSP after COQ
      -- require 'lsp'
    end,
  }
  use {
    'ms-jpq/coq.artifacts',
    branch = 'artifacts',
  }
  use {
    'ms-jpq/coq.thirdparty',
    branch = '3p',
  }
  use {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup {
        keymaps = {
          accept_suggestion = '<C-l>',
          clear_suggestion = '<C-]>',
          accept_word = '<C-j>',
        },
        ignore_filetypes = { cpp = true }, -- or { "cpp", }
        color = {
          suggestion_color = '#ffffff',
          cterm = 244,
        },
        log_level = 'info',                -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false,           -- disables built in keymaps for more manual control
        condition = function()
          return false
        end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
      }
    end,
  }
  -- [[ Colorthemes ]]
  use {
    'Mofiqul/dracula.nvim',
    as = 'dracula',
  }
  use 'ellisonleao/gruvbox.nvim'
  use 'shaunsingh/nord.nvim'
  use 'ishan9299/nvim-solarized-lua'
end)
