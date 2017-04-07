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

augroup gitstatus
	autocmd!
	autocmd BufEnter *.git/index nmap <buffer> <silent>q :q<cr>
augroup END
command! DiffInWebstorm !git difftool -t=webstorm %
