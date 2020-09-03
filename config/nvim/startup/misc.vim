"-----------------------------------------------------------------------------}}}
"VARIABLES                                                                    {{{ 
"--------------------------------------------------------------------------------
"see :h sh.vim line 2871... in /bin/sh $(command) is an error 
let g:is_bash = 1
"avoid paren error on continuation liine - https://groups.google.com/forum/#!topic/vim_use/ohVfm9Iodwg
let g:vimsyn_noerror = 1
let g:peekaboo_window='vert bo 60new'
let g:diminactive_buftype_blacklist = ['nowrite', 'acwrite']
" let g:diminactive_enable_focus = 1
let g:rooter_manual_only = 1
let g:table_mode_corner = '|'
let g:table_mode_separator = '|'
let g:tern_request_timeout = 2
let g:tern_show_signature_in_pum = 0  " This do disable full signature type on autocomplete
let g:normal_cursor_line_column = &cursorcolumn
let g:gitgutter_map_keys = 0
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.js,*.jsx"
" " pass --presistent when starting server to avoid it from ever shutting down -- http://ternjs.net/doc/manual.html
" let g:tern#arguments = ["--persistent"]
" set a map leader for more key combos
let mapleader = ','
let g:mapleader = ','
let g:ack_use_dispatch = 1
" don't hide quotes in json files
let g:vim_json_syntax_conceal = 0

command! -nargs=* -complete=shellcmd Rsplit execute "new | r! <args>"

"-----------------------------------------------------------------------------}}}
"FUNCTIONS                                                                      {{{ 
"--------------------------------------------------------------------------------
"todo: this function should be in autoload directory for lazy loading
function! ListDotFiles(dir, command)
    call fzf#run({'dir': a:dir,
		\'source': a:command,
		\'sink': 'e'})
endfunction
function! SynL()
   for i in map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')
        exe 'highlight '.i   
   endfor
endfunction
command! SynL call SynL()

function! IntoTemp(cmd)
   redir => cout
   silent execute a:cmd
   redir END
   e /tmp/vimredirected
   put=cout
endfunction

function! Vimrc(...)
    let query = get(a:000, 0, '^')
    if !len(query)
	let query = '^'
    endif
    if query !~ '^''' || query !~ '''$'
        let query = shellescape(query)
    endif
    call fzf#vim#ag_raw(
		\'--ignore ''autoload/plug*''  ' .
		\'--ignore ''plugged'' '.
		\query, 
		\fzf#vim#with_preview({'dir': '$DOTFILES/config/nvim/', 'options': '--bind ctrl-s:toggle-sort'}, 'up:40%', 'ctrl-g'), 1)
endfunction

function! Carmicat(...)
    let query = get(a:000, 0, '^')
    if !len(query)
	let query = '^'
    endif
    if query !~ '^''' || query !~ '''$'
	let query = shellescape(query)
    endif
    call fzf#vim#ag_raw(
		\"-G ".
        \'''carmi\.js''', 
		\fzf#vim#with_preview({'dir': '~/projects/bolt/', 'options': '--bind ctrl-s:toggle-sort'}, 'up:40%', 'ctrl-g'), 1)
endfunction

" Zoom - from https://github.com/junegunn/dotfiles/blob/master/vimrc<Paste>
function! s:zoom()
    if winnr('$') > 1
	tab split
    elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
		\ 'index(v:val, '.bufnr('').') >= 0')) > 1
	tabclose
    endif
endfunction
nnoremap <silent> \z :call <sid>zoom()<cr>


function! ClearMessages()
    for n in range(200) | echom "" | endfor
endfunction
"failing on remote machines occasionaly... not important
silent! language en_US.UTF-8

function! OnInsertLeave()
    if(g:normal_cursor_line_column)
        set cursorline nocursorcolumn
    else
        set nocursorline nocursorcolumn
    endif
endfunction

"-----------------------------------------------------------------------------}}}
"MAPS                                                                        {{{ 
"--------------------------------------------------------------------------------
inoremap jk <esc>:update<cr>
inoremap jj <esc>

inoremap <C-h> <C-o>h                          " move left while in insert mode
inoremap <C-l> <C-o>a                          " move right while in insert mode

nnoremap ,h <C-w>h
nnoremap ,l <C-w>l
nnoremap ,j <C-w>j
nnoremap ,k <C-w>k

cnoremap jk <C-c>

" Make Y behave like other capitals
nnoremap Y y$

" qq to record, Q to replay (recursive map due to peekaboo)
nmap Q @q

"-----------------------------------------------------------------------------}}}
"OPTIONS                                                                      {{{ 
"--------------------------------------------------------------------------------

if has('nvim')
    if (has("termguicolors"))
        set termguicolors
    endif
endif

if has('mouse')
    set mouse=a
endif

syntax on " switch syntax highlighting on
let base16colorspace=256  " Access colors present in 256 colorspace"

" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colorscheme ayu
" colorscheme PaperColor
colorscheme dracula

" set background=dark
hi Normal guibg=NONE ctermbg=NONE

"
" syntax on
" set t_Co=256
" set cursorline
" colorscheme onehalf
" let g:airline_theme='onehalfdark'
"lightline
"let g:lightline.colorscheme='onehalfdark'

" Select the colorscheme
" if has('nvim')
"     if ( $THEME =~ 'base16' )
"         execute "colorscheme ".$THEME
"     else
"         colorscheme base16-chalk
"     endif
" else
"     colorscheme PaperColor
" endif


" highlight conflicts
" match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

