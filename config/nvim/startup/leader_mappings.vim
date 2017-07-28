function! Buflisted()
    return filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&filetype") != "qf"')
endfunction
function! Sort_buffers(...)
    let [b1, b2] = map(copy(a:000), 'get(g:fzf#vim#buffers, v:val, v:val)')
    " Using minus between a float and a number in a sort function causes an error
    return b1 < b2 ? 1 : -1
endfunction
function! ListBuffers(...)
    let bufs = sort(Buflisted(), 'Sort_buffers')
    return bufs
endfunction

function! BufDeleteCurrent()
    let listedbuffers=ListBuffers()
    let bufnextnr = 1
    let currbuffname = expand('%')
    if(bufname('%') =~? 'NERD_tree')
        let bufnextnr = 0
        " buffer! #
    endif
    if(len(listedbuffers) > bufnextnr)
        let l:bufnext = listedbuffers[bufnextnr]
        let alternate = listedbuffers[bufnextnr]
    endif
    if(len(listedbuffers) > bufnextnr + 1)
        let alternate = listedbuffers[bufnextnr + 1]
    endif
    if exists('l:bufnext')
        if bufnextnr
            :BD
        endif
        execute 'buffer '.l:bufnext
        let @#=bufname(alternate)
    else
        echom 'last buffer'
    endif
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
    silent! update
    "there is an issue with airline not updating when `:update` writes, running twice `:update` solves it
    "nnn
    inoremap ,, <esc>:update<cr>:update<cr>
    nmap ,, :update<cr>:update<cr>
    vmap ,, :update<cr>:update<cr>
    nmap <space><space> :update<cr>:update<cr>
    vmap <space><space> :update<cr>:update<cr>
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

function! CursorPing(...)
    let _cursorline = &cursorline
    let _cursorcolumn = &cursorcolumn
    set cursorline 
    if !a:0
        set cursorcolumn
    endif
    redraw
    sleep 350m
    let &cursorline = _cursorline
    let &cursorcolumn = _cursorcolumn
endfunction

function! ToggleWindowToNerdTree()
    "need to commit change in nerdtree and relate to it for this commit
    " see sudavid4/nerdtree commit 909cf25722f206f82128554c7c6dd1ed34a95949 is needed for this to work properly
    if ! exists('t:NERDTreeBuffName')
        NERDTreeToggle
        sleep 100m
    endif
    if g:NERDTree.IsOpen()
        NERDTreeClose
        sleep 100m
    endif
    "this is likely useless since sudavid4/nerdtree commit 909cf25722f206f82128554c7c6dd1ed34a95949 
    let w:dontsavescreenstate = 1
    let currfile = expand('%:p:t')
    edit %:p:h
    call search(currfile)
endfunction
nmap ,. <c-^>
"execute current line
"Y:@"<CR>
"<C-U> is needed for properly capturing the count, I don't understand why

nnoremap - :silent call ToggleWindowToNerdTree()<cr>
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
"real incsearch with plugin
nmap /  <Plug>(incsearch-forward)\v
nmap ?  <Plug>(incsearch-backward)\v
nmap g/ <Plug>(incsearch-stay)
vmap / /\v
vmap ? ?\v

" integration of incsearch with indexed_search -- https://github.com/haya14busa/incsearch.vim/issues/21
let g:indexed_search_mappings = 0
augroup incsearch-indexed
    autocmd!
    autocmd User IncSearchLeave ShowSearchIndex
augroup END

let g:incsearch#auto_nohlsearch = 1
map <silent>n  <Plug>(incsearch-nohl-n)zv:ShowSearchIndex<CR>
map <silent>N  <Plug>(incsearch-nohl-N)zv:ShowSearchIndex<CR>
nmap *  <Plug>(incsearch-nohl-*)
nmap #  <Plug>(incsearch-nohl-#)
nmap g* <Plug>(incsearch-nohl-g*)
nmap g# <Plug>(incsearch-nohl-g#)


nnoremap \c :Commands<cr>
nnoremap 1: :History:<cr>
nnoremap 1; :History:<cr>
nnoremap 1/ :History/<cr>
" http://vim.wikia.com/wiki/Replace_a_word_with_yanked_text
nmap <space>be :BufExplorer<cr>
"view buffer lines
nmap <space>bl :BLines!<cr>
nmap <space>vb :AgBLines<cr>
nmap <space>agb :AgBLines<cr>
"view loaded(all) buffer lines
nnoremap <silent><space>vl :AgAllBLines<cr>
nmap <space>bd :call BufDeleteCurrent()<cr>
"end diff --- clean close diff window
nmap <space>ed <C-w><C-j><C-w><C-l><C-w><C-o>
map <space>ev :source ~/.dotfiles/config/nvim/init.vim<cr> 
"add explanation inside code
nnoremap <space>ex O<esc>120i-<esc>o-<cr><esc>120i-<esc>V2k:Commentary<cr>j$xA
" nnoremap <space>ex O120i-o120i-VkkgcjgccA
" find any file
nmap <silent><space>fa :FZFFiles<cr>
nmap <silent><space>fh :Helptags<cr>
" find line in open buffers
nnoremap <silent><space>fl :Lines<cr>
"fugitive
nmap <silent><space>wd :call DiffInWebstorm()<cr>
nmap <silent><space>ws :call OpenInWebstorm()<cr>
nmap <silent><space>gb :Gblame<cr>nmap <silent>,gd :Gdiff<cr>
nmap <silent><space>gb :Gblame<cr>
nmap <silent><space>gr :Gread<cr>
nmap <silent><space>gs :Gstatus<cr><C-n>
nmap <silent><space>gc :Gcommit -v<cr>
nmap <silent><space>gl :call FzfGitCommits()<cr>
"gf cuz the git command is 'git log --follow $FileName' 
nmap <silent><space>gf :call FzfBufferCommits()<cr>
nmap <silent><space>bc :call FzfBufferCommits()<cr>
nmap <silent>gs :Gstatus<cr><C-n>

