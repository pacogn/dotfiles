call plug#begin('~/.config/nvim/plugged')
" Plug 'felixhummel/setcolors.vim'
" Plug 'scrooloose/syntastic' "allow for eslint checking
Plug 'sudavid4/Buffet.vim'                                  " easy visually delete buffers ( and other buffer stuff that I'll probably have no use for
Plug 'vim-scripts/YankRing.vim'                             "Maintains a history of previous yanks, changes and deletes
Plug 'sbdchd/neoformat', { 'for':                           
            \['javascript', 'css', 'scss', 
            \'sh', 'zsh', 'vim', 'html'] , 
            \'do': 'npm -g install js-beautify'}            " A (Neo)vim plugin for formatting code. - you will need jsbeautifier globally installed
Plug 'junegunn/vim-xmark' , { 'do': 'make' }                " ❌ Markdown preview on OS X
Plug 'junegunn/vim-easy-align'                              " A Vim alignment plugin
" Plug 'junegunn/vim-slash'                                   " Enhancing in-buffer search experience
Plug 'airblade/vim-rooter'                                  " cd into root of project
Plug 'kshenoy/vim-signature'                                " help for working with marks
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}         " markdown 
Plug 'godlygeek/tabular'                                    " related to vim-markdown
" Plug 'junegunn/vim-peekaboo'                                " show registers on " and @
Plug 'powerman/vim-plugin-AnsiEsc'                          " type :AnsiEsc to get colors as terminal 
Plug 'blueyed/vim-diminactive'                              " allow different background for buffer without focus on split window 
Plug 'sudavid4/tern_for_vim', {                             
            \'for': 'javascript',
            \'do': 'npm i' }                                " intellijent navigation and refactor for javascript 
" Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
" Plug 'majutsushi/tagbar'
if(has('nvim'))
    Plug 'Shougo/deoplete.nvim', 
                \{ 'for': ['javascript', 'css', 'scss', 'sh', 'zsh', 'vim', 'html'] }
    Plug 'carlitux/deoplete-ternjs', 
                \{ 'for': 'javascript'}
else
    Plug 'Shougo/neocomplete.vim', 
                \{ 'for': ['javascript', 'css', 'scss', 'sh', 'vim', 'html'] }
endif
" Plug 'xolox/vim-easytags'
" Plug 'xolox/vim-misc'
Plug 'Konfekt/FastFold'                                     " fold zyntax is too heavy for vim, makes neocomplete very slow. this plugin solves it
Plug 'henrik/vim-indexed-search'                            " Match 123 of 456 /search term/ in Vim searches
Plug '/usr/local/opt/fzf' | Plug 'sudavid4/fzf.vim'         " fuzzy file finder and so much more
Plug 'benjie/neomake-local-eslint.vim', 
            \{ 'for': 'javascript' }                        " let neomake know how to find local eslint
Plug 'benekastah/neomake', 
            \{ 'for': 'javascript' }                        " neovim replacement for syntastic using neovim's job control functonality
Plug 'dahu/vim-fanfingtastic'                               " improved f F t T commands
" Plug 'gioele/vim-autoswap'                                " we have a `set noswapfile` in options so... no need for this 
Plug 'tpope/vim-obsession'                                  " session management
Plug 'airblade/vim-gitgutter'                               " add git status for each modified line
" in doubt if its worth the trouble, seems like it is though
Plug 'terryma/vim-smooth-scroll'                            " makes scrolling not jumpy!
Plug 'easymotion/vim-easymotion'
Plug 'embear/vim-foldsearch'                                " fold based on searched keyword
" this is actually addade with the nerdtree plugin !?
" Plug 'Xuyuanp/nerdtree-git-plugin'
" the following two are probably going to be deleted once we learn tmux
" Plug 'dhruvasagar/vim-prosession'
" tpope/vim-obsession
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" colorschemes
Plug '$HOME/.dotfiles/forkedProjects/base16-vim'
" Plug 'sudavid4/base16-vim'
Plug 'NLKNguyen/papercolor-theme'
" Plug 'flazz/vim-colorschemes'
" Plug 'dracula/vim'
" utilities
Plug 'scrooloose/nerdtree', 
            \{ 'on': ['NERDTreeToggle', 'NERDTreeFind'] } |
            \Plug 'Xuyuanp/nerdtree-git-plugin'           |
            \Plug 'ryanoasis/vim-devicons'                  " file drawer
