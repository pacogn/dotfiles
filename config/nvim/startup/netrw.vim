"make netrw view tree by default
let g:netrw_liststyle=3
let g:netrw_banner = 0
let g:netrw_altfile = 1
augroup netrw
    autocmd!
    autocmd FileType netrw nnoremap <buffer>\q :bd<cr>
    autocmd FileType netrw nnoremap <buffer> <nowait> q :bd<cr>
    autocmd FileType netrw nmap <buffer> <silent> <nowait> <c-q>  <Plug>NetrwTreeSqueeze
    " autocmd FileType netrw nmap <buffer><c-x> <Plug>NetrwTreeSqueeze<cr>
augroup END
