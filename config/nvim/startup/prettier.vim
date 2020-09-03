let g:prettier#config#tab_width = 2
let g:prettier#config#semi = 'true'
let g:prettier#config#single_quote = 'true'

nmap = <Plug>(Prettier)

" when running at every change you may want to disable quickfix
" let g:prettier#quickfix_enabled = 0
" autocmd FileWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

