local status_ok, wk = pcall(require, 'which-key')
if not status_ok then
  vim.notify('Error requiring which-key', error)
  return
end
wk.register({
  -- f = { '<cmd>HopWordCurrentLine<cr>', 'Hop line' },
  -- F = { '<cmd>HopAnywhereCurrentLine<cr>', 'Hop anywhere line' },
  [','] = { '<cmd>HopWord<cr>', 'Hop window' },
  -- s = { '<cmd>HopAnywhere<cr>', 'Hop anywhere window' },
  ['<A-Up>'] = { '<cmd>m .-2<CR>==', 'Move line up' },
  ['<A-k>'] = { '<cmd>m .-2<CR>==', 'Move line up' },
  ['<A-Down>'] = { '<cmd>m .+1<CR>==', 'Move line down' },
  ['<A-j>'] = { '<cmd>m .+1<CR>==', 'Move line down' },
  ['<C-_>'] = { '<cmd>normal gcc<cr>', 'Comment line' },
}, { mode = 'n' })

wk.register({
  -- f = { '<cmd>HopWordCurrentLine<cr>', 'Hop line' },
  -- F = { '<cmd>HopAnywhereCurrentLine<cr>', 'Hop anywhere line' },
  [','] = { '<cmd>HopWord<cr>', 'Hop window' },
  -- S = { '<cmd>HopAnywhere<cr>', 'Hop anywhere window' },
  ['<A-k>'] = { ":m '<-2<CR>gv=gv", 'Move selection up' },
  ['<A-j>'] = { ":m '>+1<CR>gv=gv", 'Move selection down' },
  ['<A-Up>'] = { ":m '<-2<CR>gv=gv", 'Move selection up' },
  ['<A-Down>'] = { ":m '>+1<CR>gv=gv", 'Move selection down' },
  ['<C-_>'] = { '<cmd>normal gcgv<cr>', 'Comment selection' },
}, { mode = 'v' })

wk.register({
  -- f = { '<cmd>HopWordCurrentLine<cr>', 'Hop line' },
  -- F = { '<cmd>HopAnywhereCurrentLine<cr>', 'Hop anywhere line' },
  [','] = { '<cmd>HopWord<cr>', 'Hop window' },
  -- S = { '<cmd>HopAnywhere<cr>', 'Hop anywhere window' },
}, { mode = 'o' })

wk.register {
  ['<F3>'] = {
    function()
      vim.lsp.buf.format { async = true }
    end,
    'Format file',
  },
  ['<C-p>'] = { ControlP, 'Search files' },
  ['<C-s>'] = { '<cmd>:w<cr>', 'Save file' },
  ['<A-s>'] = { '<cmd>BufferLinePick<cr>', 'Hop to buffer' },
  ['<A-<>'] = { '<cmd>BufferLineMovePrev<CR>', 'Previous tab' },
  ['<A->>'] = { '<cmd>BufferLineMoveNext<CR>', 'Next tab' },
  ['<A-,>'] = { '<cmd>BufferLineCyclePrev<CR>', 'Previous tab' },
  ['<A-.>'] = { '<cmd>BufferLineCycleNext<CR>', 'Next tab' },
  ['<A-1>'] = { '<cmd>BufferLineGoToBuffer 1<CR>', 'Go to tab 1' },
  ['<A-2>'] = { '<cmd>BufferLineGoToBuffer 2<CR>', 'Go to tab 2' },
  ['<A-3>'] = { '<cmd>BufferLineGoToBuffer 3<CR>', 'Go to tab 3' },
  ['<A-4>'] = { '<cmd>BufferLineGoToBuffer 4<CR>', 'Go to tab 4' },
  ['<A-5>'] = { '<cmd>BufferLineGoToBuffer 5<CR>', 'Go to tab 5' },
  ['<A-6>'] = { '<cmd>BufferLineGoToBuffer 6<CR>', 'Go to tab 6' },
  ['<A-7>'] = { '<cmd>BufferLineGoToBuffer 7<CR>', 'Go to tab 7' },
  ['<A-8>'] = { '<cmd>BufferLineGoToBuffer 8<CR>', 'Go to tab 8' },
  ['<A-9>'] = { '<cmd>BufferLineGoToBuffer 9<CR>', 'Go to tab 9' },
  ['<A-0>'] = { '<cmd>BufferLineGoToBuffer 10<CR>', 'Go to tab 10' },
  ['<A-c>'] = { '<cmd>bd<CR>', 'Close tab' },
  ['<A-C>'] = { '<cmd>bd!<CR>', 'Force close tab' },
  ['<A-o>'] = { '<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>', 'Close all but current tab' },
  ['<A-q>'] = { '<cmd>%bd<cr>', 'Close all tabs' },
  ['<A-n>'] = { '<cmd>Alpha<cr>', 'Open alpha' },
  ['<Esc>'] = { ':noh<Esc>', 'Esc removing highlight' },
  ['q:'] = { '<nop>', 'Disabled' },
  ['<F2>'] = { vim.lsp.buf.rename, 'Rename symbol' },
  ['[d'] = { vim.diagnostic.goto_prev, 'Previous diagnostic' },
  [']d'] = { vim.diagnostic.goto_next, 'Next diagnostic' },
  ['gd'] = { vim.lsp.buf.definition, 'Goto definition' },
  ['gD'] = { vim.lsp.buf.declaration, 'Goto declaration' },
  ['gi'] = { vim.lsp.buf.implementation, 'Goto implementation' },
  ['gr'] = { vim.lsp.buf.references, 'Goto references' },
  ['gl'] = { vim.diagnostic.open_float, 'Diagnostic' },
  --  ["zR"] = { require("ufo").openAllFolds, "Open all folds" },
  --["zM"] = { require("ufo").closeAllFolds, "Close all folds" },
  -- ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature help"},
  K = { vim.lsp.buf.hover, 'Hover' },
  Q = { '<nop>', 'Disabled' },
}

