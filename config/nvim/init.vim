source $DOTFILES/config/nvim/startup/plugins.vim
source $DOTFILES/config/nvim/startup/tmp_stuff.vim
source $DOTFILES/config/nvim/startup/gitstatus.vim
source $DOTFILES/config/nvim/startup/custom_fold.vim
source $DOTFILES/config/nvim/startup/NERDTree.vim
source $DOTFILES/config/nvim/startup/airline.vim
source $DOTFILES/config/nvim/startup/syntastic_config.vim
source $DOTFILES/config/nvim/startup/tab_titles.vim
source $DOTFILES/config/nvim/startup/leader_mappings.vim
" autocmd BufNewFile,BufRead .git/index execute 'source $DOTFILES/vim/startup/gitstatus'."\r" 
" save all files on focus lost, ignoring warnings about untitled buffers
" autocmd FocusLost,WinLeave * silent! wa
" au FocusGained,BufEnter,CursorHold * :silent! !
if has('nvim')
    au TextYankPost * let @*=@"
    tnoremap jk <C-\><C-n>
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

if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
elseif exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" :autocmd InsertEnter * set cul
" :autocmd InsertLeave * set nocul"
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.js"
" Abbreviations
abbr funciton function
abbr teh the
abbr tempalte template
abbr fitler filter
if has('nvim')
    " tnoremap <Esc> <C-\><C-n>
    tnoremap jk <C-\><C-n>
endif
set nocompatible " not compatible with vi
set autoread " detect when a file is changed
set autowriteall " just :w implicitly, allways
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
let g:ack_default_options = " --group "

" let g:ack_autofold_results = 1
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m
" make backspace behave in a sane manner
set backspace=indent,eol,start

" set a map leader for more key combos
let mapleader = ','
let g:mapleader = ','

set history=1000 " change history to 1000
set textwidth=120

" Tab control
set expandtab " insert tabs rather than spaces for <Tab>
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4 " the visible width of tabs
set softtabstop=4 " edit as if the tabs are 4 characters wide
set shiftwidth=4 " number of spaces to use for indent and unindent
set shiftround " round indent to a multiple of 'shiftwidth'
set completeopt+=longest

if has('mouse')
    set mouse=a
    " set ttymouse=xterm2
endif

" set clipboard=unnamed

" faster redrawing
set ttyfast

set diffopt+=vertical

" highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

set laststatus=2 " show the satus line all the time

" }}}

" Section AutoGroups {{{
" file type specific settings
augroup configgroup
    autocmd!
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType html setlocal ts=4 sts=4 sw=4 noexpandtab indentkeys-=*<return>
    autocmd FileType jade setlocal ts=2 sts=2 sw=2 noexpandtab
    autocmd FileType markdown,textile setlocal textwidth=0 wrapmargin=0 wrap spell
    autocmd FileType .xml exe ":silent %!xmllint --format --recover - 2>/dev/null"
    autocmd FileType crontab setlocal nobackup nowritebackup

    " automatically resize panes on resize
    autocmd VimResized * exe 'normal! \<c-w>='
    autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
    autocmd BufWritePost .vimrc.local source %

    autocmd BufNewFile,BufRead *.ejs set filetype=html
    autocmd BufNewFile,BufRead *.ino set filetype=c
    autocmd BufNewFile,BufRead *.svg set filetype=xml
    autocmd BufNewFile,BufRead .babelrc set filetype=json
    autocmd BufNewFile,BufRead .jshintrc set filetype=json
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

    autocmd! BufWritePost * Neomake
augroup END
function! SetQuit()
  if &ft =~ '\vhelp|text|qf'
    return
  endif
  map <buffer>quit :qa<cr>
endfunction
" http://stackoverflow.com/questions/3131393/remapping-help-in-vim-to-open-in-a-new-tab
cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'tab help' : 'h'
" }}}

" Section User Interface {{{

" code folding settings
set foldmethod=syntax " fold based on indent
" set foldmethod=manual " fold based on indent
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " don't fold by default
set foldlevel=1


set so=7 " set 7 lines to the cursors - when moving vertical
set wildmenu " enhanced command line completion
set hidden " current buffer can be put into background
set showcmd " show incomplete commands
set noshowmode " don't show which mode disabled for PowerLine
set wildmode=list:longest " complete files like a shell
set scrolloff=3 " lines of text around cursor
set shell=$SHELL
set cmdheight=1 " command bar height

set title " set terminal title

" Searching
set ignorecase " case insensitive searching
set smartcase " case-sensitive if expresson contains a capital letter
set hlsearch
set incsearch " set incremental search, like modern browsers
set nolazyredraw " don't redraw while executing macros

set magic " Set magic on, for regex

"set showmatch " show matching braces
"set mat=2 " how many tenths of a second to blink

" error bells
set noerrorbells
set visualbell
set t_vb=
"????david
set tm=500

" switch syntax highlighting on
syntax on

let base16colorspace=256  " Access colors present in 256 colorspace"
set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors"
set background=dark
if ( $THEME =~ 'base16' )
    execute "colorscheme ".$THEME
else
    colorscheme PaperColor
    hi Function ctermfg=146
endif
highlight Comment cterm=italic
highlight htmlArg cterm=italic

set number " show line numbers
"set relativenumber " show relative line numbers

set wrap "turn on line wrapping
set wrapmargin=8 " wrap lines when coming within n characters from side
set linebreak " set soft wrapping
set showbreak=… " show ellipsis at breaking

set autoindent " automatically set indent of new line
set smartindent

