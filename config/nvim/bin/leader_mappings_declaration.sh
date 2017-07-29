ag --color --color-match "38;05;1" --nogroup --ignore 'plugged' --ignore 'autoload/plug*' \
    '^[^\"\n]*map.*\s(<space>\w\w\w? |\\[\w\\] |1\w ).*?\w' | \
    perl -pe 's#([^\"\n]*?:.*?map.*?(<space>\w\w\w?|\\[\w\\]|1\w) .*)#\2   \1#g' | \
    ag '(^<space>...?|1.|\\.) ' | sort 

