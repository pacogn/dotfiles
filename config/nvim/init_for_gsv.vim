source $HOME/.config/nvim/init_for_man.vim
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-fugitive'                                           " amazing git wrapper for vim
call plug#end()
source $HOME/.dotfiles/config/nvim/startup/fugitive.vim
