#!/bin/bash
echo $(sed -E 's#.*([0-9a-f]{7}).*#\1#' <<< $1) > /tmp/a
git show --color --pretty=oneline $(perl -pe 's#.*?([0-9a-f]+).*#\1#' <<< $1)
