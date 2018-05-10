#!/bin/bash
short_sha=$(perl -pe 's#.*?([0-9a-f]+).*#\1#' <<< $1)
sha=$(git rev-parse $short_sha)
giturl=$(git config --get "remote.origin.url")
if [[ $giturl != 'https://' ]]; then
    #see `man expr` to understand these string substitutions
    #retain only the capturing group
    giturl=$(expr "${giturl}" : '.*:\(.*\)\.git$')
    giturl='https://www.github.com/'${giturl}

fi
giturl=${giturl}'/commit/'${sha}
echo $giturl > /tmp/a
open $giturl
