let g:is_running_fixlint = 0

function! OnNeomakeJobFinished() abort
    if g:is_running_fixlint
        let g:is_running_fixlint = 0
        silent ! !
    endif
endfunction

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_typescript_enabled_makers = ['eslint']
let eslintMaker = {
	    \'exe': 'eslint',
	    \'args': '-f compact --ext ".js,.ts" --fix',
	\ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
	\   '%W%f: line %l\, col %c\, Warning - %m,%-G,%-G%*\d problems%#',
	    \}
let g:neomake_javascript_fixlint_maker = eslintMaker
let g:neomake_typescript_fixlint_maker = eslintMaker

augroup my_neomake_autocmds
    au!
    autocmd User NeomakeJobFinished call OnNeomakeJobFinished()
    autocmd ColorScheme * hi NeomakeErrorSign guifg=#ff0000
        " \ hi NeomakeWarningSign ctermfg=yellow
augroup END
"
" this is eslint fallback version.  'benjie/neomake-local-eslint.vim' will find local eslint for us
" let g:neomake_javascript_eslint_exe='/Users/davidsu/.nvm/versions/node/v4.2.1/bin/eslint'
" let g:neomake_error_sign = '❌'
 let g:neomake_error_sign = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
" let g:neomake_error_sign = {
" 	\ 'text': 'X',
" 	\ 'texthl': 'ErrorMsg',
" 	\ }
" let g:neomake_warning_sign = {'text': '💩', 'texthl': 'NeomakeWarningSign'}
let g:neomake_warning_sign = {'text': 'W', 'texthl': 'NeomakeWarningSign'}
