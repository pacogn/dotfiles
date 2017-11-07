function! s:git_blame_to_tmp_file()
    let git_blame_output=system('git blame '.expand('%'))
    let tmpfile = tempname()
    execute 'pedit '.tmpfile
    wincmd P
    nnoremap <buffer>q :bd<cr>
    silent put =git_blame_output
    normal ggdd
endfunction

function! cherry_pick_helper#buffer_commits_ordered_by_date()
    call s:git_blame_to_tmp_file()
    " keep (sha author date) only
    silent %s/\v^.{-}\s\d{4}-\d{2}-\d{2}\s\zs.*//g
    sort u
    let len_before_date = len(substitute(getline('.'), '\(.*\)\d\d\d\d-\d\d-\d\d', '\1', ''))
    " sort by date, latest first
    execute 'sort! /.*\%'.len_before_date.'v/'

endfunction

