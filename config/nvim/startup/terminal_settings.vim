function! ClearTermScrollback()
    set scrollback=0
    sleep 100m
    redraw
    set scrollback=1000
endfunction
if has('nvim')
    " Mappings {{{1
    tnoremap \\ <C-\><C-n>
    " stop fg job and rerun last command
    tnoremap <C-x> <C-c><C-l><C-\><C-n>:call ClearTermScrollback()<cr>i<C-p><cr>
	tnoremap ,, <C-\><C-n>
    tnoremap ,k <C-\><C-n>:wincmd k<cr>
    tnoremap ,j <C-\><C-n>:wincmd j<cr>
    tnoremap <C-h> <C-\><C-n>:wincmd h<cr>
    tnoremap ,h <C-\><C-n>:wincmd h<cr>
    tnoremap ,l <C-\><C-n>:wincmd l<cr>
    tnoremap <silent><C-l> <C-l><C-\><C-n>:call ClearTermScrollback()<cr>i
    tnoremap ]b <C-\><C-n>:bnext<cr>
    tnoremap [b <C-\><C-n>:bprevious<cr>
    tnoremap ]t <C-\><C-n>:tabnext<cr>
    tnoremap [t <C-\><C-n>:tabprevious<cr>
    "¬ = alt+l
    tnoremap ¬ loadall<cr>reload<cr>fg[blue]='\033[38;5;111m'<cr>source $DOTFILES/prompt<cr>clear<cr> 
    tnoremap ,. <C-\><C-n><c-^>
    tnoremap ,ev <C-\><C\n>:source ~/.dotfiles/config/nvim/init.vim<cr> 
    tnoremap ,nt  !'spec.js !'unit.js !'it.js
    tnoremap ,ot 'spec.js \| 'unit.js \| 'it.js
    tnoremap ,ds '/documentServices/
    augroup terminal_group
	au!
	au TermOpen *zsh setlocal nobuflisted 
    augroup END
    " tmap <silent><Esc> <esc><C-\><c-n>
endif
