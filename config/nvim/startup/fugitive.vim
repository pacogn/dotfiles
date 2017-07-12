function! DiffInWebstorm()
    if &ft =~ 'gitcommit'
        if getline('.') !~ ':'
            echom 'which file to diff?'
            return
        endif
        " set cursor to start of line
        call feedkeys('0')
        " find file name with path
        execute 'silent normal! /\v(\w*(\/|$)(\w|-)*)+'."\r"
        " copy file name to register f
        "execute 
        normal "fy$
        let filename=@f
        " open diff in webstorm
        if len(filename)
            execute '!git difftool -t=webstorm '.filename
        endif
    else
        !git difftool -t=webstorm %
    endif
endfunction

augroup fugitiveautocmd
	autocmd!
	autocmd BufEnter *.git/index nmap <buffer> <silent>q :q<cr>
        autocmd BufEnter *.git/index nmap <buffer> <space>gd <C-w><C-o>D
        autocmd BufEnter *.git/index nmap <buffer>gd <C-w><C-o>D
        autocmd BufEnter *.git/COMMIT_EDITMSG silent! normal zMGzogg
        autocmd FileType gitcommit nmap <buffer> ]c <C-n>
        autocmd FileType gitcommit nmap <buffer> [c <C-p>
augroup END
command! DiffInWebstorm !git difftool -t=webstorm %
