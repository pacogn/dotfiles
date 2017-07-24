if [[ $(echo $1 | egrep '.*([0-9a-f]{7}).*') == '' ]]
then
  echo "\033[38;5;1m"NO SHA FOUND IN "\033[38;5;15m"\$1 = $1
else
  git show \
      --date=short \
      --stat \
      --color \
      --pretty='Author: %Cgreen %aN %Cblue<%ae>    %Creset --    Date:%Cgreen %ad' \
      $(perl -pe 's#.*?([0-9a-f]+).*#\1#' <<< $1)
fi
