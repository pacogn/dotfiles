" vim: foldmethod=marker
autocmd!
" Load startup files{{{1--------------------------------------------------------------------------------------------------
"-------------------------------------------------------------------------------------------------------------------------
source $DOTFILES/config/nvim/startup/plugins.vim
source $DOTFILES/config/nvim/startup/tmp_stuff.vim
source $DOTFILES/config/nvim/startup/gitstatus.vim
source $DOTFILES/config/nvim/startup/custom_fold.vim
source $DOTFILES/config/nvim/startup/NERDTree.vim
source $DOTFILES/config/nvim/startup/airline.vim
source $DOTFILES/config/nvim/startup/syntastic_config.vim
source $DOTFILES/config/nvim/startup/tab_titles.vim
source $DOTFILES/config/nvim/startup/leader_mappings.vim
source $DOTFILES/config/nvim/startup/terminal_settings.vim
source $DOTFILES/config/nvim/startup/abbrev.vim
source $DOTFILES/config/nvim/startup/limelight.vim
source $DOTFILES/config/nvim/startup/options.vim
source $DOTFILES/config/nvim/startup/ag-helpers.vim
"}}}----------------------------------------------------------------------------------------------------------------------

"Disk File Sync {{{1------------------------------------------------------------------------------------------------------
"-------------------------------------------------------------------------------------------------------------------------
" Save whenever switching windows or leaving vim.
au FocusLost,WinLeave * :silent! wa

" Trigger autoread when changing buffers or coming back to vim.
au FocusGained,BufEnter * :silent! !
"}}}----------------------------------------------------------------------------------------------------------------------

if has('nvim')
    au TextYankPost * let @*=@"
    if (has("termguicolors"))
        set termguicolors
    endif
else
    au VimEnter * call SyncClipboard() 
    function! SyncClipboard()
      if @% =~ 'private\/tmp\/zsh'
        return
      endif
      au CursorHold,CursorMoved,FocusLost * let @*=@0 
      " map <buffer>quit :qa<cr>
    endfunction
    " set clipboard=unnamed
endif
function! OnInsertLeave()
    if(g:normal_cursor_line_column)
        set cursorline nocursorcolumn
    else
        set nocursorline nocursorcolumn
    endif
endfunction
let g:normal_cursor_line_column = &cursorcolumn
let g:gitgutter_map_keys = 0
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
elseif exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.js"


" let g:ack_autofold_results = 1
" make backspace behave in a sane manner

" set a map leader for more key combos
let mapleader = ','
let g:mapleader = ','


" Tab control

if has('mouse')
    set mouse=a
    " set ttymouse=xterm2
endif

" set clipboard=unnamed

" faster redrawing


" highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'


" }}}

" Section AutoGroups {{{
" file type specific settings
augroup configgroup
    autocmd!
    autocmd FileType javascript silent! call LimeLightExtremeties()
    autocmd InsertEnter * set cursorline nocursorcolumn
    autocmd InsertLeave * call OnInsertLeave()
    autocmd FileType html setlocal ts=4 sts=4 sw=4 noexpandtab indentkeys-=*<return>
    autocmd FileType markdown,textile setlocal textwidth=0 wrapmargin=0 wrap spell
    autocmd FileType .xml exe ":silent %!xmllint --format --recover - 2>/dev/null"
    autocmd FileType crontab setlocal nobackup nowritebackup

    " automatically resize panes on resize
    autocmd VimResized * exe 'normal! \<c-w>='
    autocmd BufWritePost .vimrc,.vimrc.local,init.vim silent! source %
    autocmd BufWritePost .vimrc.local silent! source %

    autocmd BufNewFile,BufRead *.svg set filetype=xml
    autocmd BufNewFile,BufRead .babelrc set filetype=json
    autocmd BufNewFile,BufRead .eslintrc set filetype=json
    autocmd BufNewFile,BufRead *.es6 set filetype=javascript
    autocmd BufNewFile,BufRead *.rt set filetype=html
    " close help files on 'q'
        
    autocmd FileType help nnoremap <buffer>q :bd<cr>
    autocmd BufEnter * call SetQuit() 

    " make quickfix windows take all the lower section of the screen
    " when there are multiple windows open
    autocmd FileType qf wincmd J

    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'json=javascript', 'stylus', 'html']

    " autocmd! BufEnter * call ApplyLocalSettings(expand('<afile>:p:h'))

    autocmd BufNewFile,BufRead,BufWrite *.md syntax match Comment /\%^---\_.\{-}---$/

    autocmd! BufWritePost * if &ft =~ 'javascript' | Neomake | endif
