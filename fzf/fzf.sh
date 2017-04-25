# c - browse chrome history
# copied from https://junegunn.kr/2015/04/browsing-chrome-history-with-fzf/
chromehistory() {
  local cols sep
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  cp -f ~/Library/Application\ Support/Google/Chrome/Profile\ 1/History /tmp/h

  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#''\1''#' | xargs open
}

alias -g F=' | fzf  --ansi --preview '\''$DOTFILES/bin/preview.rb {}'\'' --preview-window '\''top:50%'\'' --bind '\''ctrl-g:toggle-preview,ctrl-e:execute:($DOTFILES/fzf/fhelp.sh {})'\'

# fshow - git commit browser
# copied from https://junegunn.kr/2015/03/browsing-git-commits-with-fzf/
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

alias chromebookmarks='$DOTFILES/fzf/chromebookmarks.rb'

function jfzf(){
  dir=`j -s | egrep '^\d+.\d+:\s+/' | tail -r | fzf`
  if [[ -n dir ]]; then
    cd $(echo $dir | sed -E 's#[^/]*(/.*$)#''\1''#')
  fi
}
alias jf='jfzf'
# /Users/davidsu/Library/Application Support/Google/Chrome/Profile 1
fzf-chth(){
  local selected
  if selected=$(find $DOTFILES/base16-shell/scripts | fzf ); then
    source $selected
    local _theme=`echo $selected | tr '/' '\n' | egrep 'base.*sh$'`
    THEME=${_theme:0:-3}
    zle redisplay
    # THEME=selected
  fi
}
zle     -N    fzf-chth
bindkey '^Y' fzf-chth

# fzf-locate-widget() {
#   local selected
#   if selected=$(find $DOTFILES/base16-shell/scripts | fzf ); then
#     LBUFFER=$selected
#   fi
#   zle redisplay
# }
# zle     -N    fzf-locate-widget
# bindkey '^N' fzf-locate-widget
