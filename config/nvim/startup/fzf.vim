"MAPPINGS{{{
"--------------------------------------------------------------------------------
" Mapping selecting mappings
nmap ,<tab> <plug>(fzf-maps-n)
xmap ,<tab> <plug>(fzf-maps-x)
omap ,<tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)


nmap 1m :Marks<cr>
nmap \v :Vimrc<cr>
nmap \a :Ag 
"-----------------------------------------------------------------------------}}}
"GLOBALS                                                                      {{{ 
"--------------------------------------------------------------------------------
let g:fzf_launcher = "$DOTFILES/bin/itermFzfVim %s"
let g:fzf_layout = { 'down': '~60%' }
" let g:fzf_command_prefix = 'Fzf'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

"-----------------------------------------------------------------------------}}}
"FUNCTIONS                                                                    {{{ 
"--------------------------------------------------------------------------------

function! s:defaultPreview()
    return fzf#vim#with_preview({'down': '100%'}, 'up:50%', 'ctrl-g')
endfunction
function! Noop(...)
endfunction
function! FzfLet()
    redir => cout
        silent execute 'let g:'
        silent execute 'let b:'
        silent execute 'let w:'
        silent execute 'let t:'
        silent execute 'let s:'
        silent execute 'let l:'
        silent execute 'let v:'
    redir END
    let list = sort(split(cout, '\n'))
    call fzf#run({
    \  'source':  list,
    \  'sink':    function('Noop') })
endfunction

function! s:buflisted()
    return filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&filetype") != "qf"')
endfunction

function! AgAllBLines(...)
    let bufs = map(s:buflisted(), 'bufname(v:val)')
    let agfiles = '-G '''.join(bufs, '|').''''
    let query = get(a:000, 0, '^')
    if !len(query)
      let query = '^'
    endif
    let query = agfiles.' '''.query.''''
    call fzf#vim#ag_raw(query, 
             \fzf#vim#with_preview({'dir':expand('%:p:h'), 'down': '100%'},'up:50%', 'ctrl-g'))
endfunction
function! AgBLines(...)
    let query = get(a:000, 0, '^')
    if !len(query)
      let query = '^'
    endif
    let filename = expand('%:t')
    if len(filename) == 0
        execute('BLines')
        return
    endif
    let query = '-G '.filename.' '.query
   call fzf#vim#ag_raw(query, 
            \fzf#vim#with_preview({'dir':expand('%:p:h'), 'down': '100%'},'up:50%', 'ctrl-g'))

endfunction

function! FzfSet()
    redir => cout
        silent execute 'set'
    redir END
    let list = sort(split(substitute(escape(cout, '-'''), '\t+', '\n', ''), '\n'))
    " let list = split('''' . cout . '''', '\n'))
    call fzf#run({
    \  'source':  list,
    \  'sink':    function('Noop') })
endfunction

function! FindText(text, ...)
    let additionalParams = ( a:0 > 0 ) ? a:1 : ''
    let agcmd = ''''.a:text.''' '.additionalParams
    call fzf#vim#ag_raw(agcmd, s:defaultPreview())
endfunction

function! FindFunction(functionName, ...)
    let additionalParams = ( a:0 > 0 ) ? a:1 : ''
    " (?<=...) positive lookbehind: must constain
    " (?=...) positive lookahead: must contain
    let agcmd = '''(?<=function\s)'.a:functionName.'(?=\()|'.a:functionName.'\s*:'' '.additionalParams
    call fzf#vim#ag_raw(agcmd, s:defaultPreview())
endfunction

function! FindAssignment(variableName, ...)
    let additionalParams = ( a:0 > 0 ) ? a:1 : ''
    " (?<=...) positive lookbehind: must constain
    " (?=...) positive lookahead: must contai
    let agcmd = '''(=|:).*\b'.a:variableName.'\b'' | ag -v ''\('' '.additionalParams
    " call histadd('cmd', 'Agraw '''''.agcmd.''' -A 0 -B 0''')
    call fzf#vim#ag_raw(agcmd, s:defaultPreview())
endfunction

function! FindUsage(variableName, ...)
    let additionalParams = ( a:0 > 0 ) ? a:1 : ''
    let agcmd = '''(?<!function\s)\b'.a:variableName.'(?=\()'' '.additionalParams
    " call histadd('cmd', 'Agraw '''''.agcmd.''' -A 0 -B 0''')
    call fzf#vim#ag_raw(agcmd, s:defaultPreview())
