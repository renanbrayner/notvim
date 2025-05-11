local utils = require 'utils'

local status_ok, wk = pcall(require, 'which-key')
if not status_ok then
  vim.notify('Error requiring which-key', vim.log.levels.ERROR)
  return
end

wk.add {
  -- NORMAL MODE
  {
    mode = { 'n' },
    { ',',        '<cmd>HopWord<cr>',    desc = 'Hop window' },
    { '<A-Up>',   '<cmd>m .-2<CR>==',    desc = 'Move line up' },
    { '<A-k>',    '<cmd>m .-2<CR>==',    desc = 'Move line up' },
    { '<A-Down>', '<cmd>m .+1<CR>==',    desc = 'Move line down' },
    { '<A-j>',    '<cmd>m .+1<CR>==',    desc = 'Move line down' },
    { '<C-_>',    '<cmd>normal gcc<cr>', desc = 'Comment line' },
  },

  -- VISUAL MODE
  {
    mode = { 'v' },
    { ',',        '<cmd>HopWord<cr>',     desc = 'Hop window' },
    { '<A-k>',    ":m '<-2<CR>gv=gv",     desc = 'Move selection up' },
    { '<A-j>',    ":m '>+1<CR>gv=gv",     desc = 'Move selection down' },
    { '<A-Up>',   ":m '<-2<CR>gv=gv",     desc = 'Move selection up' },
    { '<A-Down>', ":m '>+1<CR>gv=gv",     desc = 'Move selection down' },
    { '<C-_>',    '<cmd>normal gcgv<cr>', desc = 'Comment selection' },
  },

  -- FUCK WHAT MODE IS THIS?
  {
    mode = { 'o' },
    { ',', '<cmd>HopWord<cr>', desc = 'Hop window' },
  },

  {
    '<C-p>',
    utils.ControlP,
    desc = 'Search files',
  },
  {
    '<C-s>',
    '<cmd>:w<cr>',
    desc = 'Save file',
  },
  {
    '<A-s>',
    '<cmd>BufferLinePick<cr>',
    desc = 'Hop to buffer',
  },
  {
    '<A-<>',
    '<cmd>BufferLineMovePrev<CR>',
    desc = 'Previous tab',
  },
  {
    '<A->>',
    '<cmd>BufferLineMoveNext<CR>',
    desc = 'Next tab',
  },
  {
    '<A-,>',
    '<cmd>BufferLineCyclePrev<CR>',
    desc = 'Previous tab',
  },
  {
    '<A-.>',
    '<cmd>BufferLineCycleNext<CR>',
    desc = 'Next tab',
  },
  {
    '<A-1>',
    '<cmd>BufferLineGoToBuffer 1<CR>',
    desc = 'Go to tab 1',
  },
  {
    '<A-2>',
    '<cmd>BufferLineGoToBuffer 2<CR>',
    desc = 'Go to tab 2',
  },
  {
    '<A-3>',
    '<cmd>BufferLineGoToBuffer 3<CR>',
    desc = 'Go to tab 3',
  },
  {
    '<A-4>',
    '<cmd>BufferLineGoToBuffer 4<CR>',
    desc = 'Go to tab 4',
  },
  {
    '<A-5>',
    '<cmd>BufferLineGoToBuffer 5<CR>',
    desc = 'Go to tab 5',
  },
  {
    '<A-6>',
    '<cmd>BufferLineGoToBuffer 6<CR>',
    desc = 'Go to tab 6',
  },
  {
    '<A-7>',
    '<cmd>BufferLineGoToBuffer 7<CR>',
    desc = 'Go to tab 7',
  },
  {
    '<A-8>',
    '<cmd>BufferLineGoToBuffer 8<CR>',
    desc = 'Go to tab 8',
  },
  {
    '<A-9>',
    '<cmd>BufferLineGoToBuffer 9<CR>',
    desc = 'Go to tab 9',
  },
  {
    '<A-0>',
    '<cmd>BufferLineGoToBuffer 10<CR>',
    desc = 'Go to tab 10',
  },
  {
    '<A-c>',
    '<cmd>bd<CR>',
    desc = 'Close tab',
  },
  {
    '<A-C>',
    '<cmd>bd!<CR>',
    desc = 'Force close tab',
  },
  {
    '<A-o>',
    '<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>',
    desc = 'Close all but current tab',
  },
  {
    '<A-q>',
    '<cmd>%bd<cr>',
    desc = 'Close all tabs',
  },
  {
    '<A-n>',
    '<cmd>Alpha<cr>',
    desc = 'Open alpha',
  },
  {
    '<Esc>',
    ':noh<Esc>',
    desc = 'Esc removing highlight',
  },
  {
    'q:',
    '<nop>',
    desc = 'Disabled',
  },
  {
    '<F2>',
    vim.lsp.buf.rename,
    desc = 'Rename symbol',
  },
  {
    '[d',
    vim.diagnostic.goto_prev,
    desc = 'Previous diagnostic',
  },
  {
    ']d',
    vim.diagnostic.goto_next,
    desc = 'Next diagnostic',
  },
  {
    'gd',
    vim.lsp.buf.definition,
    desc = 'Goto definition',
  },
  {
    'gD',
    vim.lsp.buf.declaration,
    desc = 'Goto declaration',
  },
  {
    'gi',
    vim.lsp.buf.implementation,
    desc = 'Goto implementation',
  },
  {
    'gr',
    vim.lsp.buf.references,
    desc = 'Goto references',
  },
  {
    'gl',
    vim.diagnostic.open_float,
    desc = 'Diagnostic',
  },
  --  ["zR"] = { require("ufo").openAllFolds, "Open all folds" },
  --["zM"] = { require("ufo").closeAllFolds, "Close all folds" },
  -- ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature help"},
  {
    'K',
    vim.lsp.buf.hover({ border = 'rounded' }),
    desc = 'Hover',
  },
  {
    'Q',
    '<nop>',
    desc = 'Disabled',
  },
  {
    '<F3>',
    function()
      vim.lsp.buf.format { async = true }
    end,
    desc = 'Format file',
  },

  {
    '<leader>c',
    '<cmd>Cheat<cr>',
    desc = 'Open cheat sheet',
  },

  -- BUFFERS
  { '<leader>b', group = 'Buffers' },
  {
    '<leader>bo',
    '<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>',
    desc = 'Buffer only',
  },
  --    b = { "<cmd>Buffers<cr>", "Buffer fuzzy-find" },
  {
    '<leader>ba',
    '<cmd>%bd<cr>',
    desc = 'Buffer close-all',
  },
  --    n = { "<cmd>BufferNext<cr>", "Buffer next" },
  --    p = { "<cmd>BufferPrevious<cr>", "Buffer previous" },
  {
    '<leader>bd',
    '<cmd>bp | bd #<cr>',
    desc = 'Buffer delete',
  },
  --    t = { "<cmd>bdelete! term-slider<cr>", "Buffer terminal-delete" },
  --    l = { "<cmd>buffers<cr>", "Buffer list-all" },
  {
    '<leader>bs',
    '<cmd>w<cr>',
    desc = 'Buffer save',
  },
  {
    '<leader>bc',
    ':b ',
    desc = 'Buffer command',
  },

  -- FIND
  { '<leader>f', group = 'Find' },
  {
    '<leader>ff',
    '<cmd>Telescope find_files<cr>',
    desc = 'Files',
  },
  {
    '<leader>fg',
    '<cmd>Telescope git_files<cr>',
    desc = 'Git files',
  },
  {
    '<leader>fh',
    '<cmd>Telescope oldfiles<cr>',
    desc = 'Recent files',
  },
  {
    '<leader>fr',
    '<cmd>Telescope live_grep<cr>',
    desc = 'Search text on files',
  },
  {
    '<leader>ft',
    '<cmd>Telescope treesitter<cr>',
    desc = 'TreeSitter',
  },

  -- TOGGLE
  { '<leader>o', group = 'Toggle' },
  {
    '<leader>oa',
    '<cmd>AerialToggle!<CR>',
    desc = 'Aerial',
  },
  {
    '<leader>os',
    '<cmd>setlocal spell! spelllang=en_us,pt<cr>',
    desc = 'Spellcheck',
  },
  {
    '<leader>op',
    '<cmd>CHADopen<cr>',
    desc = 'File tree',
  },
  {
    '<leader>ol',
    '<cmd>set list!<cr>',
    desc = 'List chars',
  },
  {
    '<leader>on',
    '<cmd>set relativenumber!<cr>',
    desc = 'Relativenumber',
  },

  -- REST CLIENT
  { '<leader>r', group = 'Reast Client' },
  {
    '<leader>rr',
    '<Plug>RestNvim',
    desc = 'Run the request under cursor',
  },
  {
    '<leader>rl',
    '<Plug>RestNvimLast',
    desc = 'Re-run the last request',
  },
  {
    '<leader>rc',
    '<Plug>RestNvimPreview',
    desc = 'Preview the request cURL command',
  },

  -- FLOATERM
  { '<leader>t', group = 'Floaterm' },
  {
    '<leader>tg',
    '<cmd>FloatermNew lazygit<cr>',
    desc = 'Open lazygit',
  },
  {
    '<leader>td',
    '<cmd>FloatermNew lazydocker<cr>',
    desc = 'Open lazydocker',
  },
  {
    '<leader>tr',
    '<cmd>FloatermNew ranger<cr>',
    desc = 'Open ranger',
  },
  {
    '<leader>tt',
    '<cmd>FloatermNew --height=0.3 --width=1.0 --wintype=split --position=bottom<cr>',
    desc = 'Open terminal',
  },

  -- VIM
  { '<leader>v', group = 'Vim' },
  {
    '<leader>vq',
    '<cmd>qa!<cr>',
    desc = 'Exit vim',
  },
  {
    '<leader>vc',
    '<cmd>wqa<cr>',
    desc = 'Save and exit',
  },
  {
    '<leader>vs',
    '<cmd>wa<cr>',
    desc = 'Save all files',
  },
  {
    '<leader>vr',
    '<cmd>source ~/.config/nvim/init.lua<cr>',
    desc = 'Reload source',
  },

  -- LSP
  { '<leader>l', group = 'LSP' },
  {
    '<leader>lc',
    vim.lsp.buf.code_action,
    desc = 'Code action',
  },
  {
    '<leader>lq',
    vim.diagnostic.setqflist,
    desc = 'Quick fix list',
  },
  {
    '<leader>ll',
    vim.diagnostic.setloclist,
    desc = 'Loc list',
  },

  -- Window
  { '<leader>w', group = 'Window' },
  {
    '<leader>ww',
    '<C-W>W',
    desc = 'Move to other window',
  },
  {
    '<leader>wd',
    '<C-W>c',
    desc = 'Delete window',
  },
  {
    '<leader>ws',
    '<C-W>s',
    desc = 'Split window below',
  },
  {
    '<leader>wv',
    '<C-W>v',
    desc = 'Split window aside',
  },
  {
    '<leader>wk',
    '<C-W>k',
    desc = 'Move above',
  },
  {
    '<leader>wl',
    '<C-W>l',
    desc = 'Move right',
  },
  {
    '<leader>wj',
    '<C-W>j',
    desc = 'Move below',
  },
  {
    '<leader>wh',
    '<C-W>h',
    desc = 'Move left',
  },
  {
    '<leader>wH',
    '<C-W>5<',
    desc = 'Expand window left',
  },
  {
    '<leader>wJ',
    '<cmd>resize +5<cr>',
    desc = 'Expand window below',
  },
  {
    '<leader>wL',
    '<C-W>5>',
    desc = 'Expand window right',
  },
  {
    '<leader>wK',
    '<cmd>resize -5<cr>',
    desc = 'Expand window up',
  },
  {
    '<leader>w=',
    '<C-W>=',
    desc = 'Balance window',
  },
  {
    '<leader>w-',
    '<C-W>_',
    desc = 'Maximaze window',
  },
  {
    '<leader>wq',
    'ZQ',
    desc = 'Close window',
  },
  {
    '<leader>wc',
    'ZZ',
    desc = 'Save and close window',
  },
  {
    '<leader>w<Up>',
    '<C-W>k',
    desc = 'Move above',
  },
  {
    '<leader>w<Right>',
    '<C-W>l',
    desc = 'Move right',
  },
  {
    '<leader>w<Down>',
    '<C-W>j',
    desc = 'Move below',
  },
  {
    '<leader>w<Left>',
    '<C-W>h',
    desc = 'Move left',
  },
}
