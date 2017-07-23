git show --color --pretty=oneline $(sed -E 's#.*([0-9a-f]{7}).*#\1#' <<< $1)