" Plug 'mileszs/ack.vim'                                      " search inside files using ack. Same as command line ack utility, but use :Ack
" david: disabled this plugin, is it worth somrthing?
" Plug 'Raimondi/delimitMate'                                 " automatic closing of quotes, parenthesis, brackets, etc.
                                                            " this is awesome!!!
Plug 'tpope/vim-commentary'                                 " comment stuff out
Plug 'sudavid4/vim-unimpaired'                                 " mappings which are simply short normal mode aliases for commonly used ex commands
" Plug 'tpope/vim-endwise' " automatically add end in ruby
Plug 'tpope/vim-ragtag'                                     " endings for html, xml, etc. - ehances surround
Plug 'tpope/vim-surround'                                   " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
" Plug 'benmills/vimux' " tmux integration for vim
Plug 'vim-airline/vim-airline'                              " fancy statusline
Plug 'sudavid4/vim-airline-themes'                          " themes for vim-airline
" Plug 'vim-airline/vim-airline-themes' " themes for vim-airline
" Plug 'scrooloose/syntastic' " syntax checking for vim
Plug 'tpope/vim-fugitive'                                   " amazing git wrapper for vim
Plug 'tpope/vim-repeat'                                     " enables repeating other supported plugins with the . command
Plug 'garbas/vim-snipmate'                                  " snippet manager
Plug 'editorconfig/editorconfig-vim'                        " .editorconfig support


"todo do we use these following two plugins at all??------------------------------------------------------------
" Plug 'tomtom/tlib_vim'                                      " utility functions for vim
"end todo-------------------------------------------------------------------------------------------------------


" Plug 'sotte/presenting.vim', { 'for': 'markdown' } " a simple tool for presenting slides in vim based on text files
" Plug 'ervandew/supertab' " Perform all your vim insert mode completions with Tab
Plug 'tpope/vim-dispatch'                                   " asynchronous build and test dispatcher
" Plug 'mtth/scratch.vim'
" Plug 'tpope/vim-vinegar'
" Plug 'tpope/vim-abolish'
Plug 'AndrewRadev/splitjoin.vim'                            " single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
Plug 'vim-scripts/matchit.zip'                              " extended % matching
Plug 'tpope/vim-sleuth'                                     " detect indent style (tabs vs. spaces)
Plug 'sickill/vim-pasta'                                    " context-aware pasting
                                                            " Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } " distraction-free writing
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }        " focus tool. Good for presentating with vim

                                                            " language-specific plugins
Plug 'mattn/emmet-vim', { 'for': 'html' }                   " emmet support for vim - easily create markdup wth CSS-like syntax
                                                            " Plug 'gregsexton/MatchTag', { 'for': 'html' } " match tags in html, similar to paren support
Plug 'alvan/vim-closetag'
Plug 'othree/html5.vim', { 'for': 'html' }                  " html5 support
                                                            " Plug 'pangloss/vim-javascript', { 'for': 'javascript' } " JavaScript support
Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' }     " JavaScript indent support
Plug 'moll/vim-node', { 'for': 'javascript' }               " node support
" Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' } " JavaScript syntax plugin
Plug 'othree/yajs.vim', { 'for': 'javascript' }             " JavaScript syntax plugin
" Plug 'mxw/vim-jsx', { 'for': 'jsx' } " JSX support
Plug 'elzr/vim-json', { 'for': 'json' }                     " JSON support
Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' }   " ES6 and beyond syntax
" Plug 'Quramy/tsuquyomi', { 'for': 'typescript', 'do': 'npm install' } " extended typescript support - works as a client for TSServer
" Plug 'Shougo/vimproc.vim', { 'do': 'make' } " interactive command execution in vim
" Plug 'leafgarland/typescript-vim', { 'for': 'typescript' } " typescript support
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }         " sass scss syntax support
Plug 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] } " markdown support
" Plug 'groenewege/vim-less', { 'for': 'less' } " less support
Plug 'ap/vim-css-color', { 'for': ['css','stylus','scss'] } " set the background of hex color values to the color
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }             " CSS3 syntax support
" Plug 'itspriddle/vim-marked', 
"             \{ 'for': 'markdown', 'on': 'MarkedOpen' }      " Open markdown files in Marked.app - mapped to <leader>m
                                                            " :TableModeToggle
Plug 'dhruvasagar/vim-table-mode'


call plug#end()