endfunction

function! GoToDeclaration()
    let l:pos = getpos('.')
    let l:currFileName = expand('%')
    let l:lineFromCursorPosition = strpart(getline('.'), getpos('.')[2])
    let l:wordUnderCursor = expand('<cword>')
    let l:isFunction = match(l:lineFromCursorPosition , '^\(\w\|\s\)*(') + 1
    silent TernDef
    if join(l:pos) == join(getpos('.'))
        "can't jump to definition with tern, do a search with ag + fzf
        if l:isFunction
            FindNoTestFunction(l:wordUnderCursor)
        else
            call fzf#vim#ag(expand('<cword>'), s:defaultPreview() ) 
        endif
        let g:searchedKeyword=l:wordUnderCursor
        " echom 'search keyword: ' . l:wordUnderCursor
    else
        let l:newCursorLine = getline('.')
        let l:newCurrFileName = expand('%')
        let l:regex = '^\s*' . l:wordUnderCursor . '\s*\(,\?\|\(:\s*' . l:wordUnderCursor . ',\?\)\)\s*$'
        echom l:regex
        if l:newCurrFileName != l:currFileName && match(l:newCursorLine, '\((\|=\)') < 0 && match(getline('.'), regex ) + 1
            "we are inside a module.exports, maybe we can get to the line where the function is declared
            echom 'the line: ' . getline('.')
            call search(l:wordUnderCursor . '\s*\((\|=\)')
            " note that i changed this function in python to allow `add_jump_position` argument
            py3 tern_lookupDefinition("edit", add_jump_position=False)
        endif
        normal zz
        call CursorPing()
    endif
endfunction

function! FZFYankRingSink(val)
    let @@=a:val
    let @0=a:val
    put a:val
endfunction
function! FZFYankRing()
    call fzf#run({
          \'dir': g:yankring_history_dir,
          \'source': 'cat ' . g:yankring_history_file . '_v2.txt',
          \'sink': function('FZFYankRingSink')
          \})
endfunction
"-----------------------------------------------------------------------------}}}
"COMMANDS                                                                     {{{
"--------------------------------------------------------------------------------
command! -nargs=+ FindFunction call FindFunction(<args>)
command! -nargs=+ FindAssignment call FindAssignment(<args>)
command! -nargs=+ FindUsage call FindUsage(<args>)
command! -nargs=+ FindText call FindText(<args>)
command! -nargs=+ FindNoTestFunction call FindFunction(<args>, $IGNORE_TESTS)
command! -nargs=+ FindNoTestAssignment call FindAssignment(<args>, $IGNORE_TESTS)
command! -nargs=+ FindNoTestUsage call FindUsage(<args>, $IGNORE_TESTS)
command! -nargs=+ FindNoTestText call FindText(<args>, $IGNORE_TESTS)
command! -nargs=+ FindOnlyTestFunction call FindFunction(<args>, onlyTest)
command! -nargs=+ FindOnlyTestAssignment call FindAssignment(<args>, onlyTest)
command! -nargs=+ FindOnlyTestUsage call FindUsage(<args>, onlyTest)
command! -nargs=+ FindOnlyTestText call FindText(<args>, onlyTest)

command! ChangeColorScheme :call fzf#run({
    \   'source':
    \     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
    \         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
    \   'sink':    'colo',
    \   'options': '+m',
    \   'left':    30
    \ })<CR>

