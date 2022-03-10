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

function! ControlP()
	if &filetype == 'coc-explorer' || &filetype == 'NvimTree'
		:wincmd h
	endif
	silent! !git rev-parse --is-inside-work-tree
	if v:shell_error == 0
		:GFiles --cached --others --exclude-standard
		" :Telescope git-files
	else
		:Files
		" :Telescope
	endif
endfunction

" Adding new snippets

function ReloadSnippetsAll()
  lua require("luasnip").cleanup()
  lua require("luasnip.loaders.from_vscode").load()
  lua require("luasnip.loaders.from_snipmate").load()
endfunction

au BufWritePost *.snippets :call ReloadSnippetsAll()

command! ReloadSnippets :call ReloadSnippetsAll()
command! EditSnippets :sp ~/.config/nvim/snippets/%:e.snippets

" Unfolding all folds from start
au BufNewFile,BufRead * normal! zR
]])
