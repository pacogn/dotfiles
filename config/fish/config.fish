set -x LANG en_US.UTF-8

[ -f /usr/local/share/autojump/autojump.fish ];
source /usr/local/share/autojump/autojump.fish

function ll
    ls -l $argv
end


function ff -a fn
    ag '(function\s+'$fn')|('$fn'\s*:)' | tig
end

alias npmprivate='npm config set registry https://npm.walkmedev.com; yarn config set registry https://npm.walkmedev.com'
alias npmpublic='npm config set registry https://registry.npmjs.org/; yarn config set registry https://registry.yarnpkg.com'

