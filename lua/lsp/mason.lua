local mason_status_ok, mason = pcall(require, 'mason')
if not mason_status_ok then
  vim.notify('Error requiring mason', error)
  return
end

local masonlsp_status_ok, masonlsp = pcall(require, 'mason-lspconfig')
if not masonlsp_status_ok then
  vim.notify('Error requiring masonlsp', error)
  return
end

local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
  vim.notify('Error requiring lspconfig', error)
  return
end

local opts = {
  capabilities = require('lsp.handlers').capabilities,
  on_attach = require('lsp.handlers').on_attach,
}

mason.setup {
  ui = {
    border = 'rounded',
    icons = {
      package_installed = '✓',
    },
  },
}

masonlsp.setup {
  -- ensure_installed = { 'sumneko_lua' }, -- REMOVED AFTER ATUALIZATION
  automatic_installation = true,
}

masonlsp.setup_handlers {
  -- general configuration
  function(server_name)
    lspconfig[server_name].setup {
      on_atacch = opts.on_attach,
      capabilities = opts.capabilities,
    }
  end,

  -- language specific configurations
  -- LUA -- REMOVED AFTER ATUALIZATION
  -- ['sumneko_lua'] = function()
  --   lspconfig.sumneko_lua.setup {
  --     on_attach = opts.on_attach,
  --     capabilities = opts.capabilities,
  --
  --     settings = {
  --       Lua = {
  --         -- Tells Lua that a global variable named vim exists to not have warnings when configuring neovim
  --         completion = {
  --           autoRequire = false, -- autoRequire is broken
  --         },
  --         diagnostics = {
  --           globals = { 'vim' },
  --         },
  --         workspace = {
  --           library = {
  --             [vim.fn.expand("$VIMRUNTIME/lua")] = true,
  --             [vim.fn.stdpath("config") .. "/lua"] = true,
  --           },
  --         },
  --       },
  --     },
  --   }
  -- end,

  -- JSON
  ['jsonls'] = function()
    -- Find more schemas here: https://www.schemastore.org/json/
    -- Schemas for common json files
    local schemas = {
      {
        description = 'Schema for CMake Presets',
        fileMatch = {
          'CMakePresets.json',
          'CMakeUserPresets.json',
        },
        url = 'https://raw.githubusercontent.com/Kitware/CMake/master/Help/manual/presets/schema.json',
      },
      {
        description = 'LLVM compilation database',
        fileMatch = {
          'compile_commands.json',
        },
        url = 'https://json.schemastore.org/compile-commands.json',
      },
      {
        description = 'Config file for Command Task Runner',
        fileMatch = {
          'commands.json',
        },
        url = 'https://json.schemastore.org/commands.json',
      },
      {
        description = 'Json schema for properties json file for a GitHub Workflow template',
        fileMatch = {
          '.github/workflow-templates/**.properties.json',
        },
        url = 'https://json.schemastore.org/github-workflow-template-properties.json',
      },
      {
        description = 'JSON schema for Visual Studio component configuration files',
        fileMatch = {
          '*.vsconfig',
        },
        url = 'https://json.schemastore.org/vsconfig.json',
      },
    }

    lspconfig.jsonls.setup {
      on_attach = opts.on_attach,
      capabilities = opts.capabilities,

      settings = {
        json = {
          schemas = schemas,
        },
      },

      setup = {
        commands = {
          Format = {
            function()
              vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line '$', 0 })
            end,
          },
        },
      },
    }
  end,
}
