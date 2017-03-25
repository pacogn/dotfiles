autocmd! FileType javascript let g:neomake_javascript_enabled_makers = ['eslint']
"
let g:neomake_javascript_eslint_exe='/Users/davidsu/.nvm/versions/node/v4.2.1/bin/eslint'
" let g:neomake_error_sign = '❌'
let g:neomake_error_sign = {
	\ 'text': '❌',
	\ 'texthl': 'ErrorMsg',
	\ }
let g:neomake_warning_sign = {'text': '💩', 'texthl': 'NeomakeWarningSign'}






" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_loc_list_height = 5
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1
" let g:syntastic_javascript_checkers = ['eslint']

" let g:syntastic_error_symbol = '❌'
" let g:syntastic_style_error_symbol = '⁉️'
" let g:syntastic_warning_symbol = '⚠️'
" let g:syntastic_style_warning_symbol = '💩'

" highlight link SyntasticErrorSign SignColumn
" highlight link SyntasticWarningSign SignColumn
" highlight link SyntasticStyleErrorSign SignColumn
" highlight link SyntasticStyleWarningSign SignColumn
