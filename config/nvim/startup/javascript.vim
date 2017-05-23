"--------------------------------------------------------------------------------
"MAPPINGS{{{
"--------------------------------------------------------------------------------


"--------------------------------------------------------------------------------
"FUNCTIONS{{{
"--------------------------------------------------------------------------------

function! RunNeomakeEslint()
	if exists("b:neomake_javascript_eslint_exe") && b:neomake_javascript_eslint_exe !~ 'eslint not found' && &ft =~ 'javascript' && filereadable(b:neomake_javascript_eslint_exe)
		Neomake
	endif
endfunction

function! GetCurrLineIndentation()
    return len(substitute(getline('.'), '\(\s*\).*', '\1', '')) 
endfunction

function! GoToNextFunction(originalLineIndentation, recurseCount, searchBackward)
    echo 'GoToNextFunction - recurseCount = '.a:recurseCount
    set nohlsearch
    let originalLineIndentation = a:originalLineIndentation
    if a:recurseCount > 8
        return
    endif
    let flags = 'eW'
    if originalLineIndentation == -1
        let originalLineIndentation = GetCurrLineIndentation()
        let flags = 'eWs'
    endif
    if a:searchBackward == 1
        let flags = 'b'.flags
    endif
    let functionLineRegex = 'function\s*\w*(.*{'
    let blockStartLineRegex = '\w*([^)]*)\s*{'
    call search(functionLineRegex.'\|'.blockStartLineRegex, flags)
    let currLine = getline('.')
    if (GetCurrLineIndentation() > originalLineIndentation) && (originalLineIndentation > 0)
        call GoToNextFunction(originalLineIndentation, a:recurseCount + 1, a:searchBackward)
    else
        call feedkeys("zz")
	if getpos('.')[1] > 20
	    call feedkeys("\<c-e>\<c-e>\<c-e>")
	endif
    endif
endfunction

function! JSToggleFoldMethod()
    if &foldmethod=='syntax' 
        set foldmethod=manual 
    else 
        set foldmethod=syntax 
    endif
endfunction

"-----------------------------------------------------------------------------}}}
"AUTOCOMMANDS                                                                 {{{
"--------------------------------------------------------------------------------
augroup javascript
    autocmd!
    " autocmd FileType javascript silent! call LimeLightExtremeties()
    autocmd BufNewFile,BufRead *.es6 set filetype=javascript
    let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'json=javascript', 'stylus', 'html']
    autocmd BufWritePost * call RunNeomakeEslint()
    autocmd FileType javascript nnoremap <buffer>{ :call GoToNextFunction(-1, 0, 1)<cr>
    autocmd FileType javascript nnoremap <buffer>} :call GoToNextFunction(-1, 0, 0)<cr>
    autocmd FileType javascript nnoremap <buffer>cof :call JSToggleFoldMethod()<cr>
    autocmd Filetype javascript vnoremap <buffer>1= :<C-u>setf jsx<cr>gv=:<C-u>setf javascript<cr>
augroup END
"-----------------------------------------------------------------------------}}}
