
" vim: foldmethod=marker
if has('nvim')
    " Mappings {{{1
    tnoremap jk <C-\><C-n>
    tnoremap ,, <C-\><C-n>:wincmd w<cr>
    tnoremap ,k <C-\><C-n>:wincmd k<cr>
    tnoremap ,j <C-\><C-n>:wincmd j<cr>
    tnoremap ,h <C-\><C-n>:wincmd h<cr>
    tnoremap ,l <C-\><C-n>:wincmd l<cr>
	tnoremap <C-s> <C-x>
    " AutoCommands {{{1
    autocmd BufWinEnter,WinEnter term://* if &buftype == 'terminal' | startinsert | endif
    " }}}

endif
