" FZF
"""""""""""""""""""""""""""""""""""""

let g:fzf_layout = { 'down': '~40%' }
" let g:fzf_command_prefix = 'Fzf'
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


augroup myfzfgroup
	autocmd!
	autocmd VimEnter * command! -nargs=* -bang Agraw call fzf#vim#ag_raw(<args>)
	autocmd FileType help call ResetCwd()
	autocmd FileType vim call ResetCwd()
augroup END
function! LetterCommands()
    let g:cwd = getcwd()  
    let g:currentfile = @%
    cd /usr/local/Cellar/vim/8.0.0271/share/vim/vim80/doc
    :Agraw '--nobreak --noheading --ignore ''howto*'' --ignore ''intro*'' --ignore ''edit*'' --ignore ''help*'' --ignore ''if_*'' --ignore ''ft_*'' --ignore autoc* --ignore change* --ignore ''gui_*'' --ignore ''eval'' ''^\|[^-:0-9](\|?|[^:]{0,6}[^)])\|'''
endfunction
command! LetterCommands call LetterCommands()

function! LeaderMappingsDeclaration()
    let g:cwd = getcwd()
    let g:currentfile = @%
    cd $DOTFILES/config/nvim/startup
    :Ag ^\s*[^"\s]*map.*,[!-~]*
endfunction
command! LeaderMappingsDeclaration call LeaderMappingsDeclaration()
