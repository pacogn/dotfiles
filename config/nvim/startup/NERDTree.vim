" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=0
let NERDTreeShowBookmarks=0
" show hidden files in NERDTree
let NERDTreeShowHidden=1
" remove some files by extension
let NERDTreeIgnore = ['\.js.map$', '.DS_Store']
let NERDTreeWinSize = 40

if isdirectory(expand(".git"))
    let g:NERDTreeBookmarksFile = '.git/.NERDTreeBookmarks'
endif

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✭",
    \ "Staged"    : "✚",
    \ "Untracked" : "✹",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "✂",
    \ "Deleted"   : "✗",
    \ "Dirty"     : "✖",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
    
function! s:setUpNerdMappings()
    map <buffer><C-s> i 
    map <buffer><C-v> s 
    map <buffer>1o o:NERDTreeClose<cr>
    "callling BufDeleteCurrent will reset properly the alternate file
    map <buffer>- :call BufDeleteCurrent()<cr>
endfunction
let g:nerdToWipe = ''
function! RememberNerdToWipe(bname)
    " can't wipeout just yet, nerdTree will throw exceptions if we do
    if exists('t:NERDTreeBufName') && a:bname =~ 'NERD_tree' && a:bname !~ t:NERDTreeBufName
        let g:nerdToWipe = a:bname
    endif
endfunction
function! s:wipeRememberedNerd()
    " now that we are loading another file we kknow nerdTree has finished with all it's commands and autocommands, it's safe to bwipeout now
    " see sudavid4/nerdtree commit 909cf25722f206f82128554c7c6dd1ed34a95949 is needed for this to work properly
    if strlen(g:nerdToWipe) > 0
        execute 'bwipeout '.g:nerdToWipe
        let g:nerdToWipe=''
    endif
endfunction
augroup myNerdTreeGroup
	autocmd!
	autocmd FileType nerdtree call s:setUpNerdMappings()
	autocmd BufHidden * call RememberNerdToWipe(expand('<afile>'))
    autocmd BufWinEnter * call s:wipeRememberedNerd()
augroup END
