function! ViewKeys(map)
    redir! > ~/.vim-tmp/vim_keys.txt
    :silent execute a:map 
    :redir END 
    :e ~/.vim-tmp/vim_keys.txt
endfunction

function! ViewAucmd()
	redir! > ~/.vim-tmp/vim_keys.txt
	:silent execute 'autocmd' 
	:redir END 
	:e ~/.vim-tmp/vim_keys.txt
endfunction

