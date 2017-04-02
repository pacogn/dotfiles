augroup javascript
	function! RunNeomakeEslint()
		if exists("b:neomake_javascript_eslint_exe") && b:neomake_javascript_eslint_exe !~ 'eslint not found' && &ft =~ javascript 
			Neomake
		endif
	endfunction
	autocmd!
	autocmd FileType javascript silent! call LimeLightExtremeties()
	autocmd BufNewFile,BufRead *.es6 set filetype=javascript
	let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'json=javascript', 'stylus', 'html']
	autocmd BufWritePost * call RunNeomakeEslint()
	" find next/prev function by }/{
	" \(function\s*\w*(.*{\)\|\(.*\)\s*=>
	autocmd FileType javascript nnoremap <buffer>{ :set nohlsearch<cr>0?\(function\s*\w*(.*{\)\\|\(.*\)\s*=>\\|\w*([^)]*)\s*{?e<cr>zt
	autocmd FileType javascript nnoremap <buffer>} :set nohlsearch<cr>/\(function\s*\w*(.*{\)\\|\(.*\)\s*=>\\|\w*([^)]*)\s*{/e<cr>zt
	autocmd FileType javascript nnoremap <buffer>,} :set nohlsearch<cr>/function\s*\w*(.*{/e<cr>zt%
	autocmd FileType javascript nnoremap <buffer>,{ :set nohlsearch<cr>j?function\s*\w*(.*{?e<cr>k?function\s*\w*(.*{?e<cr>zt%
augroup END