wk.register({
  b = {
    name = 'buffers',
    o = { '<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>', 'Buffer only' },
    --    b = { "<cmd>Buffers<cr>", "Buffer fuzzy-find" },
    a = { '<cmd>%bd<cr>', 'Buffer close-all' },
    --    n = { "<cmd>BufferNext<cr>", "Buffer next" },
    --    p = { "<cmd>BufferPrevious<cr>", "Buffer previous" },
    d = { '<cmd>bp | bd #<cr>', 'Buffer delete' },
    --    t = { "<cmd>bdelete! term-slider<cr>", "Buffer terminal-delete" },
    --    l = { "<cmd>buffers<cr>", "Buffer list-all" },
    s = { '<cmd>w<cr>', 'Buffer save' },
    c = { ':b ', 'Buffer command' },
  },
}, { prefix = '<leader>' })

wk.register({
  f = {
    name = 'Find',
    f = { '<cmd>Telescope find_files<cr>', 'Files' },
    g = { '<cmd>Telescope git_files<cr>', 'Git files' },
    h = { '<cmd>Telescope oldfiles<cr>', 'Recent files' },
    r = { '<cmd>Telescope live_grep<cr>', 'Search text on files' },
    t = { '<cmd>Telescope treesitter<cr>', 'TreeSitter' },
    -- l = { "<cmd>Lines<cr>", "Search text on open files" },
  },
}, { prefix = '<leader>' })

wk.register({
  o = {
    name = 'toggle',
    --    t = { "<cmd>call ChooseTerm('term-slider', 1)<cr>", "Terminal split" },
    a = { '<cmd>AerialToggle!<CR>', 'Aerial' },
    s = { '<cmd>setlocal spell! spelllang=en_us,pt<cr>', 'Spellcheck' },
    p = { '<cmd>CHADopen<cr>', 'File tree' },
    l = { '<cmd>set list!<cr>', 'List chars' },
    n = { '<cmd>set relativenumber!<cr>', 'Relativenumber' },
    --    i = { "<cmd>IndentBlanklineToggle<cr>", "Toggle indentline" },
    --    b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Current Line Blame" },
  },
}, { prefix = '<leader>' })

wk.register({
  v = {
    name = 'vim',
    q = { '<cmd>qa!<cr>', 'Exit vim' },
    c = { '<cmd>wqa<cr>', 'Save and exit' },
    s = { '<cmd>wa<cr>', 'Save all files' },
    r = { '<cmd>source ~/.config/nvim/init.lua<cr>', 'Reload source' },
  },
}, { prefix = '<leader>' })

wk.register({
  l = {
    name = 'lsp',
    c = { vim.lsp.buf.code_action, 'Code action' },
    q = { vim.diagnostic.setqflist, 'Quick fix list' },
    l = { vim.diagnostic.setloclist, 'Loc list' },
  },
}, { prefix = '<leader>' })

wk.register({
  w = {
    name = 'window',
    w = { '<C-W>W', 'Move to other window' },
    d = { '<C-W>c', 'Delete window' },
    s = { '<C-W>s', 'Split window below' },
    v = { '<C-W>v', 'Split window aside' },
    k = { '<C-W>k', 'Move above' },
    l = { '<C-W>l', 'Move right' },
    j = { '<C-W>j', 'Move below' },
    h = { '<C-W>h', 'Move left' },
    H = { '<C-W>5<', 'Expand window left' },
    J = { '<cmd>resize +5<cr>', 'Expand window below' },
    L = { '<C-W>5>', 'Expand window right' },
    K = { '<cmd>resize -5<cr>', 'Expand window up' },
    ['='] = { '<C-W>=', 'Balance window' },
    ['-'] = { '<C-W>_', 'Maximaze window' },
    q = { 'ZQ', 'Close window' },
    c = { 'ZZ', 'Save and close window' },
    ['<Up>'] = { '<C-W>k', 'Move above' },
    ['<Right>'] = { '<C-W>l', 'Move right' },
    ['<Down>'] = { '<C-W>j', 'Move below' },
    ['<Left>'] = { '<C-W>h', 'Move left' },
  },
}, { prefix = '<leader>' })
