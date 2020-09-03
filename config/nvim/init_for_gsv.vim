call plug#begin('~/.config/nvim/plugged')
Plug '/usr/local/opt/fzf' | Plug 'sudavid4/fzf.vim'                 " fuzzy file finder and so much more
Plug 'sudavid4/base16-vim'
Plug 'sudavid4/vim-unimpaired'                                      " mappings which are simply short normal mode aliases for commonly used ex commands
Plug 'yuttie/comfortable-motion.vim'                               " Brings physics-based smooth scrolling to the Vim world!
Plug 'tpope/vim-fugitive'                                           " amazing git wrapper for vim
Plug 'Shougo/deoplete.nvim'
call plug#end()
source $HOME/.config/nvim/startup/hzf.vim
source $HOME/.config/nvim/startup/abbrev.vim
source $HOME/.config/nvim/startup/windowStuff.vim
source $HOME/.config/nvim/startup/comfortable_motion.vim
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
source $HOME/.dotfiles/config/nvim/startup/fugitive.vim
"noremap s :source $HOME/.dotfiles/config/nvim/init.vim<cr>:unmap s<cr>
"end diff --- clean close diff window
nmap <space>ed <C-w><C-j><C-w><C-l><C-w><C-o>
map <space>ev :source ~/.dotfiles/config/nvim/init.vim<cr> 
