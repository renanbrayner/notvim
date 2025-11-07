local augroup = vim.api.nvim_create_augroup('GeneralAutocmds', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  pattern = '*',
  desc = 'highlight selection on yank',
  callback = function()
    vim.highlight.on_yank { timeout = 200, visual = true }
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'help',
  command = 'wincmd L',
})

vim.api.nvim_create_autocmd('VimResized', {
  group = augroup,
  command = 'wincmd =',
})

local cursorline_group = vim.api.nvim_create_augroup('AutoCursorLine', { clear = true })

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = cursorline_group,
	callback = function()
		vim.opt_local.cursorline = false
	end,
})

