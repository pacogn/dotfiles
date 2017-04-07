function! BufDeleteCurrent()
    let l:bufname=bufname('#')
    if len(l:bufname)
        " there is an alternate file, make sure it's the one that's comming up on screen
        execute('buffer '.l:bufname)
    else
        " there is no 'alternate file' go to whatever other file possible
        bn
    endif
    " delete the alternate buffer ( the one we just exited ).
    " if there was only one buffer then # doesn't exist so this won't do anything. It's hacky but works
    bd! #
    "now we don't want the alternate file to remain the one of the buffer we just deleted
    bn
    bp
    " execute('bd! #')
endfunction
function! FixPowerlineFontsAndSave()
    " can't load powerline fonts on startup, it looks terrible. This is a hacky workaround
    execute('source '.expand('$DOTFILES/config/nvim/startup/airline.vim'))
    execute('source '.expand('$DOTFILES/config/nvim/startup/options.vim'))
    iunmap ,,
    vunmap ,,
    nunmap ,,
    vunmap <space><space>
    nunmap <space><space>
    silent! w
    inoremap ,, <esc>:w<cr>
    nmap ,, :w<cr>
    vmap ,, :w<cr>
    nmap <space><space> :w<cr>
    vmap <space><space> :w<cr>
endfunction
inoremap ,, <esc>:call FixPowerlineFontsAndSave()<cr>
nmap ,, :call FixPowerlineFontsAndSave()<cr>
vmap ,, :call FixPowerlineFontsAndSave()<cr>
nmap <space><space> :call FixPowerlineFontsAndSave()<cr>
vmap <space><space> :call FixPowerlineFontsAndSave()<cr>
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction
" Window movement shortcuts
" move to the window in the direction shown, or create a new window
function! WinMove(key)
    let t:curwin = winnr()
    echo 'windMove'
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

function! ToggleCurrsorLineColumn()
    if(&cursorline)
        set nocursorline nocursorcolumn
        let g:normal_cursor_line_column = 0
        return
    endif
    let g:normal_cursor_line_column = 1
    set cursorline nocursorcolumn
endfunction

function! CursorPing()
    let _cursorline = &cursorline
    let _cursorcolumn = &cursorcolumn
    set cursorline cursorcolumn
    redraw
    sleep 350m
    let &cursorline = _cursorline
    let &cursorcolumn = _cursorcolumn
endfunction

function! InsertBeforeLastCharacterOfLine(count)
    normal $
    let l:_count = a:count
    while l:_count > 0
        normal! h
        let l:_count = l:_count-1
    endwhile
endfunction
nmap ,. <c-^>
"execute current line
"Y:@"<CR>
"<C-U> is needed for properly capturing the count, I don't understand why
nmap ,,a :<C-U>call InsertBeforeLastCharacterOfLine(v:count)<cr>
nmap ,a <Nop>
nmap ,ao <Nop>
nnoremap <silent> ,aa :call FindAssignment(expand("<cword>"))<cr>
nnoremap <silent> ,af :call FindFunction(expand("<cword>"))<cr>
nnoremap <silent> ,at "fyaw:FindText '<C-r>f'<cr>
nnoremap <silent> ,au :call FindUsage(expand("<cword>"))<cr>
nnoremap <silent> ,aw "fyaw:FindText '<C-r>f'<cr>
nnoremap <silent> ,anta :FindNoTestAssignment expand("<cword>")<cr>
nnoremap <silent> ,antf :FindNoTestFunction expand("<cword>")<cr>
nnoremap <silent> ,antt "fyaw:FindNoTestText '<C-r>f'<cr>
nnoremap <silent> ,antw "fyaw:FindNoTestText '<C-r>f'<cr>
nnoremap <silent> ,antu :FindNoTestUsage expand("<cword>")<cr>
nnoremap <silent> ,aota :FindOnlyTestAssignment expand("<cword>")<cr>
nnoremap <silent> ,aotf :FindOnlyTestFunction expand("<cword>")<cr>
nnoremap <silent> ,aott "fyaw:FindOnlyTestText '<C-r>f'<cr>
nnoremap <silent> ,aotw "fyaw:FindOnlyTestText '<C-r>f'<cr>
nnoremap <silent> ,aotu :FindOnlyTestUsage expand("<cword>")<cr>



