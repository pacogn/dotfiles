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
    map <buffer>- :silent call BufDeleteCurrent()<cr>
endfunction
augroup myNerdTreeGroup
	autocmd!
	autocmd FileType nerdtree call s:setUpNerdMappings()
augroup END
