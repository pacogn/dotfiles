function! s:sinkMru(selectedFile)
    echom substitute(a:selectedFile, '^[^/]*/', '/', '')
    let cmd = substitute(a:selectedFile, '^[^/]*/', '/', '')
    let cmd = substitute(cmd, '\([^:]*\):\(\d*\)', '+\2 \1', '')  
    execute 'edit '.cmd
    call CursorPing()
endfunction

command! Mru call fzf#run({
      \  'source': 'tail -r $HOME/.mru | nl', 
    \  'sink':    function('s:sinkMru'),
    \  'options': '--no-sort --exact  --preview-window up:50% '.
                \'--preview "echo {} | sed ''s#^[^/]*##'' | xargs ''/Users/davidsu/.dotfiles/config/nvim/plugged/fzf.vim/bin/preview.rb'' -v" '.
                \'--bind ''ctrl-g:toggle-preview,'.
                \'ctrl-e:execute:$DOTFILES/fzf/fhelp.sh {} > /dev/tty''', 
    \  'down':    '70%'})

command! Mrw call fzf#run({
      \  'source': 'tail -r $HOME/.mrw | nl', 
    \  'sink':  function('s:sinkMru'),
    \  'options': '--no-sort --exact',
    \  'down':    '40%'})

function! s:mruIgnore()
    if &ft =~? 'git' ||
      \ &ft =~? 'nerdtree' ||
      \ &ft =~? 'help' ||
      \ expand('%') =~ 'nvim.runtime' ||
      \ expand('%') =~? 'yankring]' ||
      \ expand('%') =~? 'fugitiveblame' ||
      \ expand('%') =~? '/var/folders/.*nvim' ||
      \ expand('%') =~? '\.git/index'
      return 1
    endif
    return 0
endfunction

function! MruWithLineNum()
    if s:mruIgnore()
        return
    endif
    let filename = expand('%:p')
    let shellcmd = 
                \'if [[ -f '.filename.' ]]; then; '.
                \'    [[ ! -f $HOME/.mru ]] && touch $HOME/.mru; '.
                \'    grep -v '.filename.' $HOME/.mru > /tmp/tmpmru; '.
                \'    echo '.filename.':'.getpos('.')[1].' >> /tmp/tmpmru; '.
                \'    tail -n1000 /tmp/tmpmru > $HOME/.mru; '.
                \'fi'
    call system(shellcmd)
endfunction
function! Mru()
    if s:mruIgnore()
        return
    endif
    let filename = expand('%:p')
    let shellcmd = 
                \'if [[ -f '.filename.' ]]; then; '.
                \'    mrufilename='.filename.'; '.
                \'    [[ ! -f $HOME/.mru ]] && touch $HOME/.mru; '.
                \'    saved=$(cat $HOME/.mru | grep '.filename.'); '.
                \'    [[ -n $saved ]] && mrufilename=$saved; '.
                \'    grep -v '.filename.' $HOME/.mru > /tmp/tmpmru; '.
                \'    echo $mrufilename >> /tmp/tmpmru; '.
                \'    tail -n1000 /tmp/tmpmru > $HOME/.mru; '.
                \'fi'
    call system(shellcmd)
endfunction
function! Mrw()
    if s:mruIgnore()
        return
    endif
    let filename = expand('%:p')
    let shellcmd = 
                \'if [[ -f '.filename.' ]]; then; '.
                \'[[ ! -f $HOME/.mrw ]] && touch $HOME/.mrw; '.
                \'grep -v '.filename.' $HOME/.mrw > /tmp/tmpmrw; '.
                \'echo '.filename.' >> /tmp/tmpmrw; '.
                \'tail -n1000 /tmp/tmpmrw > $HOME/.mrw; '.
                \'fi'
    call system(shellcmd)
endfunction

augroup mru
    autocmd!
    autocmd BufWritePost * call Mrw()
    autocmd BufReadPost * call Mru()
    autocmd BufHidden * call MruWithLineNum()
    autocmd VimLeave * call MruWithLineNum()

augroup END
