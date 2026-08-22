local loader = require('utils.loader')

loader.safe_setup('noice', {
  cmdline = {
    enabled = true,
    view = 'cmdline_popup',
    format = {
      cmdline = { icon = '', lang = 'vim' },
      search_down = { icon = '', lang = 'regex' },
      search_up = { icon = '', lang = 'regex' },
      filter = { icon = '$', lang = 'bash' },
      lua = { icon = '󰢱', lang = 'lua' },
      help = { icon = '?' },
    },
  },
  messages = {
    enabled = true,
    view = 'mini',
    view_error = 'notify',
    view_warn = 'notify',
    view_history = 'messages',
    view_search = 'virtualtext',
  },
  popupmenu = {
    enabled = false,
    backend = 'nui',
  },
  redirect = {
    view = 'popup',
    filter = { event = 'msg_showmode' },
  },
  commands = {
    history = {
      view = 'split',
      filter = { error = true, warn = true },
    },
    last = {
      view = 'popup',
      filter = { error = true, warn = true },
    },
    errors = {
      view = 'popup',
      filter = { error = true },
    },
  },
  notify = {
    enabled = true,
    view = 'notify',
  },
  lsp = {
    progress = {
      enabled = true,
      format = 'lsp_progress',
      format_done = 'lsp_progress_done',
      throttle = 1000 / 30,
      view = 'mini',
    },
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
    hover = {
      enabled = true,
      view = 'hover',
      opts = {
        border = 'rounded',
      },
    },
    signature = {
      enabled = true,
      view = 'hover',
      opts = {
        border = 'rounded',
      },
    },
  },
  routes = {
    {
      filter = {
        event = 'msg_show',
        kind = '',
        find = 'written',
      },
      opts = { skip = true },
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = true,
  },
  throttle = 1000 / 30,
  views = {
    cmdline_popup = {
      border = {
        style = 'rounded',
      },
      win_options = {
        winhighlight = {
          Normal = 'Normal',
          FloatBorder = 'FloatBorder',
        },
      },
    },
    hover = {
      border = {
        style = 'rounded',
      },
      win_options = {
        winhighlight = {
          Normal = 'Normal',
          FloatBorder = 'FloatBorder',
        },
      },
    },
  },
})
