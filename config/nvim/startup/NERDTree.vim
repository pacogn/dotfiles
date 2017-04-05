" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=0
let NERDTreeShowBookmarks=1
" show hidden files in NERDTree
let NERDTreeShowHidden=1
" remove some files by extension
let NERDTreeIgnore = ['\.js.map$', '.DS_Store']
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
augroup myNerdTreeGroup
	autocmd!
	autocmd FileType nerdtree map <buffer><C-s> i 
	autocmd FileType nerdtree map <buffer><C-v> s 
	autocmd FileType nerdtree map <buffer>,o o:NERDTreeClose<cr>
augroup END
