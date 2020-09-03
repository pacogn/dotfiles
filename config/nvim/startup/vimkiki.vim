let g:vimwiki_list = [{ 'path': '~/.vimwiki/' }]
nmap <space>ww <Leader>ww

map <buffer> <space>tt <Plug>VimwikiToggleListItem
map <buffer> ,tt :VimwikiTable 
nmap <space>t<space>y <Plug>VimwikiMakeYesterdayDiaryNote
" nmap <space>t<space>t <Plug>VimwikiMakeTomorrowDiaryNote

nmap <Leader>dt <Plug>VimwikiTabMakeDiaryNote
nmap <Leader>dm <Plug>VimwikiMakeTomorrowDiaryNote
nmap <Leader>dy <Plug>VimwikiMakeYesterdayDiaryNote
