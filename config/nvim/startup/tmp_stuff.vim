function! ViewKeys(map)
    redir! > ~/.vim-tmp/vim_keys.txt
    :silent execute a:map 
    :redir END 
    :e ~/.vim-tmp/vim_keys.txt
endfunction

function! ViewAucmd()
	redir! > ~/.vim-tmp/vim_keys.txt
	:silent execute 'autocmd' 
	:redir END 
	:e ~/.vim-tmp/vim_keys.txt
endfunction

"source http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  " echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  " call setline(1, 'You entered:    ' . a:cmdline)
  " call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  " call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction


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

