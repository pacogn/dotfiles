function! dir_utils#proj_root(dirname)
    if a:dirname =~ $DOTFILES.'/config/nvim'
        return $DOTFILES.'/confit/nvim'
    endif
    let foundRoot = isdirectory(a:dirname.'/.git') || filereadable(a:dirname.'/package.json')
    if foundRoot
        return a:dirname
    else
        " walk to the top of the dir tree
        let l:parentDir = strpart(l:curDir, 0, strridx(l:curDir, '/'))
        if isdirectory(l:parentDir)
            return dir_utils#proj_root(l:parentDir)
        endif
    endif
endfunction

function! dir_utils#cd_project_root_or_cache(projRoot)
    " echom 'projRoot = '.a:projRoot
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
    let projRoot = dir_utils#proj_root(expand('%:p:h'))
    if strlen(projRoot) < 2
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
        "remember which directory we want when comming to the current project
        let g:projectsRootDic[projRoot] = pwd
        return
    endif
    call dir_utils#cd_project_root_or_cache(projRoot)
endfunction

