
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

map <silent> ,a :call WinMove('h')<cr>
nmap ,b :bn<cr>:bd #<cr>
nmap ,ee :!
"end diff --- clean close diff window
nmap ,ed <C-w><C-h><C-w><C-c>
map ,ev :source ~/.dotfiles/config/nvim/init.vim<cr> 
nmap <silent> ,fb :Buffers<cr>
nmap <silent> ,ff :GFiles<cr>
nmap <silent> ,fg :GFiles?<cr>
"map ,fs FoldSearch
map <silent> ,h :call WinMove('h')<cr>
map <silent> ,j :call WinMove('j')<cr>
map <silent> ,k :call WinMove('k')<cr>
map <silent> ,l :call WinMove('l')<cr>
" Toggle NERDTree
nmap <silent> ,n :NERDTreeToggle<cr>
" expand to the path of the file in the current buffer
nmap <silent> ,N :NERDTreeFind<cr>

noremap s <NOP>
" nmap ,sn <Plug>(easymotion-sn)
nmap ,s <Plug>(easymotion-s)
nmap sn <Plug>(easymotion-sn)
nmap ,/ <Plug>(easymotion-sn)

map ,qa :qa<cr>
map <silent> ,sl :so Session.vim<cr> 
map ,tc :tabclose<cr>
map ,te :tabedit %<cr>
map ,tn :tabnext<cr>
map ,tp :tabprevious<cr>
"same as :quit
nmap ,w <C-w><C-q>
map ,, :w<cr>
inoremap ,, <Esc>:w<cr>

nmap <silent> ,m :GFiles<cr>
nmap <silent> ,M :Buffers<cr>
nmap <silent> ,<Space>m :GFiles?<cr>
" map quit :q<cr>
nnoremap go :call EasyMotion#S(-1,0,0)<cr> 
map full :tabedit %<cr>
map close :tabclose<cr>