augroup END

" find next/prev function by }/{
autocmd FileType javascript nnoremap <buffer>{ :set nohlsearch<cr>0?function\s*\w*(.*{?e<cr>zt
autocmd FileType javascript nnoremap <buffer>} :set nohlsearch<cr>/function\s*\w*(.*{/e<cr>zt
" find next/prev end of function by ,}/,{
autocmd FileType javascript nnoremap <buffer>,} :set nohlsearch<cr>/function\s*\w*(.*{/e<cr>zt%
autocmd FileType javascript nnoremap <buffer>,{ :set nohlsearch<cr>j?function\s*\w*(.*{?e<cr>k?function\s*\w*(.*{?e<cr>zt%
function! SetQuit()
  if &ft =~ '\vhelp|text|qf'
    return
  endif
  map <buffer>quit :qa<cr>
endfunction

" code folding settings
" set foldmethod=manual " fold based on indent




" Searching


"set showmatch " show matching braces
"set mat=2 " how many tenths of a second to blink

" error bells
"????david

" switch syntax highlighting on
syntax on

let base16colorspace=256  " Access colors present in 256 colorspace"
if ( $THEME =~ 'base16' )
    execute "colorscheme ".$THEME
else
    colorscheme base16-chalk
endif
highlight Comment cterm=italic
highlight htmlArg cterm=italic

"set relativenumber " show relative line numbers



function! HorizontalResize(key)
    let l:winheight = winheight(0)
    if(a:key == '+')
        exec '5wincmd +'
    else
        exec '5wincmd -'
    endif
    if(l:winheight == winheight(0))
        let g:forcehorizontalresize = 0
    endif
endfunction
function! WinSize(key)
    if(g:forcehorizontalresize)
        call HorizontalResize(a:key)
        return
    endif
    let t:curwin = winnr()
    exec "wincmd l"
    if (t:curwin == winnr())
        exec "wincmd h"
        if (t:curwin == winnr())
            call HorizontalResize(a:key)
            return
        endif
        exec "wincmd l"
    else
        exec "wincmd h"
    endif
    if(a:key == '+')
        exec '5wincmd >'
    else
        exec '5wincmd <'
    endif
endfunction

function! ToggleForceVerticalResize()
    if(g:forcehorizontalresize)
        let g:forcehorizontalresize = 0
    else
        let g:forcehorizontalresize = 1
    endif
    " sleep 800m
    " let g:forcehorizontalresize = 0
endfunction
" increase decrease vertica split by +,_
nnoremap + :call WinSize('+')<cr>
nnoremap _ :call WinSize('-')<cr>
let g:forcehorizontalresize = 0
nnoremap ,v :call ToggleForceVerticalResize()<cr>
let g:ack_use_dispatch = 1
" remap esc
inoremap jk <esc>
inoremap jj <esc>
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
cnoremap jk <C-c>
cnoremap ,, <C-c>
" Make Y behave like other capitals
nnoremap Y y$
" markdown to html
" nmap <leader>md :%!markdown --html4tags <cr>

" qq to record, Q to replay (recursive map due to peekaboo)
nmap Q @q

nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>
nnoremap <silent> <C-h> :call WinMove('h')<cr>

" set paste toggle
"???david

" toggle paste mode
"map <leader>v :set paste!<cr>

" clear highlighted search
noremap <silent><space> :silent! set hlsearch! hlsearch?<cr>

" toggle invisible characters
highlight SpecialKey ctermbg=none ctermfg=8 " make the highlighting of tabs less annoying
highlight NonText ctermbg=none ctermfg=8
" highlight Folded ctermbg=234 ctermfg=20

" enable . command in visual mode
vnoremap . :normal .<cr>


" scroll the viewport faster
nnoremap <C-d> :call smooth_scroll#down(9, 0, 6)<CR>
nnoremap <C-u>  :call smooth_scroll#up(9, 0, 6)<CR>
nnoremap <c-e>  3<c-e>
nnoremap <c-y>  3<c-y>
" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" recursively search up from dirname, sourcing all .vimrc.local files along the way
function! ApplyLocalSettings(dirname)
    " convert windows paths to unix style
    let l:curDir = substitute(a:dirname, '\\', '/', 'g')

    " walk to the top of the dir tree
    let l:parentDir = strpart(l:curDir, 0, strridx(l:curDir, '/'))
    if isdirectory(l:parentDir)
        call ApplyLocalSettings(l:parentDir)
    endif

    " now walk back down the path and source .vimsettings as you find them.
    " child directories can inherit from their parents
    let l:settingsFile = a:dirname . '/.vimrc.local'
    if filereadable(l:settingsFile)
        exec ':source' . l:settingsFile
    endif
endfunction

function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

function! HiInterestingWord(n)
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
endfunction

function! HiDiffDark()
    highlight DiffAdd ctermfg=NONE ctermbg=22
    highlight DiffChange ctermfg=NONE ctermbg=237
    highlight DiffText ctermfg=NONE ctermbg=25
    highlight DiffDelete ctermfg=NONE ctermbg=52
endfunction
call HiDiffDark()

highlight CursorLine ctermfg=NONE ctermbg=24
highlight CursorColumn ctermfg=NONE ctermbg=24
hi MatchParen cterm=bold ctermbg=197 ctermfg=232
highlight Visual ctermfg=NONE ctermbg=24

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>
hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

function! HtmlUnEscape()
  silent s/&lt;/</eg
  silent s/&gt;/>/eg
  silent s/&amp;/\&/eg
endfunction

nnoremap <silent> <leader>u :call HtmlUnEscape()<cr>

" }}}

" Section Plugins {{{


" Fugitive Shortcuts

" don't hide quotes in json files
let g:vim_json_syntax_conceal = 0

if (has("gui_running"))
    set guioptions=egmrt
    set background=light
    colorscheme solarized
    let g:airline_left_sep=''
    let g:airline_right_sep=''
    let g:airline_powerline_fonts=0
    let g:airline_theme='solarized'
endif

function! CursorPing()
    set cursorline cursorcolumn
    redraw
    sleep 350m
    set nocursorline nocursorcolumn
endfunction

function! BufOnly()
  let curr = bufnr("%")
  let last = bufnr("$")

  if curr > 1    | silent! execute "1,".(curr-1)."bd"     | endif
  if curr < last | silent! execute (curr+1).",".last."bd" | endif
endfunction
command! BufOnly call BufOnly()

" FZF
"""""""""""""""""""""""""""""""""""""
autocmd VimEnter * command! -nargs=* -bang Agraw call fzf#vim#ag_raw(<args>)

let g:fzf_layout = { 'down': '~40%' }

" Mapping selecting mappings
nmap <silent> <leader>t :GFiles<cr>
nmap <silent> <leader>r :Buffers<cr>
nmap <silent> <leader>e :GFiles?<cr>
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
if has('nvim')
    let g:fzf_layout = { 'window': 'enew' }
endif

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <silent> ,C :call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':    'colo',
\   'options': '+m',
\   'left':    30
\ })<CR>

command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})
" command! FF call FindFunction

command! FZFFiles call fzf#run({
\  'source': 'find . | egrep -v \.git',
\  'sink':    'e',
\  'options': '--reverse -m -x +s'})

call ApplyLocalSettings(expand('.'))
