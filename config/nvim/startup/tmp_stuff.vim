
function! DefaultTernHandler(lines)
    " echom 'in DefaultTernHandler'
    " let source = map(a:lines, 'substitute(v:val.filename, getcwd(), '', '').'':''.v:val.lnum')
    " echom string(a:lines)
    let source = map(a:lines, 'substitute(v:val.filename, getcwd().''/'', '''', '''').'':''.v:val.lnum')
    " echom string(source)
    let agcmd = 'ag ''(?<!function\s)\b'.expand('<cword>').'(?=\()'' '
    let agresult = system(agcmd)
    let agreslist = split(agresult, '\n')
    let g:a = agreslist
    let source = extend(source, [repeat('-', 40).'END OF TERN RESULTS'.repeat('-', 70)])
    let source = extend(source, agreslist)
    " echom agresult
    let opts = s:defaultPreview()
    let opts.source = source
    function! opts.sink(lines)
        echom string(a:lines)
        execute('edit '.split(a:lines, ':')[0])
    endfunction
    call fzf#run(opts)
endfunction

