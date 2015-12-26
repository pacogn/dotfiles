export PATH="$PATH:$HOME/.rvm/bin:~/.bin" # Add RVM to PATH for scripting

[ -s ~/.nvm/nvm.sh ] && source ~/.nvm/nvm.sh
export NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist

[[ -s "$HOME/.dotfiles/.aliases" ]] && source "$HOME/.dotfiles/.aliases"
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Ignore duplicates in command history
export HISTCONTROL=ignoredups

alias setzsh='chsh -s /bin/zsh'
function myclear {
osascript -e 'tell application "System Events" to keystroke "k" using command down'
}
