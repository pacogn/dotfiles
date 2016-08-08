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
