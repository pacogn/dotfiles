
" vim: foldmethod=marker
if has('nvim')
    " Mappings {{{1
    tnoremap \\ <C-\><C-n>
	tnoremap ,, <C-\><C-n>
    tnoremap ,k <C-\><C-n>:wincmd k<cr>
    tnoremap ,j <C-\><C-n>:wincmd j<cr>
    tnoremap ,h <C-\><C-n>:wincmd h<cr>
    tnoremap ,l <C-\><C-n>:wincmd l<cr>
    tnoremap ]b <C-\><C-n>:bnext<cr>
    tnoremap [b <C-\><C-n>:bprevious<cr>
    tnoremap ,c loadall<cr>reload<cr>fg[blue]='\033[38;5;111m'<cr>source $DOTFILES/prompt<cr>clear<cr>
    tnoremap ,. <C-\><C-n><c-^>
    tnoremap ,ev <C-\><C\n>:source ~/.dotfiles/config/nvim/init.vim<cr> 
    tnoremap <silent>,n <C-\><C-n>:NERDTreeToggle<cr>
    tnoremap ,nt  !'spec.js !'unit.js !'it.js
    tnoremap ,ot 'spec.js \| 'unit.js \| 'it.js
    " AutoCommands {{{1
    autocmd BufWinEnter,WinEnter term://* if &buftype == 'terminal' | startinsert | endif
    " autocmd TermOpen * :let @a='fg[blue]="\033[38;5;1m"' | put a | normal <cr>
    " autocmd TermOpen * ,c
    " }}}

endif