nnoremap <silent> <space>aa :call FindAssignment(expand("<cword>"))<cr>
nnoremap <silent> <space>af :call FindFunction(expand("<cword>"))<cr>
nnoremap <silent> <space>at "fyaw:FindText '<C-r>f'<cr>
nnoremap <silent> <space>au :call FindUsage(expand("<cword>"))<cr>
nnoremap <silent> <space>aw "fyaw:FindText '<C-r>f'<cr>
nnoremap <silent> <space>anta :FindNoTestAssignment expand("<cword>")<cr>
nnoremap <silent> <space>antf :FindNoTestFunction expand("<cword>")<cr>
nnoremap <silent> <space>antt "fyaw:FindNoTestText '<C-r>f'<cr>
nnoremap <silent> <space>antw "fyaw:FindNoTestText '<C-r>f'<cr>
nnoremap <silent> <space>antu :FindNoTestUsage expand("<cword>")<cr>
nnoremap <silent> <space>aota :FindOnlyTestAssignment expand("<cword>")<cr>
nnoremap <silent> <space>aotf :FindOnlyTestFunction expand("<cword>")<cr>
nnoremap <silent> <space>aott "fyaw:FindOnlyTestText '<C-r>f'<cr>
nnoremap <silent> <space>aotw "fyaw:FindOnlyTestText '<C-r>f'<cr>
nnoremap <silent> <space>aotu :FindOnlyTestUsage expand("<cword>")<cr>
"find variable assignment - `a=b` or `a:b` - fails for es6
nnoremap <silent> <space>fva :call FindAssignment(expand("<cword>"))<cr>
nnoremap <silent> <space>ff :call FindFunction(expand("<cword>"))<cr>
nnoremap <silent> <space>ft "fyaw:FindText '<C-r>f'<cr>
nnoremap <silent> <space>fu :call FindUsage(expand("<cword>"))<cr>
" find word - we spoil the f register which is ... unescessary
nnoremap <silent> <space>fw "fyaw:FindText '<C-r>f'<cr>
" find not test hast fnt prefix
nnoremap <silent> <space>fnta :FindNoTestAssignment expand("<cword>")<cr>
nnoremap <silent> <space>fntf :FindNoTestFunction expand("<cword>")<cr>
nnoremap <silent> <space>fntt "fyaw:FindNoTestText '<C-r>f'<cr>
nnoremap <silent> <space>fntw "fyaw:FindNoTestText '<C-r>f'<cr>
nnoremap <silent> <space>fntu :FindNoTestUsage expand("<cword>")<cr>
"find only test has fot prefix
nnoremap <silent> <space>fota :FindOnlyTestAssignment expand("<cword>")<cr>
nnoremap <silent> <space>fotf :FindOnlyTestFunction expand("<cword>")<cr>
nnoremap <silent> <space>fott "fyaw:FindOnlyTestText '<C-r>f'<cr>
nnoremap <silent> <space>fotw "fyaw:FindOnlyTestText '<C-r>f'<cr>
nnoremap <silent> <space>fotu :FindOnlyTestUsage expand("<cword>")<cr>
nnoremap \c :Commands<cr>
nnoremap 1: :History:<cr>
nnoremap 1/ :History/<cr>
" http://vim.wikia.com/wiki/Replace_a_word_with_yanked_text
nmap ,bl :BLines<cr>
nmap <space>bl :BLines<cr>
"view buffer lines
nmap <space>vb :AgBLines<cr>
nmap <space>agb :AgBLines<cr>
nmap ,bd :call BufDeleteCurrent()<cr>
nmap <space>bd :call BufDeleteCurrent()<cr>
"end diff --- clean close diff window
nmap ,ed <C-w><C-h><C-w><C-c>
map ,ev :source ~/.dotfiles/config/nvim/init.vim<cr> 
nmap <space>ed <C-w><C-h><C-w><C-c>
map <space>ev :source ~/.dotfiles/config/nvim/init.vim<cr> 
" toggle Limelight
nmap ,f :Limelight!!<cr>
" find any file
nmap <silent> ,fa :FZFFiles<cr>
nmap <silent><space>fa :FZFFiles<cr>
"find line in current buffer
nmap <silent> ,fc :BLines<cr>
" find help tag
nmap <silent> ,fh :Helptags<cr>
nmap <silent><space>fh :Helptags<cr>
" find line in open buffers
nnoremap <silent> ,fl :Lines<cr>
nnoremap <silent><space>fl :Lines<cr>
"view loaded(all) buffer lines
nnoremap <silent><space>vl :AgAllBLines<cr>
"fugitive
nmap <silent><space>gb :Gblame<cr>nmap <silent>,gd :Gdiff<cr>
nmap <silent>,gr :Gread<cr>
nmap <silent>,gs :Gstatus<cr>
nmap <silent>gs :Gstatus<cr>
nmap ,gt :Buffers<cr>term://
nmap <silent><space>gb :Gblame<cr>

