
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

nmap ,b :bn<cr>:bd #<cr>
nmap ,ee :!
nmap ,ed <C-w><C-h><C-w><C-c>
nmap ,F <Plug>(easymotion-F)
nmap ,f <Plug>(easymotion-f)
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

nmap <silent> ,r :CtrlPBuffer<cr>
nmap <silent> ,t :CtrlP<cr>
nmap <silent> ,tn :tabn<cr>
nmap <silent> ,tp :tabp<cr>
noremap s <NOP>
" nmap ,sn <Plug>(easymotion-sn)
nmap ,ss <Plug>(easymotion-prefix)
nmap sn <Plug>(easymotion-sn)
" learned this trick by looking into t/easymotion_spec.vim
nmap ss <Plug>(easymotion-prefix)

map ,qa :qa<cr>
map <silent> ,sl :so Session.vim<cr> 
map ,te :tabedio %<cr>
map ,tc :tabclose<cr>
nmap ,w <C-w><C-q>

" map quit :q<cr>
nnoremap go :call EasyMotion#S(-1,0,0)<cr> 
map full :tabedit %<cr>
map close :tabclose<cr>

