function! FindText(text, ...)
	let additionalParams = ( a:0 > 0 ) ? a:1 : ''
	let agcmd = ''''.a:text.''' '.additionalParams
	call fzf#vim#ag_raw(agcmd)
endfunction

function! FindFunction(functionName, ...)
	let additionalParams = ( a:0 > 0 ) ? a:1 : ''
	" (?<=...) positive lookbehind: must constain
	" (?=...) positive lookahead: must contain
	let agcmd = '''(?<=function\s)'.a:functionName.'(?=\()|'.a:functionName.'\s*:'' '.additionalParams
	call fzf#vim#ag_raw(agcmd)
endfunction

function! FindAssignment(variableName, ...)
	let additionalParams = ( a:0 > 0 ) ? a:1 : ''
	" (?<=...) positive lookbehind: must constain
	" (?=...) positive lookahead: must contai
	let agcmd = '''(=|:).*\b'.a:variableName.'\b'' | ag -v ''\('' '.additionalParams
	" call histadd('cmd', 'Agraw '''''.agcmd.''' -A 0 -B 0''')
	call fzf#vim#ag_raw(agcmd)
endfunction

function! FindUsage(variableName, ...)
	let additionalParams = ( a:0 > 0 ) ? a:1 : ''
	let agcmd = '''(?<!function\s)\b'.a:variableName.'(?=\()'' '.additionalParams
	" call histadd('cmd', 'Agraw '''''.agcmd.''' -A 0 -B 0''')
	call fzf#vim#ag_raw(agcmd)
endfunction

let onlyTest=' | ag ''(unit|spec).js'''
command! -nargs=+ FindFunction call FindFunction(<args>)
command! -nargs=+ FindAssignment call FindAssignment(<args>)
command! -nargs=+ FindUsage call FindUsage(<args>)
command! -nargs=+ FindText call FindText(<args>)
command! -nargs=+ FindNoTestFunction call FindFunction(<args>, $IGNORE_TESTS)
command! -nargs=+ FindNoTestAssignment call FindAssignment(<args>, $IGNORE_TESTS)
command! -nargs=+ FindNoTestUsage call FindUsage(<args>, $IGNORE_TESTS)
command! -nargs=+ FindNoTestText call FindText(<args>, $IGNORE_TESTS)
command! -nargs=+ FindOnlyTestFunction call FindFunction(<args>, onlyTest)
command! -nargs=+ FindOnlyTestAssignment call FindAssignment(<args>, onlyTest)
command! -nargs=+ FindOnlyTestUsage call FindUsage(<args>, onlyTest)
command! -nargs=+ FindOnlyTestText call FindText(<args>, onlyTest)