nmap <silent><space>gd :Gdiff<cr>
nmap <space>ge :Gedit<cr>

"hunk stage
nmap <space>hs :GitGutterStageHunk<cr>
nmap <space>hu :GitGutterUndoHunk<cr>
"hunk before = hunk prev
nmap <space>hb :GitGutterPrevHunk<cr>
nmap <space>hN :GitGutterPrevHunk<cr>
nmap 1H :GitGutterPrevHunk<cr>
"highlight hunks
nmap <space>hh :GitGutterLineHighlightsToggle<cr>
nmap <space>ht :GitGutterLineHighlightsToggle<cr>
"hunk next
nmap <space>hn :GitGutterNextHunk<cr>
nmap 1h :GitGutterNextHunk<cr>
"hunk preview
nmap <space>hp :GitGutterPreviewHunk<cr>
nmap <space>gt :Buffers<cr>term://
"map ,fs FoldSearch
" toggle cursor line
nnoremap ,I :call ToggleCurrsorLineColumn()<cr> 
nnoremap  ,i :call CursorPing()<CR>
" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
map <silent> gh :call WinMove('h')<cr>
map <silent> gj :call WinMove('j')<cr>
map <silent> gk :call WinMove('k')<cr>
map <silent> gl :call WinMove('l')<cr>
nmap \w :wincmd q<cr>
nmap \s :%s/\v
vmap \s :s/\v
nmap \d :redraw!<cr>
" Toggle NERDTree
nmap <silent> <C-1> :NERDTreeToggle<cr>
" expand to the path of the file in the current buffer
nmap <silent> 1n :call NERDTreeFindOrClose()<cr>
function! FixNerdSize()
    if &ft == 'nerdtree' 
        vertical resize 30
    else
        let width=&columns - 30
        execute 'vertical resize '.width
        execute "normal! \<c-w>="
    endif
endfunction
nmap 1f :call FixNerdSize()<cr>
nmap <silent> 1N :NERDTreeToggle<cr>
nmap <silent> \t :NERDTreeToggle<cr>
nmap <silent> <space>nn :NERDTreeToggle<cr>
nmap 1o :only<cr>

"VIM-MARK: <space>hi for highlight interesting word
nmap <space>hi ,m
" <space>hc for "highlight clear" clear all "interesting words" highlighting
nmap <space>hc <Plug>MarkClear
nmap ,n ,*
nmap ,N ,#
nmap <N ,#
nmap 1zDisableVimMarkStarMap <Plug>MarkSearchNext
nmap 1zDisableVimMarkHashMap <Plug>MarkSearchPrev

nmap <space>cp :call CursorPing()<cr>
"disable automatic mappings for surround.vim and write the here cuz I want `ds{motion}` and `cs{motion}` to use easymotion instead
let g:surround_no_mappings = 1
"delete surrounding
nmap <space>ds  <Plug>Dsurround
"change surrounding
nmap <space>cs  <Plug>Csurround
"??
nmap <space>cS  <Plug>CSurround
"motion + surrounding
nmap <space>ys  <Plug>Ysurround
"put created surrounding in its own line
nmap <space>yS  <Plug>YSurround
"surround entire line
nmap <space>yss <Plug>Yssurround
"surrond {start}\n{currentline}\n{end}
nmap <space>ySs <Plug>YSsurround
"same as ySs
nmap <space>ySS <Plug>YSsurround
"surround visual selection
xmap S <Plug>VSurround
"surround visual selection
xmap <space>s <Plug>VSurround
"surroung visual into it's own line
xmap gS  <Plug>VgSurround

"using map from <Plug>(easymotion...) is cool, the plugin worries to do the right thing with my mappings
let g:EasyMotion_keys='abcdefghijklmnopqrstuvwxyz'
map s <Plug>(easymotion-prefix)
map ss <Plug>(easymotion-s)
map sn <Plug>(easymotion-sn)
map sa <Plug>(easymotion-jumptoanywhere)
map s; <Plug>(easymotion-next)
map s, <Plug>(easymotion-prev)
map s. <Plug>(easymotion-repeat)
map sd <Plug>(easymotion-s2)

map <space>tc :tabclose<cr>
map <space>te :call ToTerminal()<cr>

"visual mode on pasted text
nnoremap <space>vp `[v`]
"same as :quit
nmap \w :wincmd q<cr>
nmap \q :wincmd q<cr>
nnoremap <silent> <space>zj :call NextClosedFold('j')<cr>
nnoremap <silent> <space>zk :call NextClosedFold('k')<cr>
imap <C-s>  <Esc>:w<cr>
map <C-s>  <Esc>:w<cr>

nmap <silent> \f :GFiles<cr>
nmap <silent> \b :Buffers<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
nmap \p :YRShow<cr>
nmap 1p :call FZFYankRing()<cr>
vmap 1p :<C-u>YRShow<cr>
nmap <space>lc :LetterCommands<cr>
nmap <space>cl :LetterCommands<cr>
nmap <space>cc :CommandLineCommands<cr>
" i don't like the unimpaired ]l, [l commands, it's too much little finger
nmap <space>lj :lnext<cr>
nmap <space>lk :lprev<cr>

"<c-l> complete to longest possible
"<c-d> list all possibilities
cnoremap <c-space> <C-l><C-d>
cnoremap <c-p> <up>
cnoremap <c-n> <down>
