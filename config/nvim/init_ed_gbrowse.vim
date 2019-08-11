call plug#begin('~/.config/nvim/plugged')
Plug 'ssh://git@git.walkmedev.com:7999/~david.susskind/walkme-vim-gbrowse.git'
Plug 'tpope/vim-fugitive'                                           " amazing git wrapper for vim
call plug#end()

function! s:shell_cmd_completed(...)
    Gbrowse
    quit
endfunction
let s:callbacks = {
\ 'on_exit': function('s:shell_cmd_completed'),
\ }
call jobstart('sleep 0', s:callbacks)