"-----------------------------------------------------------------------------}}}
"AUTOCOMMANDS                                                                 {{{ 
"--------------------------------------------------------------------------------
augroup configgroup
    autocmd!
    " Trigger autoread when changing buffers or coming back to vim.
    au FocusGained,BufEnter * :silent! !
    " Save whenever switching windows or leaving vim.
    au FocusLost,WinLeave * :silent! wa

    au VimEnter * call histdel(':', '^qa\?$')
    au VimEnter * set tabstop=4
    "this is my way of disabling syntax highlight for very large files... A little clumsy but good enough for now
    autocmd BufEnter * if line('$') > 15000 | set filetype=none | endif
    autocmd BufNewFile,BufRead *.rt set filetype=html
    autocmd BufNewFile,BufRead *.svg set filetype=xml
    autocmd BufNewFile,BufRead .babelrc set filetype=json
    autocmd BufNewFile,BufRead .eslintrc set filetype=json
    autocmd BufNewFile,BufRead,BufWrite *.md syntax match Comment /\%^---\_.\{-}---$/
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown

    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html setlocal ts=4 sts=4 sw=4 noexpandtab indentkeys-=*<return>
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    " autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType markdown,textile setlocal textwidth=0 wrapmargin=0 wrap spell
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

    " make quickfix windows take all the lower section of the screen
    " when there are multiple windows open
    autocmd FileType qf wincmd J
    " close help files on 'q'
    autocmd FileType qf,help nnoremap <buffer>q :bd<cr>
    autocmd FileType vim set shiftwidth=4 
    autocmd FileType vim call matchadd('vimComment', '|"[^''"]*$')
    
    autocmd FileType vim map <buffer><space>sc :source %<cr> 
    autocmd FileType vim setlocal foldmethod=marker 
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd InsertEnter * set cursorline nocursorcolumn
    autocmd InsertLeave * call OnInsertLeave()
    "THIS BACAME REDUNTANT SINCE `set clipboard+=unnamedplus`
    "keep clipboard synched to system
    " autocmd TextYankPost * let @*=@"
    " autocmd FocusGained * let @@=system('pbpaste')
    " automatically resize panes on resize
    autocmd VimResized * exe 'normal! \<c-w>='
augroup END

function! ToggleDiffWhiteSpace()
   if &diffopt =~ 'iwhite'
      set diffopt-=iwhite
   else
      set diffopt+=iwhite
   endif
endfunction

command! ClearCache let g:projectsRootDic = {}
command! ToggleDiffWhiteSpace call ToggleDiffWhiteSpace()
if has('nvim')
   augroup multiProjectAutoCd
      autocmd!
      autocmd BufWinEnter * call dir_utils#CdOnBufferEnter(0)
      autocmd WinEnter * call dir_utils#CdOnBufferEnter(0)
      autocmd DirChanged * call dir_utils#CdOnBufferEnter(1)
   augroup END
endif
function! CDG()
   let currWorkingDir = utils#get_project_root(getcwd())
   let pwd = getcwd()
   if &filetype != 'nerdtree'
       execute 'Rooter'
       if currWorkingDir == pwd && has_key(g:projectsRootDic, pwd) && currWorkingDir =~ getcwd()
           let g:projectsRootDic[currWorkingDir] = getcwd()
       endif
   endif  
endfunction
"-----------------------------------------------------------------------------}}}
"COMMANDS                                                                     {{{ 
"--------------------------------------------------------------------------------
"source http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
command! -complete=shellcmd -bang -nargs=+ Shell call utils#run_shell_command(<q-args>, <bang>0)
command! -bang GPush call utils#run_shell_command('git push', <bang>0)
command! -bang GPull call utils#run_shell_command('git pull', <bang>0)
command! CherryPickHelp call cherry_pick_helper#buffer_commits_ordered_by_date()
command! CopyFilePath :exe "let @*='".expand('%:p')."'"
command! CopyFileName :exe "let @*='".expand('%:t')."'"
command! CopyFileNameNoExtension :exe "let @*='".substitute(expand('%:t'), '\(.*\)\..*', '\1', '')."'"
command! CopyRelativeFilePath exe "let @*='".substitute(expand('%:p'), getcwd().'/', '', '')."'"
command! ToStoreKey :%s#\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2#gc

" quick open snippets file for current filetype
command! OpenInWebstorm call utils#open_in_webstorm()
command! ListDotFiles call ListDotFiles('$DOTFILES/',  'git ls-files')
command! DotFiles call ListDotFiles('$DOTFILES',  'git ls-files')
command! DotVim call ListDotFiles('$DOTFILES/config/nvim/',  'git ls-files')
command! DotPlugged call ListDotFiles('$DOTFILES/config/nvim/plugged',  'find . -type f | grep -vF .git ')
command! DotPluggedDirectories call ListDotFiles('$DOTFILES/config/nvim/plugged',  'ls | grep -vF .git ')
command! -nargs=? Vimrc call Vimrc(<q-args>)
"not good enough CDR for filetype nerdtree but will do it for now
command! CDG call CDG()
command! CDR if &filetype == 'nerdtree' | execute 'CDC' | else | call utils#cd_project_root(expand('%:p:h')) | endif
command! CDC if &filetype == 'nerdtree' | execute 'cd /'.join(b:NERDTreeRoot.path.pathSegments, '/') | else | cd %:p:h | endif
command! ClearMessages call ClearMessages()
command! AutoCDCancel let g:cancelAutoCd=1
command! AutoCDEnable unlet! g:cancelAutoCd
"-----------------------------------------------------------------------------}}}

