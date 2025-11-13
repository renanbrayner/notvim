local dap_ok, dap = pcall(require, 'dap')
if not dap_ok then
  vim.notify('Error requiring nvim-dap', vim.log.levels.ERROR)
  return
end

local dap_ui_ok, dapui = pcall(require, 'dapui')
if not dap_ui_ok then
  vim.notify('Error requiring nvim-dap-ui', vim.log.levels.ERROR)
  return
end

local virtual_text_ok, dap_vt = pcall(require, 'nvim-dap-virtual-text')
if not virtual_text_ok then
  vim.notify('Error requiring nvim-dap-virtual-text', vim.log.levels.ERROR)
  return
end

-- Configuração do nvim-dap-virtual-text
dap_vt.setup {
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = false,
  show_stop_reason = true,
  commented = false,
  only_first_definition = true,
  all_references = false,
  clear_on_continue = false,
  display_callback = function(variable, buf, stackframe, node, options)
    if options.virt_text_pos == 'inline' then
      return ' = ' .. variable.value
    else
      return variable.name .. ' = ' .. variable.value
    end
  end,
  virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
  all_frames = false,
  virt_lines = false,
  virt_text_win_col = nil,
}

-- Configuração do nvim-dap-ui
dapui.setup {
  controls = {
    element = 'repl',
    enabled = true,
    icons = {
      disconnect = '',
      pause = '',
      play = '',
      run_last = '',
      step_back = '',
      step_into = '',
      step_out = '',
      step_over = '',
      terminate = '',
    },
  },
  element_mappings = {},
  expand_lines = true,
  floating = {
    border = 'single',
    mappings = {
      close = { 'q', '<Esc>' },
    },
  },
  force_buffers = true,
  icons = {
    collapsed = '',
    current_frame = '',
    expanded = '',
  },
  layouts = {
    {
      elements = {
        {
          id = 'scopes',
          size = 0.50,
        },
        {
          id = 'breakpoints',
          size = 0.25,
        },
        {
          id = 'stacks',
          size = 0.25,
        },
        {
          id = 'watches',
          size = 0.25,
        },
      },
      position = 'left',
      size = 40,
    },
    {
      elements = {
        {
          id = 'repl',
          size = 0.5,
        },
        {
          id = 'console',
          size = 0.5,
        },
      },
      position = 'bottom',
      size = 10,
    },
  },
  mappings = {
    edit = 'e',
    expand = { '<CR>', '<2-LeftMouse>' },
    open = 'o',
    remove = 'd',
    repl = 'r',
    toggle = 't',
  },
  render = {
    indent = 1,
    max_value_lines = 100,
  },
}

-- Auto abrir/fechar DAP UI
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end

dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end

dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

-- Configurações de depuração JavaScript/TypeScript (para Node.js)
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { vim.fn.stdpath 'data' .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
}

dap.configurations.javascript = {
  {
    name = 'Launch Node.js',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- Para depurar aplicações Next.js, React, etc.
    name = 'Launch Node.js with npm start',
    type = 'node2',
    request = 'launch',
    program = '${workspaceFolder}/node_modules/.bin/next',
    args = { 'dev' },
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}

dap.configurations.typescript = {
  {
    name = 'Launch TypeScript',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    outFiles = { '${workspaceFolder}/dist/**/*.js' },
  },
  {
    name = 'Launch TypeScript with ts-node',
    type = 'node2',
    request = 'launch',
    program = '${workspaceFolder}/node_modules/.bin/ts-node',
    args = { '${file}' },
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}

-- Configurações de depuração Python
dap.adapters.python = {
  type = 'executable',
  command = vim.fn.exepath 'python' or 'python',
  args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
  {
    name = 'Launch Python',
    type = 'python',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    console = 'integratedTerminal',
  },
  {
    name = 'Launch Python with args',
    type = 'python',
    request = 'launch',
    program = '${file}',
    args = function()
      local args_string = vim.fn.input 'Arguments: '
      return vim.split(args_string, ' +')
    end,
    cwd = vim.fn.getcwd(),
    console = 'integratedTerminal',
  },
}

-- Configurações de depuração Lua (usando local-lua-debugger-vscode do Mason)
dap.adapters.local_lua = {
  type = 'executable',
  command = 'node',
  args = { vim.fn.stdpath 'data' .. '/mason/packages/local-lua-debugger-vscode/extension/debugger/lldebugger.lua' },
}

dap.configurations.lua = {
  {
    type = 'local_lua',
    request = 'launch',
    name = 'Launch Lua file',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    console = 'integratedTerminal',
  },
  {
    type = 'local_lua',
    request = 'launch',
    name = 'Launch Lua with args',
    program = '${file}',
    args = function()
      local args_string = vim.fn.input 'Arguments: '
      return vim.split(args_string, ' +')
    end,
    cwd = vim.fn.getcwd(),
    console = 'integratedTerminal',
  },
}

-- Configurações de depuração C/C++
dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb',
    args = { '--port', '${port}' },
  },
}

dap.configurations.c = {
  {
    name = 'Launch C',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.cpp = {
  {
    name = 'Launch C++',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

-- Configurações de depuração Rust
dap.configurations.rust = {
  {
    name = 'Launch Rust binary',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
  {
    name = 'Launch Rust with arguments',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    args = function()
      local args_string = vim.fn.input('Arguments: ')
      return vim.split(args_string, ' +')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
  {
    name = 'Launch Rust test',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to test binary: ', vim.fn.getcwd() .. '/target/debug/deps/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

-- Configurações visuais
vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = '' })

return dap
