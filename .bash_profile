[ -f ~/.bashrc ] && . ~/.bashrc
#load script for prompt git aware
#\[\033[01;30m\] ==> black
#\[\033[01;32m\] ==> red
#\[\033[01;32m\] ==> green
#\[\033[01;33m\] ==>yellow
#\[\033[01;34m\] ==> blue
#\[\033[01;35m\] ==> pink
#\[\033[01;36m\] ==> cyan
#\[\033[01;37m\] ==> white
#\[\033[01;38m\] ==> gray
#\e[4;37m ==> white underline
#\e[4;37m ==> ansi white
#ansi reference http://stackoverflow.com/questions/15883416/adding-git-branch-on-the-bash-command-prompt
#\[\033[m\] ==> restore color to what it was

txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#PS1="\w\[\033[01;33m\]\$(__git_ps1)\[\033[0m\]\$ "
source ~/.dotfiles/git/.git-prompt.sh
#PS1="\w $bldwht\$(__git_ps1)\[\033[m\]\\u200b\\\$ "
# Prompt variables
PROMPT_BEFORE="\w "
PROMPT_AFTER="\$ "

# Prompt command
PROMPT_COMMAND='__git_ps1 "$PROMPT_BEFORE" "$PROMPT_AFTER"'

# Git prompt features (read ~/.git-prompt.sh for reference)
export GIT_PS1_SHOWDIRTYSTATE="true"
export GIT_PS1_SHOWSTASHSTATE="true"
export GIT_PS1_SHOWUNTRACKEDFILES="true"
# export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCOLORHINTS="true"

