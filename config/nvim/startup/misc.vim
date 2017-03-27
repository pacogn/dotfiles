let g:peekaboo_window='vert bo 60new'
let g:diminactive_buftype_blacklist = ['nowrite', 'acwrite']
function! ListDotFiles()
call fzf#run({'dir': '$DOTFILES/config/nvim/',
		\'source': 'find -E . -regex ''(./init.vim|.*startup.+)''',
		\'sink': 'e'})
endfunction
command! ListDotFiles call ListDotFiles()
augroup misc
    autocmd!

augroup END
