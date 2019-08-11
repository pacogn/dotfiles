call plug#begin('~/.config/nvim/plugged')
Plug 'ssh://git@git.walkmedev.com:7999/~david.susskind/walkme-vim-gbrowse.git'
Plug 'tpope/vim-fugitive'                                           " amazing git wrapper for vim
call plug#end()

function! Shell_cmd_completed(...)
    silent! Gbrowse
    quit
endfunction
call timer_start('0', 'Shell_cmd_completed')
