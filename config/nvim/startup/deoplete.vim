if has('nvim')
    let g:python3_host_prog='/usr/local/bin/python3'
    let g:deoplete#enable_at_startup = 1
    inoremap <Esc>  <Esc><Esc>
endif
function! s:my_cr_function()
    " return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction


inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <c-space> <c-r>=UltiSnips#ExpandSnippet()<cr>
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
         \ 'tern#Complete',
         \]
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
let g:UltiSnipsExpandTrigger = '<c-space>'
let g:UltiSnipsListSnippets = '<c-b>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
