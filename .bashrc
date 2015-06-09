
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[ -s ~/.nvm/nvm.sh ] && source ~/.nvm/nvm.sh

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

alias sayvic='say --voice Victoria'
PS1='$(pwd)/> '
alias rm='rm -i'
alias cp='cp -i'
