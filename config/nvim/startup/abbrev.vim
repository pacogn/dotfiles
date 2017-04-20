" http://stackoverflow.com/questions/3131393/remapping-help-in-vim-to-open-in-a-new-tab
cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'tab help' : 'h'
cnoreabbrev <expr> ag getcmdtype() == ":" && getcmdline() == 'ag' ? 'Ag ' : 'ag'
cnoreabbrev <expr> agb getcmdtype() == ":" && getcmdline() == 'agb' ? 'AgBLines ' : 'ag'
cnoreabbrev <expr> agr getcmdtype() == ":" && getcmdline() == 'agr' ? 'Agraw ''' : 'agr'
cnoreabbrev <expr> bc getcmdtype() == ":" && getcmdline() == 'bc' ? 'BCommits' : 'bc'
cnoreabbrev <expr> mru getcmdtype() == ":" && getcmdline() == 'mru' ? 'Mru' : 'mru'

