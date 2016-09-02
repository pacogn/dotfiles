export IGNORE_TESTS=" --ignore '*.spec.js' --ignore '*.unit.js' --ignore '*.it.js' --ignore '*.*.spec.js' --ignore '*.*.*unit.js' --ignore '*.*.*it.js' "
function FindFunction(){
    echo ag '(?<=function\s)'$1'(?=\()|'$1'\s*:' ${@:2}
    ag '(?<=function\s)'$1'(?=\()|'$1'\s*:' ${@:2}
}

function FindAssignment(){
    ag --color '(=|:).*\b'$1'\b' | ag -v '\(' ${@:2}
}

function FindUsage(){
    ag '(?<!function\s)\b'$1'(?=\()' ${@:2}
}

alias af='FindFunction '
alias au='FindUsage '
alias aa='FindAssignment '

function antf(){
    FindFunction $1 --ignore '*.spec.js' --ignore '*.unit.js' --ignore '*.*.spec.js' --ignore '*.*.*unit.js' ${@:2}
}

function anta(){
    FindAssignment $1 --ignore '*.spec.js' --ignore '*.unit.js' ${@:2}
}

function antu(){
    FindUsage $1 --ignore '*.spec.js' --ignore '*.unit.js' ${@:2}
}
