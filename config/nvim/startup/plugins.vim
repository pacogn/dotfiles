" Section Plugins {{{
"boo
call plug#begin('~/.config/nvim/plugged')
"Plug 'felixhummel/setcolors.vim'
" Plug 'scrooloose/syntastic' "allow for eslint checking
Plug 'henrik/vim-indexed-search' "Match 123 of 456 /search term/ in Vim searches
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim' " fuzzy file finder and so much more
Plug 'benekastah/neomake' " neovim replacement for syntastic using neovim's job control functonality
Plug 'dahu/vim-fanfingtastic' "improved f F t T commands
"david: not terribly usefull, but whatever
Plug 'gioele/vim-autoswap'
"session management
Plug 'tpope/vim-obsession'
"add git status for each modified line
Plug 'airblade/vim-gitgutter'
"in doubt if its worth the trouble, seems like it is though
"makes scrolling not jumpy!
Plug 'terryma/vim-smooth-scroll' 
"mapped sn to be a general find. makes navigation so much easier
Plug 'easymotion/vim-easymotion'
"this is an interesting plugin. take your time to learn it
"leader>
"       fe ==> end fold and return previous fold options
"       fs ==> fold to lines containing pattern
"       fd ==> show less lines around matching line
"       fi ==> show more lines around matching line
Plug 'embear/vim-foldsearch'
"this is actually addade with the nerdtree plugin !?
"Plug 'Xuyuanp/nerdtree-git-plugin'
"
"the following two are probably going to be deleted once we learn tmux
"Plug 'dhruvasagar/vim-prosession'
"tpope/vim-obsession
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" colorschemes
Plug 'chriskempson/base16-vim'
Plug 'NLKNguyen/papercolor-theme'
" Plug 'flazz/vim-colorschemes'
Plug 'dracula/vim'
" utilities
Plug 'ctrlpvim/ctrlp.vim' " fuzzy file finder, mapped to <leader>t
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'ryanoasis/vim-devicons' " file drawer
Plug 'mileszs/ack.vim' " search inside files using ack. Same as command line ack utility, but use :Ack
"david: disabled this plugin, is it worth somrthing?
Plug 'Raimondi/delimitMate' " automatic closing of quotes, parenthesis, brackets, etc.
"this is awesome!!!
Plug 'tpope/vim-commentary' " comment stuff out
Plug 'tpope/vim-unimpaired' " mappings which are simply short normal mode aliases for commonly used ex commands
" Plug 'tpope/vim-endwise' " automatically add end in ruby
Plug 'tpope/vim-ragtag' " endings for html, xml, etc. - ehances surround
Plug 'tpope/vim-surround' " mappings to easily delete, change and add such surroundings in pairs, such as quotes, parens, etc.
" Plug 'benmills/vimux' " tmux integration for vim
Plug 'vim-airline/vim-airline' " fancy statusline
Plug 'vim-airline/vim-airline-themes' " themes for vim-airline
" Plug 'scrooloose/syntastic' " syntax checking for vim
Plug 'benekastah/neomake' " neovim replacement for syntastic using neovim's job control functonality
Plug 'tpope/vim-fugitive' " amazing git wrapper for vim
Plug 'tpope/vim-repeat' " enables repeating other supported plugins with the . command
Plug 'garbas/vim-snipmate' " snippet manager
Plug 'editorconfig/editorconfig-vim' " .editorconfig support
Plug 'MarcWeber/vim-addon-mw-utils' " interpret a file by function and cache file automatically
Plug 'tomtom/tlib_vim' " utility functions for vim
Plug 'sotte/presenting.vim', { 'for': 'markdown' } " a simple tool for presenting slides in vim based on text files
Plug 'ervandew/supertab' " Perform all your vim insert mode completions with Tab
Plug 'tpope/vim-dispatch' " asynchronous build and test dispatcher
" Plug 'mtth/scratch.vim'
" Plug 'tpope/vim-vinegar'
" Plug 'tpope/vim-abolish'
Plug 'AndrewRadev/splitjoin.vim' " single/multi line code handler: gS - split one line into multiple, gJ - combine multiple lines into one
Plug 'vim-scripts/matchit.zip' " extended % matching
Plug 'tpope/vim-sleuth' " detect indent style (tabs vs. spaces)
Plug 'sickill/vim-pasta' " context-aware pasting
"Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } " distraction-free writing
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' } " focus tool. Good for presentating with vim

" language-specific plugins
Plug 'mattn/emmet-vim', { 'for': 'html' } " emmet support for vim - easily create markdup wth CSS-like syntax
" Plug 'gregsexton/MatchTag', { 'for': 'html' } " match tags in html, similar to paren support
Plug 'alvan/vim-closetag'
Plug 'othree/html5.vim', { 'for': 'html' } " html5 support
" Plug 'pangloss/vim-javascript', { 'for': 'javascript' } " JavaScript support
Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' } " JavaScript indent support
Plug 'moll/vim-node', { 'for': 'javascript' } " node support
" Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' } " JavaScript syntax plugin
Plug 'othree/yajs.vim', { 'for': 'javascript' } " JavaScript syntax plugin
" Plug 'mxw/vim-jsx', { 'for': 'jsx' } " JSX support
Plug 'elzr/vim-json', { 'for': 'json' } " JSON support
Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' } " ES6 and beyond syntax
" Plug 'Quramy/tsuquyomi', { 'for': 'typescript', 'do': 'npm install' } " extended typescript support - works as a client for TSServer
"Plug 'Shougo/vimproc.vim', { 'do': 'make' } " interactive command execution in vim
"Plug 'leafgarland/typescript-vim', { 'for': 'typescript' } " typescript support
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' } " sass scss syntax support
Plug 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] } " markdown support
" Plug 'groenewege/vim-less', { 'for': 'less' } " less support
Plug 'ap/vim-css-color', { 'for': ['css','stylus','scss'] } " set the background of hex color values to the color
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' } " CSS3 syntax support
Plug 'itspriddle/vim-marked', { 'for': 'markdown', 'on': 'MarkedOpen' } " Open markdown files in Marked.app - mapped to <leader>m

call plug#end()
