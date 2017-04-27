"-----------------------------------------------------------------------------}}}
"FUNCTIONS                                                                    {{{ 
"--------------------------------------------------------------------------------
function! ExecMapping(line)
    let l:mapping = matchstr(a:line, '^\S*')
    call feedkeys(substitute(l:mapping, '<[^ >]\+>', '\=eval("\"\\".submatch(0)."\"")', 'g'))
endfunction

function! FugitiveMappings()
   let l:mappings = [
		\'g?    show this help',
		\'<C-N> next file',
		\'<C-P> previous file',
		\'<CR>  |:Gedit|',
		\'-     |:Git| add',
		\'-     |:Git| reset (staged files)',
		\'cA    |:Gcommit| --amend --reuse-message=HEAD',
		\'ca    |:Gcommit| --amend',
		\'cc    |:Gcommit|',
		\'cva   |:Gcommit| --amend --verbose',
		\'cvc   |:Gcommit| --verbose',
		\'D     |:Gdiff|',
		\'ds    |:Gsdiff|',
		\'dp    |:Git!| diff (p for patch; use :Gw to apply)',
		\'dp    |:Git| add --intent-to-add (untracked files)',
		\'dv    |:Gvdiff|',
		\'O     |:Gtabedit|',
		\'o     |:Gsplit|',
		\'p     |:Git| add --patch',
		\'p     |:Git| reset --patch (staged files)',
		\'q     close status',
		\'r     reload status',
		\'S     |:Gvsplit|',
		\'U     |:Git| checkout',
		\'U     |:Git| checkout HEAD (staged files)',
		\'U     |:Git| clean (untracked files)',
		\'U     |:Git| rm (unmerged files)'] 
  call fzf#run({
	      \'source': l:mappings,
	      \'sink': function('ExecMapping'),
	      \'right': '60%'
	      \})
endfunction

function! FzfNerdTreeMappings()
    let l:mappings = [
		\'o       Open files, directories and bookmarks                    |NERDTree-o|' ,
		\'go      Open selected file, but leave cursor in the NERDTree     |NERDTree-go|' ,
		\'t       Open selected node/bookmark in a new tab                 |NERDTree-t|' ,
		\'T       Same as ''t'' but keep the focus on the current tab      |NERDTree-T|' ,
		\'i       Open selected file in a split window                     |NERDTree-i|' ,
		\'gi      Same as i, but leave the cursor on the NERDTree          |NERDTree-gi|',
		\'s       Open selected file in a new vsplit                       |NERDTree-s|' ,
		\'gs      Same as s, but leave the cursor on the NERDTree          |NERDTree-gs|',
		\'O       Recursively open the selected directory                  |NERDTree-O|' ,
		\'x       Close the current nodes parent                           |NERDTree-x|' ,
		\'X       Recursively close all children of the current node       |NERDTree-X|' ,
		\'e       Edit the current dir                                     |NERDTree-e|' ,
		\'D       Delete the current bookmark                              |NERDTree-D|' ,
		\'P       Jump to the root node                                    |NERDTree-P|' ,
		\'p       Jump to current nodes parent                             |NERDTree-p|' ,
		\'K       Jump up inside directories at the current tree depth     |NERDTree-K|' ,
		\'J       Jump down inside directories at the current tree depth   |NERDTree-J|' ,
		\'<C-J>   Jump down to the next sibling of the current directory   |NERDTree-C-J|' ,
		\'<C-K>   Jump up to the previous sibling of the current directory |NERDTree-C-K|' ,
		\'C       Change the tree root to the selected dir                 |NERDTree-C|' ,
		\'u       Move the tree root up one directory                      |NERDTree-u|' ,
		\'U       Same as ''u'' except the old root node is left open      |NERDTree-U|' ,
		\'r       Recursively refresh the current directory                |NERDTree-r|' ,
		\'R       Recursively refresh the current root                     |NERDTree-R|' ,
		\'m       Display the NERD tree menu                               |NERDTree-m|' ,
		\'cd      Change the CWD to the dir of the selected node           |NERDTree-cd|' ,
		\'CD      Change tree root to the CWD                              |NERDTree-CD|' ,
		\'I       Toggle whether hidden files displayed                    |NERDTree-I|' ,
		\'f       Toggle whether the file filters are used                 |NERDTree-f|' ,
		\'F       Toggle whether files are displayed                       |NERDTree-F|' ,
		\'B       Toggle whether the bookmark table is displayed           |NERDTree-B|' ,
		\'q       Close the NERDTree window                                |NERDTree-q|' ,
		\'A       Zoom (maximize/minimize) the NERDTree window             |NERDTree-A|' ,
		\'?       Toggle the display of the quick help                     |NERDTree-?|' ,
		\'<C-s>   Open selected file in a split window (same as i)         |NERDTree-?|' ,
		\'<C-v>   Open selected file in a new vsplit   (same as s)         |NERDTree-?|' ]
    call fzf#run({
		\'source': l:mappings,
		\'sink': function('ExecMapping'),
		\'right': '60%'
		\})
endfunction

function! Base16_ColoReferenceDONTRUNME()
	"great theme
	colo base16-tomorrow-night
	colo base16-monokai
	colo base16-railscasts
	colo base16-ondark
endfunction
"-----------------------------------------------------------------------------}}}
"AUTOCOMMANDS                                                                 {{{
"--------------------------------------------------------------------------------
"-----------------------------------------------------------------------------}}}
