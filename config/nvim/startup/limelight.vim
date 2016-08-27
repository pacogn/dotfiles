" LimeLight
"""""""""""""""""""""""""""""""""""""
let g:limelightindent=4
function! LimeLightExtremeties()
    " let g:limelight_eop='^\s\{0,'.g:limelightindent.'\}}\|^\s\{0,'.g:limelightindent.'\}function\|\w*:\s*function\s*('
    " let g:limelight_bop='^\s*function\|\w*:\s*function'
    let limelight_start_stop='^\s\{0,'.g:limelightindent.'\}\S'
    let g:limelight_eop=limelight_start_stop
    let g:limelight_bop=limelight_start_stop
    Limelight!!
    Limelight!!
    echo 'limelightindent = '.g:limelightindent
endfunction
function! SetLimeLightIndent(count)
    let g:limelightindent = a:count
    if(g:limelightindent < 0)
        g:limelightindent = 0
    endif
    call LimeLightExtremeties()
endfunction
command! -nargs=*  SetLimeLightIndent call SetLimeLightIndent(<args>)
