"MAPPINGS{{{
"--------------------------------------------------------------------------------

" Mapping selecting mappings
nmap <silent> ,t :GFiles<cr>
nmap <silent> ,r :Buffers<cr>
nmap <silent> ,e :GFiles?<cr>
nmap ,<tab> <plug>(fzf-maps-n)
xmap ,<tab> <plug>(fzf-maps-x)
omap ,<tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
"
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
        call fzf#vim#ag_raw(agcmd, fzf#vim#with_preview('right:50%:hidden', 'π'))
endfunction

function! FindFunction(functionName, ...)
        let additionalParams = ( a:0 > 0 ) ? a:1 : ''
        " (?<=...) positive lookbehind: must constain
        " (?=...) positive lookahead: must contain
        let agcmd = '''(?<=function\s)'.a:functionName.'(?=\()|'.a:functionName.'\s*:'' '.additionalParams
        call fzf#vim#ag_raw(agcmd, fzf#vim#with_preview('right:50%:hidden', 'π'))
endfunction

function! FindAssignment(variableName, ...)
        let additionalParams = ( a:0 > 0 ) ? a:1 : ''
        " (?<=...) positive lookbehind: must constain
        " (?=...) positive lookahead: must contai
        let agcmd = '''(=|:).*\b'.a:variableName.'\b'' | ag -v ''\('' '.additionalParams
        " call histadd('cmd', 'Agraw '''''.agcmd.''' -A 0 -B 0''')
        call fzf#vim#ag_raw(agcmd, fzf#vim#with_preview('right:50%:hidden', 'π'))
endfunction

function! FindUsage(variableName, ...)
        let additionalParams = ( a:0 > 0 ) ? a:1 : ''
        let agcmd = '''(?<!function\s)\b'.a:variableName.'(?=\()'' '.additionalParams
        " call histadd('cmd', 'Agraw '''''.agcmd.''' -A 0 -B 0''')
        call fzf#vim#ag_raw(agcmd, fzf#vim#with_preview('right:50%:hidden', 'π'))
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
    \                 <bang>0 ? fzf#vim#with_preview('up:60%')
    \                         : fzf#vim#with_preview('right:50%:hidden', 'π'),
    \                 <bang>0)
command! FZFMru call fzf#run({
    \  'source':  v:oldfiles,
    \  'sink':    'e',
    \  'options': '-m -x +s',
    \  'down':    '40%'})

command! FZFFiles call fzf#run({
    \  'source': 'find . | egrep -v \.git',
    \  'sink':    'e',
    \  'options': '--reverse -m -x +s'})

let onlyTest=' | ag ''(unit|spec).js'''

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
            \'options': ' --preview-window right:50%:hidden --preview "''/Users/davidsu/.dotfiles/config/nvim/plugged/fzf.vim/bin/preview.rb''"\ \ {} --bind ''π:toggle-preview'''})
let s:leaderOrAltChars = '[,`¡™£¢∞§¶•ªº≠œ∑´®†¥¨ˆøπ“‘«åß∂ƒ©˙∆˚¬…æΩ≈ç√∫˜µ≤≥÷`]'
command! LeaderMappingsDeclaration call fzf#vim#ag('^\s*[^"\s]*map.*' . s:leaderOrAltChars . '[!-~]*', 
            \fzf#vim#with_preview({'dir':'$DOTFILES/config/nvim/startup'},'right:50%:hidden', 'π'))
            " \{'dir':'$DOTFILES/config/nvim/startup',
            " \'options': ' --preview-window right:50%:hidden --preview "''/Users/davidsu/.dotfiles/config/nvim/plugged/fzf.vim/bin/preview.rb''"\ \ {} --bind ''π:toggle-preview'''})
command! FzfSet call FzfSet()
command! FzfLet call FzfLet()

"-----------------------------------------------------------------------------}}}
"AUTOCOMMANDS                                                                 {{{
"--------------------------------------------------------------------------------
augroup myfzfgroup
    autocmd!
    autocmd VimEnter * command! -nargs=* -bang Agraw call fzf#vim#ag_raw(<args>)
    autocmd FileType help call ResetCwd()
    autocmd FileType vim call ResetCwd()
augroup END
"-----------------------------------------------------------------------------}}}