command! -bang -nargs=* Ag
    \ call fzf#vim#ag(<q-args>,
    \                 s:defaultPreview(),
    \                 <bang>0)

command! FZFMru call fzf#run({
    \  'source':  v:oldfiles,
    \  'sink':    'e',
    \  'options': '-m -x +s',
    \  'down':    '40%'})


command! FZFFiles call fzf#run({
    \  'source': 'find . | egrep -v \.git',
    \  'sink':    'e',
    \  'options': '-m -x +s'})

let onlyTest=' | ag ''(unit|spec).js'''

command! CommandLineCommands call fzf#vim#ag_raw('--nobreak --noheading '.
            \'--ignore ''howto*'' '.
            \'--ignore ''intro*'' '.
            \'--ignore ''edit*'' '.
            \'--ignore ''help*'' '.
            \'--ignore ''if_*'' '.
            \'--ignore ''ft_*'' '.
            \'--ignore ''autoc*'' '.
            \'--ignore ''change*'' '.
            \'--ignore ''gui_*'' '.
            \'--ignore ''eval'' '.
            \'''^\s*\|:''', 
            \{'dir':'/usr/local/Cellar/vim/8.0.0271/share/vim/vim80/doc',
            \'options': ' --preview-window up:50% --preview "''/Users/davidsu/.dotfiles/config/nvim/plugged/fzf.vim/bin/preview.rb''"\ \ {} --bind ''ctrl-g:toggle-preview'''})

command! LetterCommands call fzf#vim#ag_raw('--nobreak --noheading '.
            \'--ignore ''howto*'' '.
            \'--ignore ''intro*'' '.
            \'--ignore ''edit*'' '.
            \'--ignore ''help*'' '.
            \'--ignore ''if_*'' '.
            \'--ignore ''ft_*'' '.
            \'--ignore ''autoc*'' '.
            \'--ignore ''change*'' '.
            \'--ignore ''gui_*'' '.
            \'--ignore ''eval'' '.
            \'''^\|[^-:0-9](\|?|[^:]{0,6}[^)])\|''', 
            \{'dir':'/usr/local/Cellar/vim/8.0.0271/share/vim/vim80/doc',
            \'options': ' --preview-window up:50%:hidden --preview "''/Users/davidsu/.dotfiles/config/nvim/plugged/fzf.vim/bin/preview.rb''"\ \ {} --bind ''ctrl-g:toggle-preview'''})
let s:leaderOrAltChars = '[,`¡™£¢∞§¶•ªº≠œ∑´®†¥¨ˆøπ“‘«åß∂ƒ©˙∆˚¬…æΩ≈ç√∫˜µ≤≥÷q]'
command! -nargs=? AgBLines call AgBLines(<q-args>)
command! -nargs=? AgAllBLines call AgAllBLines(<q-args>)
command! LeaderMappingsDeclaration call fzf#vim#ag('^\s*[^"\s]*map.*' . s:leaderOrAltChars . '[!-~]*', 
            \fzf#vim#with_preview({'dir':'$DOTFILES/config/nvim/startup', 'down': '100%'},'up:30%', 'ctrl-g'))
command! FzfSet call FzfSet()
command! FzfLet call FzfLet()

"-----------------------------------------------------------------------------}}}
"AUTOCOMMANDS                                                                 {{{
"--------------------------------------------------------------------------------
augroup myfzfgroup
    autocmd!
    autocmd VimEnter * command! -nargs=* -bang Agraw call fzf#vim#ag_raw(<args>)
    autocmd FileType javascript nnoremap <buffer>gd :call GoToDeclaration()<cr>
    autocmd FileType nerdtree nnoremap <buffer>,<Tab> :call  FzfNerdTreeMappings()<cr>
    autocmd FileType gitcommit nnoremap <buffer>,<Tab> :call FugitiveMappings()<cr>
augroup END
"-----------------------------------------------------------------------------}}}
