function! dir_utils#cd_project_root_or_cache(projRoot)
    if has_key(g:projectsRootDic, a:projRoot)
        execute 'cd '.g:projectsRootDic[a:projRoot]
    else
        let g:projectsRootDic[a:projRoot] = a:projRoot
        execute 'cd '.a:projRoot
        return
    endif
endfunction

function! dir_utils#CdOnBufferEnter(isDirChange)
    if !exists('g:projectsRootDic')
        let g:projectsRootDic = {}
    endif
    let pwd = getcwd()
    let projRoot = utils#get_project_root(expand('%:p:h'))
    if !isdirectory(projRoot)
        return
    endif
    if a:isDirChange
        let g:projectsRootDic[projRoot] = pwd
        return
    endif
    if pwd =~ 'config/nvim/plugged'
        call dir_utils#cd_project_root_or_cache(projRoot)
        return
    endif
    if pwd =~ projRoot 
        "this means that getcwd() is a child of projRoot..."
        "remember which directory we want when comming to the current project
        let g:projectsRootDic[projRoot] = pwd
        return
    endif
    call dir_utils#cd_project_root_or_cache(projRoot)
endfunction

