function! HorizontalResize(key)
	let l:winheight = winheight(0)
	if(a:key == '+')
		exec '5wincmd +'
	else
		exec '5wincmd -'
	endif
	if(l:winheight == winheight(0))
		let g:forcehorizontalresize = 0
	endif
endfunction
function! WinSize(key)
	if(g:forcehorizontalresize)
		call HorizontalResize(a:key)
		return
	endif
	let t:curwin = winnr()
	exec "wincmd l"
	if (t:curwin == winnr())
		exec "wincmd h"
		if (t:curwin == winnr())
			call HorizontalResize(a:key)
			return
		endif
		exec "wincmd l"
	else
		exec "wincmd h"
	endif
	if(a:key == '+')
		exec '5wincmd >'
	else
		exec '5wincmd <'
	endif
endfunction

function! ToggleForceVerticalResize()
	if(g:forcehorizontalresize)
		let g:forcehorizontalresize = 0
	else
		let g:forcehorizontalresize = 1
	endif
	" sleep 800m
	" let g:forcehorizontalresize = 0
endfunction
" increase decrease vertica split by +,_
nnoremap + :call WinSize('+')<cr>
nnoremap _ :call WinSize('-')<cr>
let g:forcehorizontalresize = 0
nnoremap ,v :call ToggleForceVerticalResize()<cr>

nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>
nnoremap <silent> <C-h> :call WinMove('h')<cr>

function! HtmlUnEscape()
  silent s/&lt;/</eg
  silent s/&gt;/>/eg
  silent s/&amp;/\&/eg
endfunction

nnoremap <silent> ,u :call HtmlUnEscape()<cr>