" increase decrease vertica split by +,_
nnoremap + 5<C-w>>
nnoremap _ 5<C-w><
let g:ack_use_dispatch = 1
" remap esc
inoremap jk <esc>

" markdown to html
" nmap <leader>md :%!markdown --html4tags <cr>

" remove extra whitespace
nmap <leader><space> :%s/\s\+$<cr>

" wipout buffer

" shortcut to save
nmap <leader>, :w<cr>

" disable Ex mode
noremap Q <NOP>

" set paste toggle
"???david
set pastetoggle=<F6>

" toggle paste mode
"map <leader>v :set paste!<cr>

" clear highlighted search
noremap <space> :set hlsearch! hlsearch?<cr>

" toggle invisible characters
set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
highlight SpecialKey ctermbg=none ctermfg=8 " make the highlighting of tabs less annoying
highlight NonText ctermbg=none ctermfg=8
" highlight Folded ctermbg=234 ctermfg=20
set showbreak=↪

" switch between current and last buffer
nmap <leader>. <c-^>

" enable . command in visual mode
vnoremap . :normal .<cr>
map <leader>wc :wincmd q<cr>

" toggle cursor line
nnoremap <leader>i :set cursorline!<cr>
nnoremap  ,I :call CursorPing()<CR>

" scroll the viewport faster
nnoremap <C-e> :call smooth_scroll#down(9, 0, 6)<CR>
nnoremap <C-y>  :call smooth_scroll#up(9, 0, 6)<CR>

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" search for word under the cursor
"david ==> search for word under cursor
" nnoremap <leader>/ "fyiw :/<c-r>f<cr>

" inoremap <tab> <c-r>=Smart_TabComplete()<CR>

" map <leader>r :call RunCustomCommand()<cr>
" map <leader>s :call SetCustomCommand()<cr>
let g:silent_custom_command = 0

" helpers for dealing with other people's code
nmap \t :set ts=4 sts=4 sw=4 noet<cr>
nmap \s :set ts=4 sts=4 sw=4 et<cr>

"!!!david ==> interesting, strange, worth looking at, probably I don't want it
"nmap <leader>w :setf textile<cr> :Goyo<cr>

" }}}

" Section Functions ,{{

"david ==> make base16 :colorscheme command actualy chage the blody color
" autocmd ColorScheme base16* execute 'silent !/bin/sh $DOTFILES/base16-shell/scripts/'.g:colors_name.'.sh'

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

" smart tab completion
function! Smart_TabComplete()
    let line = getline('.')                         " current line

    let substr = strpart(line, -1, col('.')+1)      " from the start of the current
    " line to one character right
    " of the cursor
    let substr = matchstr(substr, '[^ \t]*$')       " word till cursor
    if (strlen(substr)==0)                          " nothing to match on empty string
        return '\<tab>'
    endif
    let has_period = match(substr, '\.') != -1      " position of period, if any
    let has_slash = match(substr, '\/') != -1       " position of slash, if any
    if (!has_period && !has_slash)
        return '\<C-X>\<C-P>'                         " existing text matching
    elseif ( has_slash )
        return '\<C-X>\<C-F>'                         " file matching
    else
        return '\<C-X>\<C-O>'                         " plugin matching
    endif
endfunction

" execute a custom command
function! RunCustomCommand()
    up
    if g:silent_custom_command
        execute 'silent !' . s:customcommand
    else
        execute '!' . s:customcommand
    endif
endfunction

function! SetCustomCommand()
    let s:customcommand = input('Enter Custom Command$ ')
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
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
        for colors in values(a:palette.inactive)
            let colors[3] = 58
        endfor
endfunction

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

" map fuzzyfinder (CtrlP) plugin
" nmap <silent> <leader>t :CtrlP<cr>
let g:ctrlp_dotfiles=1
let g:ctrlp_working_path_mode = 'ra'

" Fugitive Shortcuts
nmap <silent> <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <silent><leader>gr :Gread<cr>
nmap <silent><leader>gb :Gblame<cr>

" toggle Limelight
nmap <leader>f :Limelight!!<cr>

let g:neomake_javascript_jshint_maker = {
    \ 'args': ['--verbose'],
    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
\ }

let g:neomake_typescript_tsc_maker = {
    \ 'args': ['-m', 'commonjs', '--noEmit' ],
    \ 'append_file': 0,
    \ 'errorformat':
        \ '%E%f %#(%l\,%c): error %m,' .
        \ '%E%f %#(%l\,%c): %m,' .
        \ '%Eerror %m,' .
        \ '%C%\s%\+%m'
\ }

autocmd FileType javascript let g:neomake_javascript_enabled_makers = findfile('.jshintrc', '.;') != '' ? ['jshint'] : ['eslint']
" let g:neomake_javascript_enabled_makers = ['jshint', 'jscs']
" let g:neomake_javascript_enabled_makers = ['eslint']

" CtrlP ignore patterns
" let g:ctrlp_custom_ignore = {
"             \ 'dir': '\.git$\|node_modules$\|bower_components$\|\.hg$\|\.svn$',
"             \ 'file': '\.exe$\|\.so$'
"             \ }
" only show files that are not ignored by git
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" search the nearest ancestor that contains .git, .hg, .svn
let g:ctrlp_working_path_mode = 2


" don't hide quotes in json files
let g:vim_json_syntax_conceal = 0


let g:SuperTabCrMapping = 0
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
    sleep 50m
    set nocursorline nocursorcolumn
endfunction

" FZF
"""""""""""""""""""""""""""""""""""""

let g:fzf_layout = { 'down': '~25%' }

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

nnoremap <silent> <Leader>C :call fzf#run({
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


call ApplyLocalSettings(expand('.'))
