" Search and replace word under cursor
nnoremap <F4> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

nmap <space><space> :call FixPowerlineFontsAndSave()<cr>
vmap <space><space> :call FixPowerlineFontsAndSave()<cr>
function! FixPowerlineFontsAndSave()
    " can't load powerline fonts on startup, it looks terrible.
    " This is a hacky workaround.
    execute('source '.expand('$DOTFILES/config/nvim/startup/airline.vim'))
    execute('source '.expand('$DOTFILES/config/nvim/startup/options.vim'))
    vunmap <space><space>
    nunmap <space><space>
    silent! update

    " there is an issue with airline not updating when
    " `:update` writes, running twice `:update` solves it
    nmap <space><space> :update<cr>:update<cr>
    vmap <space><space> :update<cr>:update<cr>
endfunction

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

noremap ' `

nmap ,. :call utils#restoreAlternateFile()<cr><c-^>
nmap sa :call utils#restoreAlternateFile()<cr><c-^>

nmap <space>gx m`0y$:@"<cr><c-o>  |" execute current line
nmap <space>qq :helpclose<cr>:pclose<cr>:cclose<cr>:lclose<cr>
nmap <space>ql :lclose<cr>
nmap <space>qc :cclose<cr>
nmap <space>qp :pclose<cr>
nmap <space>qh :helpclose<cr>
noremap <space>oc :copen<cr>
noremap <space>ol :lopen<cr>

" nnoremap - :silent call utils#toggle_window_to_nerd_tree()<cr>
nnoremap - :let currfile = expand('%:p:t')<cr>:edit %:p:h<cr>:call search(currfile)<cr>
nnoremap \\ "_
vnoremap \\ "_

noremap <space>fd :filetype detect<cr>
"find variable assignment - `a=b` or `a:b` - fails for es6
nnoremap <silent> <space>fva :call FindAssignment(expand("<cword>"))<cr>
nnoremap <silent> <space>ff :call FindFunction(expand("<cword>"))<cr>
nnoremap <silent> <space>ft "fyaw:FindText '<C-r>f'<cr>
nnoremap <silent> <space>fu :call FindUsage(expand("<cword>"))<cr>
" find word - we spoil the f register which is ... unescessary
" nnoremap <silent> <space>fw "fyaw:FindText '<C-r>f'<cr>
nnoremap <silent> <space>fw :execute "Ag ".expand("<cword>")<cr>
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
vmap / /\v
vmap ? ?\v

nnoremap <space>at :AirlineToggleShowingAllSections<cr>
nnoremap \c :Commands<cr>
nnoremap 1: :History:<cr>
nnoremap 1; :History:<cr>
nnoremap 1/ :History/<cr>
" http://vim.wikia.com/wiki/Replace_a_word_with_yanked_text
nmap <space>be :BufExplorer<cr>
function! BufferHistory()
    set eventignore=BufWinEnter,WinEnter,DirChanged
    GV!
    set eventignore&
endfunction
nmap <space>bh :call BufferHistory()<cr>

nmap <space>bl :BLines!<cr> |"view buffer lines

nnoremap <silent><space>vl :AgAllBLines<cr> |"view loaded(all) buffer lines
nmap <space>bd :call utils#buf_delete_current()<cr>
"end diff --- clean close diff window
nmap <space>ed <C-w><C-j><C-w><C-l><C-w><C-o>
map <space>ev :source ~/.dotfiles/config/nvim/init.vim<cr> 
"add explanation inside code
nnoremap <space>ex O<esc>80i-<esc>o-<cr><esc>80i-<esc>V2k:Commentary<cr>j$xA
" nnoremap <space>ex O120i-o

" find any file
nmap <silent><space>fa :FZFFiles<cr>
nmap <silent><space>fh :Helptags<cr>

" find line in open buffers
nnoremap <silent><space>fl :Lines<cr>

"fugitive
nmap <silent><space>wd :call DiffInWebstorm()<cr>
nmap <silent><space>ws :OpenInWebstorm()<cr>
nmap <silent><space>ow :OpenInWebstorm<cr>
nmap <silent><space>oa :call utils#open_in_atom()<cr>
nmap <silent><space>ov :call utils#open_in_visual_studio_code()<cr>
nmap <silent><space>gr :Gread<cr>
nmap <silent><space>gc :Gcommit -v<cr>
nmap <silent><space>gl :call hzf#git_log()<cr>
"gf cuz the git command is 'git log --follow $FileName' 
nmap <silent><space>gf :call hzf#git_log_follow()<cr>
nmap <silent><space>bc :call hzf#git_log_follow()<cr>

nmap <silent><space>gs :Gstatus<cr><C-n>
nmap <silent><space>gb :Gblame<cr>
nmap <silent><space>gd :Gdiff<cr>
nmap <space>ge :Gedit<cr>

nmap <silent>gs :Gstatus<cr><C-n>
nmap <silent>gb :Gblame<cr>

"hunk stage
nmap <space>hs :GitGutterStageHunk<cr>
nmap <space>hu :GitGutterUndoHunk<cr>
"hunk before = hunk prev
nmap <space>hb :GitGutterPrevHunk<cr>
nmap <space>hN :GitGutterPrevHunk<cr>
nmap [c <Plug>(GitGutterPrevHunk)
nmap ]c <Plug>(GitGutterNextHunk)
nmap <space>hv :call gitgutter#hunk#text_object(1)<cr>
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
" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
map <silent> gh :call utils#win_move('h')<cr>
map <silent> gj :call utils#win_move('j')<cr>
map <silent> gk :call utils#win_move('k')<cr>
map <silent> gl :call utils#win_move('l')<cr>
nmap \w :wincmd q<cr>
nmap \s :%s/\v
vmap \s :s/\v
nmap \d :GitGutterToggle<cr>:redraw!<cr>
" Toggle NERDTree
nmap <silent> 1t :execute '25Lexplore '.expand('%:p:h')<cr>
" expand to the path of the file in the current buffer
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
nmap <silent> 1n :call NERDTreeFindOrClose()<cr>
nmap <silent> 1N :NERDTreeFind<cr>
nmap <silent> \t :NERDTreeToggle<cr>
nmap <silent> <space>nn :NERDTreeToggle<cr>
nmap <silent> <space>nf :NERDTreeFind<cr>
nmap 1o :only<cr>

"VIM-MARK: <space>hi for highlight interesting word
nmap <silent><space>hi <Plug>MarkSet
vmap <silent><space>hi <Plug>MarkSet
" <space>hc for "highlight clear" clear all "interesting words" highlighting
nmap <space>hc :silent MarkClear<cr>
nmap ,n ,*
nmap ,N ,#
nmap <N ,#
nmap 1zDisableVimMarkStarMap <Plug>MarkSearchNext
nmap 1zDisableVimMarkHashMap <Plug>MarkSearchPrev
nmap 1zDisableVimMarkMarkClear  <Plug>MarkClear

" add date
" nmap <F3> i<C-R>=strftime("%Y-%m-%d")<CR><Esc>
" imap <F3> <C-R>=strftime("%Y-%m-%d")<CR>
" nmap <F4> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
" imap <F4> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

vmap <space>cp :call utils#cursor_ping()<cr>

" Surround {{{
    " disable automatic mappings for surround.vim and write the here cuz I want `ds{motion}` and `cs{motion}` to use easymotion instead
    let g:surround_no_mappings = 1

    nmap <space>ds  <Plug>Dsurround
    nmap ds  <Plug>Dsurround         |"delete surrounding
    "
    nmap <space>cs  <Plug>Csurround  |" change surrounding 
    nmap <space>cS  <Plug>CSurround  |" change surrounding
    nmap cs         <Plug>Csurround  |" change surrounding
    nmap ys         <Plug>Ysurround  |" change surrounding
    nmap <space>ys  <Plug>Ysurround  |" motion + surrounding
    nmap <space>yS  <Plug>YSurround  |" put created surrounding in its own line
    nmap <space>yss <Plug>Yssurround |" surround entire line
    nmap <space>ySs <Plug>YSsurround |" surrond {start}\n{currentline}\n{end}
    nmap <space>ySS <Plug>YSsurround |" same as ySs
    xmap S          <Plug>VSurround  |" surround visual selection
    xmap gS         <Plug>VgSurround |" surround visual into its own line
    xmap <space>s   <Plug>VSurround  |" surround visual selection
" }}}

"using map from <Plug>(easymotion...) is cool, the plugin worries to do the right thing with my mappings
" let g:EasyMotion_keys='abcdefghijklmnopqrstuvwxyz'
" map ss <Plug>(easymotion-s)
" map sn <Plug>(easymotion-sn)
" map s; <Plug>(easymotion-next)
" map s, <Plug>(easymotion-prev)
" map s. <Plug>(easymotion-repeat)
" map sd <Plug>(easymotion-s2)

map <space>tc :tabclose<cr>
map <space>te :call utils#toTerminal()<cr>
map <space>sn :UltiSnipsEdit<cr>
map <space>st :Scripts<cr>

"visual mode on pasted text
nnoremap <space>vp `[v`]

"same as :quit
nmap \w :wincmd q<cr>
nmap \q :wincmd q<cr>

" Expand selected region
nmap <S-Up> v<Plug>(expand_region_expand)
vmap <S-UP> <Plug>(expand_region_expand)
vmap <S-DOWN> <Plug>(expand_region_shrink)
let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'a"'  :0,
      \ 'i''' :0,
      \ 'a''' :0,
      \ 'i]'  :1, 
      \ 'a]'  :1, 
      \ 'ib'  :1, 
      \ 'ab'  :1, 
      \ 'iB'  :1, 
      \ 'aB'  :1, 
      \ 'il'  :0, 
      \ 'ip'  :0,
      \ 'ie'  :0, 
      \ }
" map <UP> <Plug>(wildfire-fuel)
" vmap <DOWN> <Plug>(wildfire-water)
nnoremap <silent> <space>zj :call NextClosedFold('j')<cr>
nnoremap <silent> <space>zk :call NextClosedFold('k')<cr>

function! GFilesIfNotHelp()
    if &ft == 'help'
        execute "normal! \<C-p>"
    else
        call hzf#g_files()
    endif
endfunction
nnoremap <C-t> :call GFilesIfNotHelp()<cr>

imap <C-s>  <Esc>:w<cr>
map <C-s>  <Esc>:w<cr>
nnoremap <C-s> :Snippets<cr>

nmap <silent> \b :Buffers<cr>
nmap <silent> 1b :Buffers<cr>
nmap <silent> \f :call hzf#g_files()<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
nmap <space>lc :LetterCommands<cr>
nmap <space>lm :LeaderMappingsDeclaration<cr>
nmap <space>cl :LetterCommands<cr>
nmap <space>cc :CommandLineCommands<cr>
nmap <space>cd :CDC<cr>
nmap ]i :execute "BLines '".expand('<cword>')<cr>
nmap [i :execute "BLines '".expand('<cword>')<cr>
nmap ]I :execute 'AgAllBLines \b'.expand('<cword>').'\b'<cr>
nmap [I :execute 'AgAllBLines \b'.expand('<cword>').'\b'<cr>
" i don't like the unimpaired ]l, [l commands, it's too much little finger
nmap <space>lj :lnext<cr>
nmap <space>lk :lprev<cr>

" run test (well, if available)
nmap <space>rt :Shell! export MOCHA_OPTIONS='--colors'; npm run test<cr>
" nmap <space>rb :Shell! [[ -f .nvmrc ]] && nvm use $(cat .nvmrc); export MOCHA_OPTIONS='--colors'; npm run test:debug<cr>
nmap <space>rb :Shell! [[ -f .nvmrc ]] && nvm use $(cat .nvmrc); export MOCHA_OPTIONS='--colors'; npm run build<cr>
"<c-l> complete to longest possible
"<c-d> list all possibilities
cnoremap <c-space> <C-l><C-d>
cnoremap <c-p> <up>
cnoremap <c-n> <down>

function! PecoOpen()
  for filename in split(system("find . -type f | peco"), "\n")
    execute "e" filename
  endfor
endfunction
nnoremap <space>op :call PecoOpen()<CR>

let t:is_transparent = 0
function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
        set background=dark
        let t:is_tranparent = 0
    endif
endfunction
" Toggle_transparent()

nnoremap <space>t :call Toggle_transparent()<CR>

" zoom pane
noremap <space>z <c-w>_ \| <c-w>\|
noremap <space>o <c-w>=

" Convert slashes to backslashes for Windows.
if has('win32')
  nmap ,cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
  nmap ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

  " This will copy the path in 8.3 short format, for DOS and Windows 9x
  nmap ,c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
  nmap ,cs :let @*=expand("%")<CR>
  nmap ,cl :let @*=expand("%:p")<CR>
endif

" paste from register
vmap  "_dP

imap <F2> <Esc>v`^me<Esc>gi<C-o>:call Ender()<CR>
function Ender()
  let endchar = nr2char(getchar())
  execute "normal \<End>a".endchar
  normal `e
endfunction
