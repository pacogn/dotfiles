"http://dhruvasagar.com/2013/03/28/vim-better-foldtext
" function! NeatFoldText() "{{{2
"   let indent = substitute(getline(v:foldstart), '^\(\s*\).*', '\1', '')
"   let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
"   let lines_count = v:foldend - v:foldstart + 1
"   let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |  '. len(indent) . '  |'
"   let foldchar = matchstr(&fillchars, 'fold:\zs.')
"   let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
"   let foldtextend = lines_count_text . repeat(foldchar, 8) 
"   let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
"   return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
" endfunction
" set foldtext=NeatFoldText()
function! NeatFoldText() "{{{2
  let indent = substitute(getline(v:foldstart), '^\(\s*\).*', '\1', '')
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |  '. len(indent) . '  |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, len(indent)-2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8) 
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()
