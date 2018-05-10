#!/bin/bash
git show --color --pretty=oneline $(perl -pe 's#.*?([0-9a-f]+).*#\1#' <<< $1)
