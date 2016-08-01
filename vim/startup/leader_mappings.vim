
" Window movement shortcuts
" move to the window in the direction shown, or create a new window
function! WinMove(key)
	let t:curwin = winnr()
	echo 'windMove'
	exec "wincmd ".a:key
	if (t:curwin == winnr())
		if (match(a:key,'[jk]'))
			wincmd v
		else
			wincmd s
		endif
		exec "wincmd ".a:key
	endif
endfunction

map <silent> ,h :call WinMove('h')<cr>
map <silent> ,j :call WinMove('j')<cr>
map <silent> ,k :call WinMove('k')<cr>
map <silent> ,l :call WinMove('l')<cr>
" Toggle NERDTree
nmap <silent> ,m :NERDTreeToggle<cr>
" expand to the path of the file in the current buffer
nmap <silent> ,M :NERDTreeFind<cr>
nmap <silent> ,N :CtrlPBuffer<cr>
nmap <silent> ,n :CtrlP<cr>

map ,qa :qa<cr>
map <silent> ,sl :so Session.vim<cr> 
map ,te :tabedit %<cr>
map ,tc :tabclose<cr>

map <silent> <C-h> :call WinMove('h')<cr>
map <silent> <C-j> :call WinMove('j')<cr>
map <silent> <C-k> :call WinMove('k')<cr>
map <silent> <C-l> :call WinMove('l')<cr>


