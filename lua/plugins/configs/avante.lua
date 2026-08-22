return {
  instructions_file = "AGENTS.md",
  ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
  ---@type Provider
  provider = "minimax", -- Mudamos para minimax
  ---@alias Mode "agentic" | "legacy"
  ---@type Mode
  mode = "agentic",

  -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
  -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
  -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
  auto_suggestions_provider = "minimax", -- Mudamos para minimax

  providers = {
    minimax = {
      __inherited_from = "openai",
      endpoint = "https://api.minimax.io/v1", -- Use https://api.minimaxi.com/v1 se a conta for da China (Mainland)
      api_key_name = "MINIMAX_API_KEY",
      model = "MiniMax-M2.5", -- Modelo mais recente e capaz deles (você também pode usar o MiniMax-M2.1)
      extra_request_body = {
        temperature = 0.75,
        -- max_tokens = 20480, -- Opcional: ajuste conforme o limite do modelo que escolher
      },
    },
  },

  dual_boost = {
    enabled = false,
    first_provider = "openai",
    second_provider = "minimax", -- Opcional: atualizado aqui também caso decida testar o dual_boost depois
    prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
    timeout = 60000, -- Timeout in milliseconds
  },

  behaviour = {
    auto_suggestions = false, -- Experimental stage
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
    minimize_diff = true,                 -- Whether to remove unchanged lines when applying a code block
    enable_token_counting = true,         -- Whether to enable token counting. Default to true.
    auto_add_current_file = true,         -- Whether to automatically add the current file when opening a new chat. Default to true.
    auto_approve_tool_permissions = true, -- Default: auto-approve all tools (no prompts)
    confirmation_ui_style = "inline_buttons",
    acp_follow_agent_locations = true,
  },

  prompt_logger = {                                         -- logs prompts to disk (timestamped, for replay/debugging)
    enabled = true,                                         -- toggle logging entirely
    log_dir = vim.fn.stdpath("cache") .. "/avante_prompts", -- directory where logs are saved
    fortune_cookie_on_success = false,                      -- shows a random fortune after each logged prompt (requires `fortune` installed)
    next_prompt = {
      normal = "<C-n>",                                     -- load the next (newer) prompt log in normal mode
      insert = "<C-n>",
    },
    prev_prompt = {
      normal = "<C-p>", -- load the previous (older) prompt log in normal mode
      insert = "<C-p>",
    },
  },

  mappings = {
    diff = {
      ours = "co",
      theirs = "ct",
      all_theirs = "ca",
      both = "cb",
      cursor = "cc",
      next = "]x",
      prev = "[x",
    },
    suggestion = {
      accept = "<M-l>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
    jump = {
      next = "]]",
      prev = "[[",
    },
    submit = {
      normal = "<CR>",
      insert = "<C-s>",
    },
    cancel = {
      normal = { "<C-c>", "<Esc>", "q" },
      insert = { "<C-c>" },
    },
    sidebar = {
      apply_all = "A",
      apply_cursor = "a",
      retry_user_request = "r",
      edit_user_request = "e",
      switch_windows = "<Tab>",
      reverse_switch_windows = "<S-Tab>",
      remove_file = "d",
      add_file = "@",
      close = { "<Esc>", "q" },
      close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
    },
  },

  selector = {
    provider = "native",
    provider_opts = {},
  },
  selection = {
    enabled = true,
    hint_display = "delayed",
  },
  input = {
    provider = "dressing",
  },
  windows = {
    position = "left",  -- the position of the sidebar
    wrap = true,        -- similar to vim.o.wrap
    width = 30,         -- default % based on available width
    sidebar_header = {
      enabled = false,  -- true, false to enable/disable the header
      align = "center", -- left, center, right for title
      rounded = true,
    },
    spinner = {
      editing = { "⡀", "⠄", "⠂", "⠁", "⠈", "⠐", "⠠", "⢀", "⣀", "⢄", "⢂", "⢁", "⢈", "⢐", "⢠", "⣠", "⢤", "⢢", "⢡", "⢨", "⢰", "⣰", "⢴", "⢲", "⢱", "⢸", "⣸", "⢼", "⢺", "⢹", "⣹", "⢽", "⢻", "⣻", "⢿", "⣿" },
      generating = { "·", "✢", "✳", "∗", "✻", "✽" }, -- Spinner characters for the 'generating' state
      thinking = { "🤯", "🙄" }, -- Spinner characters for the 'thinking' state
    },
    input = {
      prefix = "> ",
      height = 8, -- Height of the input window in vertical layout
    },
    edit = {
      border = "rounded",
      start_insert = true, -- Start insert mode when opening the edit window
    },
    ask = {
      floating = false,     -- Open the 'AvanteAsk' prompt in a floating window
      start_insert = false, -- Start insert mode when opening the ask window
      border = "rounded",
      focus_on_apply = "ours", -- which diff to focus after applying
    },
  },

  highlights = {
    diff = {
      current = "DiffText",
      incoming = "DiffAdd",
    },
  },

  diff = {
    autojump = true,
    list_opener = "copen",
    override_timeoutlen = 500,
  },

  suggestion = {
    debounce = 600,
    throttle = 600,
  },
}
