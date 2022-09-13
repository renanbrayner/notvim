local filetype = vim.bo.filetype

vim.cmd([[
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
au BufEnter * if &buftype == 'terminal' | startinsert | else | stopinsert | endif

function! ChooseTerm(termname, slider)
	let pane = bufwinnr(a:termname)
	let buf = bufexists(a:termname)
	if pane > 0
		" pane is visible
		if a:slider > 0
			:exe pane . "wincmd c"
		else
			:exe "e #"
		endif
	elseif buf > 0
		" buffer is not in pane
		if a:slider
			:exe "botright 10sp"
		endif
		:exe "buffer " . a:termname
	else
		" buffer is not loaded, create
		if a:slider
			:exe "botright 10sp"
		endif
		:terminal
		:exe "f " a:termname
	endif
endfunction

" Unfolding all folds from start commented because of ufo plugin
" au BufNewFile,BufRead * normal! zR
au BufEnter * if &ft ==# 'CHADTree' | set winhighlight=Normal:NvimTreeNormal | endif
au BufEnter * if &ft ==# 'CHADTree' | setlocal nolist | endif
]])

local function has_value(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

function ControlP()
  local excluded_filetypes = {
    "coc-explorer",
    "NvimTree",
    "CHADTree",
  }
  if has_value(excluded_filetypes, filetype) then
    vim.api.nvim_command("wincmd h") -- go left to leave the tree on the right
  end
  vim.fn.system("git rev-parse --is-inside-work-tree")
  if vim.v.shell_error == 0 then
    -- vim.cmd([[:GFiles]])
    vim.cmd([[:Telescope git_files]])
  else
    -- vim.cmd([[:Files]])
    vim.cmd([[:Telescope find_files]])
  end
end
