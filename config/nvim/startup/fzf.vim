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


function! ResetCwd()
	echom 'into ResetCwd' 
	if exists("g:cwd") && strlen(g:cwd)>0
		cd `=g:cwd`
		let g:cwd = ""
	endif
endfunction
autocmd FileType help call ResetCwd()
function! LetterCommands()
	let g:cwd = getcwd()  
	cd /usr/local/Cellar/vim/8.0.0271/share/vim/vim80/doc
	:Agraw '--nobreak --noheading ''^\|(CTRL-)?\w\w?\w?\w?\|'''
endfunction
command! LetterCommands call LetterCommands()
