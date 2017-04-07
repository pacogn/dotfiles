"--------------------------------------------------------------------------------
"MAPPINGS{{{
"--------------------------------------------------------------------------------


"--------------------------------------------------------------------------------
"FUNCTIONS{{{
"--------------------------------------------------------------------------------

function! RunNeomakeEslint()
	if exists("b:neomake_javascript_eslint_exe") && b:neomake_javascript_eslint_exe !~ 'eslint not found' && &ft =~ 'javascript' 
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
        call feedkeys("zz\<c-e>\<c-e>\<c-e>")
    endif
endfunction


"-----------------------------------------------------------------------------}}}
"AUTOCOMMANDS                                                                 {{{
"--------------------------------------------------------------------------------
augroup javascript
	autocmd!
	autocmd FileType javascript silent! call LimeLightExtremeties()
	autocmd BufNewFile,BufRead *.es6 set filetype=javascript
	let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'json=javascript', 'stylus', 'html']
	autocmd BufWritePost * call RunNeomakeEslint()
    autocmd FileType javascript nnoremap <buffer>{ :call GoToNextFunction(-1, 0, 1)<cr>
    autocmd FileType javascript nnoremap <buffer>} :call GoToNextFunction(-1, 0, 0)<cr>
augroup END
"-----------------------------------------------------------------------------}}}
