# c - browse chrome history
# copied from https://junegunn.kr/2015/04/browsing-chrome-history-with-fzf/
chromehistory() {
  local cols sep 
  cols=$(( COLUMNS / 3 ))
  sep='{::}'


  historyfile=~/Library/Application\ Support/Google/Chrome/Profile\ 1/History
  if [[ ! -f $historyfile ]]; then
      historyfile=~/Library/Application\ Support/Google/Chrome/Default/History
      if [[ ! -f $historyfile ]]; then
          echo 'cannot find history file'
          return
      fi
  fi
  # /Default/History
  cp -f $historyfile /tmp/h

  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi \
      --preview 'echo {..-2}; echo $(tput setaf 12){-1} | sed -E '\''s#([&?])#'$(tput setaf 8)'\1\
'$(tput setaf 10)'#g'\' \
        --preview-window 'up:35%:wrap' \
        --header 'CTRL-o - open without abort :: CTRL-s - toggle sort :: CTRL-g - toggle preview window' \
        --prompt 'Chrome History>' \
        --bind 'ctrl-g:toggle-preview,ctrl-s:toggle-sort,ctrl-o:execute:open {-1}' | perl -pe 's|.*?(https*://.*?)|\1|' | xargs open
}

alias -g F=' | fzf  --ansi --preview '\''$DOTFILES/bin/preview.rb {}'\'' --preview-window '\''top:50%'\'' --bind '\''ctrl-g:toggle-preview,ctrl-o:execute:($DOTFILES/fzf/fhelp.sh {})'\'
alias fch='chromehistory'  

fstash() {
  git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
  fzf --ansi --no-sort \
      --header 'CTRL-o - git diff without abort :: CTRL-s - toggle sort :: CTRL-g - toggle preview window' \
      --preview-window 'up:55%:wrap' \
      --preview 'git stash show {1} > /tmp/tmp; echo "" >> /tmp/tmp; git stash show -p --color {1} >> /tmp/tmp; cat /tmp/tmp' \
      --bind 'ctrl-g:toggle-preview,ctrl-s:toggle-sort,ctrl-o:execute:git stash show -p {1}' | perl -pe 's#(.*?) .*#\1#' | pbcopy
  rm /tmp/tmp
}

function fag(){
    fzfretval=$(ag --color $@ | fzf  --ansi --preview '$DOTFILES/bin/preview.rb {}' \
        --preview-window 'top:50%' \
        --bind 'ctrl-s:toggle-sort,ctrl-g:toggle-preview,ctrl-o:execute:($DOTFILES/fzf/fhelp.sh {}) > /dev/tty' \
        --header 'CTRL-o - open without abort(LESS) :: CTRL-s - toggle sort :: CTRL-g - toggle preview window')
    #note the `< <` here has the same effect as <<. not obvious what could be the difference. see `man zshexpn` +228 for more. here the `<<` fucks up syntax highlight
    #for more on `<<<` see `here string` on `man bash`
    IFS=: read filename linenum ignorerest< <(sed -E 's/([^:]*:[[:digit:]]+)/\1:/' <<< $fzfretval)
    if [[ -f $filename ]]; then
        vim +$linenum $filename
    fi
}

function fman(){
    if [[ $# -eq 0 ]]; then
        echo 'need a search argument for this'
        return
    fi
    fzfretval=$(findmanpage --color $@ | fzf --ansi --preview '$DOTFILES/bin/preview.rb {}' --preview-window 'top:50%' --bind 'ctrl-g:toggle-preview')
    if [[ -n $fzfretval ]]; then
        manpage=$(sed -E 's#.*/(.*)\..*#\1#' <<< $( sed -E 's#([^[:space:]]*):[[:digit:]]+:.*#\1#' <<< $fzfretval))
        # manpage=$(sed -E 's#^[^[:space:]:]*/([[:alnum:]]*)\..*#\1#' <<< $fzfretval)
        #`${@: -1}` get the last argument to the function
        #-j12: tells less to put 12lines above search result as opposed to search result on top of screen

        searchpattern=$(sed 's/\\b//g' <<< ${@: -1})
        man $manpage | less -i -j12 -p $searchpattern
    fi
}
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
alias fj='jfzf'
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