nmap <silent><space>gd :Gdiff<cr>
nmap <space>ge :Gedit<cr>

"git preview
nmap <space>gp :GitGutterPreviewHunk<cr>
"hunk prev
nmap <space>hp :GitGutterPrevHunk<cr>
"hunk next
nmap <space>hn :GitGutterNextHunk<cr>
"highlight hunks
nmap <space>hh :GitGutterLineHighlightsToggle<cr>
nmap <silent><space>gr :Gread<cr>
nmap <silent><space>gs :Gstatus<cr>
nmap <silent>gs :Gstatus<cr>
nmap <space>gt :Buffers<cr>term://
"map ,fs FoldSearch
" toggle cursor line
nnoremap ,I :call ToggleCurrsorLineColumn()<cr> 
nnoremap  ,i :call CursorPing()<CR>
map <silent> ,h :call WinMove('h')<cr>
map <silent> ,j :call WinMove('j')<cr>
map <silent> ,k :call WinMove('k')<cr>
map <silent> ,l :call WinMove('l')<cr>
map <silent> 1h :call WinMove('h')<cr>
map <silent> 1j :call WinMove('j')<cr>
map <silent> 1k :call WinMove('k')<cr>
map <silent> 1l :call WinMove('l')<cr>
nmap 1w :wincmd q<cr>
nmap \w :wincmd q<cr>
" Toggle NERDTree
nmap <silent> ,n :NERDTreeToggle<cr>
nmap <silent> <C-1> :NERDTreeToggle<cr>
" expand to the path of the file in the current buffer
nmap <silent> ,N :NERDTreeFind<cr>
nmap <silent> 1n :NERDTreeFind<cr>
nmap <silent> 1N :NERDTreeToggle<cr>
nmap <silent> <space>nn :NERDTreeToggle<cr>


let g:EasyMotion_keys='abcdefghijklmnopqrstuvwxyz'
map <space>e <Plug>(easymotion-prefix)
nmap ,s <Plug>(easymotion-s)
nmap \g <Plug>(easymotion-s)
nmap ,ss <Plug>(easymotion-s)
nmap ,/ <Plug>(easymotion-sn)
nmap 1u <Plug>(easymotion-s)
nmap 1y <Plug>(easymotion-sn)
"easy motion word
nmap <space>eW <Plug>(easymotion-w)
nmap <space>ew <Plug>(easymotion-w)
" 'quick git status' give status with fzf
map ,qgs :GFiles?<cr>
map ,qa :qa<cr>
map <silent> ,sl <Nop>
map ,tc :tabclose<cr>
map ,te :tabedit %<cr>
map <space>tc :tabclose<cr>
map <space>te :tabedit %<cr>
map ]t :tabnext<cr>
map [t :tabprev<cr>
"same as :quit
nmap ,w :wincmd q<cr>
nmap <space>w :wincmd q<cr>
nmap \w :wincmd q<cr>
" map ,, :w<cr>
nnoremap <silent> ,zj :call NextClosedFold('j')<cr>
nnoremap <silent> ,zk :call NextClosedFold('k')<cr>
imap <C-s>  <Esc>:w<cr>
map <C-s>  <Esc>:w<cr>

nmap <silent> ,m :GFiles<cr>
nmap <silent> \f :GFiles<cr>
nmap <silent> ,M :Buffers<cr>
nmap <silent> 1b :Buffers<cr>
nmap <silent> \b :Buffers<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
nmap 1p :YRShow<cr>
nmap ,lc :LetterCommands<cr>
nmap <space>lc :LetterCommands<cr>
" i don't like the unimpaired ]l, [l commands, it's too much little finger
nmap <space>lj :lnext<cr>
nmap <space>lk :lprev<cr>
