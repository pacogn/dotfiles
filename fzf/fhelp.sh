#!/bin/zsh
linenum=$(echo $1 | sed -E "s/[^:]*:([^:]*).*/\1/")
filename=$(echo $1 | sed -E "s/([^:]*):.*/\1/")
if [[ $linenum -gt 30 ]]; then
	linenum=$(expr $linenum - 20) 
elif [[ $linenum -gt 25 ]]; then
	linenum=$(expr $linenum - 10)
else
	linenum=0
fi
$DOTFILES/fzf/fhelp.rb $1 | less -N +${linenum}g
