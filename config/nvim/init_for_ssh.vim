call plug#begin('$DOTFILES/config/nvim/plugged')
Plug '/usr/local/opt/fzf' | Plug 'sudavid4/fzf.vim'                 " fuzzy file finder and so much more
Plug 'sudavid4/vim-unimpaired'                                      " mappings which are simply short normal mode aliases for commonly used ex commands
Plug 'yuttie/comfortable-motion.vim'                               " Brings physics-based smooth scrolling to the Vim world!
Plug 'tpope/vim-fugitive'                                           " amazing git wrapper for vim
Plug 'Shougo/deoplete.nvim'
call plug#end()
source $DOTFILES/config/nvim/startup/hzf.vim
source $DOTFILES/config/nvim/startup/abbrev.vim
source $DOTFILES/config/nvim/startup/windowStuff.vim
source $DOTFILES/config/nvim/startup/comfortable_motion.vim
nmap <space>bl :Lines<cr>
let base16colorspace=256  " Access colors present in 256 colorspace"
set termguicolors
colorscheme base16-chalk
set ignorecase            " case insensitive searching
set smartcase             " case-sensitive if expresson contains a capital letter

let mapleader = ','
let g:mapleader = ','
nmap 1n :execute 'e '.getcwd()<cr>
nmap - :execute 'e '.getcwd()<cr>
source $DOTFILES/config/nvim/startup/fugitive.vim
"end diff --- clean close diff window
nmap <space>ed <C-w><C-j><C-w><C-l><C-w><C-o>
