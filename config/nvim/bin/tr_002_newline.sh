#!/bin/sh
perl -pe 's#^\s*[[:digit:]]*(.*?)(,[vV])?$#\1#' <<< $1 | tr '\002' '\n' | less
