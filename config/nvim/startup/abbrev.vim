" http://stackoverflow.com/questions/3131393/remapping-help-in-vim-to-open-in-a-new-tab
cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == 'h' ? 'tab help' : 'h'
cnoreabbrev <expr> ag getcmdtype() == ":" && getcmdline() == 'ag' ? 'Ag ' : 'ag'
cnoreabbrev <expr> agr getcmdtype() == ":" && getcmdline() == 'ag' ? 'Agraw ''' : 'ag'
cnoreabbrev <expr> bc getcmdtype() == ":" && getcmdline() == 'bc' ? 'BCommits' : 'bc'
"todo run trough each tab and set its name to directory on settname
"substitute(execute('pwd'),'.*/','','')
cnoreabbrev <expr> settname getcmdtype() == ":" ? 'so $DOTFILES/config/nvim/startup/tabname.vim<cr>' : 'settname'

