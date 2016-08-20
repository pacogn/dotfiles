
" vim: foldmethod=marker
if has('nvim')
    " Mappings {{{1
    tnoremap \\ <C-\><C-n>
    tnoremap ,k <C-\><C-n>:wincmd k<cr>
    tnoremap ,j <C-\><C-n>:wincmd j<cr>
    tnoremap ,h <C-\><C-n>:wincmd h<cr>
    tnoremap ,l <C-\><C-n>:wincmd l<cr>
    tnoremap ,c fg[blue]='\033[38;5;111m'<cr>source $DOTFILES/prompt<cr>
	tnoremap <C-s> <C-x>
    " AutoCommands {{{1
    autocmd BufWinEnter,WinEnter term://* if &buftype == 'terminal' | startinsert | endif
    " autocmd TermOpen * :let @a='fg[blue]="\033[38;5;1m"' | put a | normal <cr>
    " autocmd TermOpen * ,c
    " }}}

endif
