let g:foldsearch_disable_mappings=1
map ,fs :call foldsearch#foldsearch#FoldSearch()<CR>
map ,fw :call foldsearch#foldsearch#FoldCword()<CR>
map ,fS :call foldsearch#foldsearch#FoldSpell()<CR>
" map ,fl :call foldsearch#foldsearch#FoldLast()<CR>
map ,fi :call foldsearch#foldsearch#FoldContextAdd(+1)<CR>
map ,fd :call foldsearch#foldsearch#FoldContextAdd(-1)<CR>
map ,fe :call foldsearch#foldsearch#FoldSearchEnd()<CR>

