" //todo: how to automatic open fold when jumping into it?
" vim: foldmethod=marker
autocmd!
" Load startup files{{{1--------------------------------------------------------------------------------------------------
function! SourceMyScripts()
    source $DOTFILES/config/nvim/startup/plugins.vim
    if !isdirectory($DOTFILES.'/config/nvim/plugged')
        PlugInstall
    endif
    let file_list = split(globpath("$DOTFILES/config/nvim/startup/", "*.vim"), '\n')

    for file in file_list
        if file !~ "Session.vim" && file !~ "plugins.vim"
            " echom file
            execute( 'source '.file )
        endif
    endfor
endfunction

call SourceMyScripts()
function! DeferGstatus(...)
    if(a:0 == 0)
        call timer_start(3, 'DeferGstatus', {'repeat':1})
    else
        Gstatus
    endif
endfunction
"}}}----------------------------------------------------------------------------------------------------------------------

" source $DOTFILES/config/nvim/startup/plugins.vim
" source $DOTFILES/config/nvim/startup/NERDTree.vim
" source $DOTFILES/config/nvim/startup/abbrev.vim
" source $DOTFILES/config/nvim/startup/airline.vim
" source $DOTFILES/config/nvim/startup/custom_fold.vim
" source $DOTFILES/config/nvim/startup/deoplete.vim
" source $DOTFILES/config/nvim/startup/foldsearch.vim
" source $DOTFILES/config/nvim/startup/gitstatus.vim
" source $DOTFILES/config/nvim/startup/javascript.vim
" source $DOTFILES/config/nvim/startup/leader_mappings.vim
" source $DOTFILES/config/nvim/startup/limelight.vim
" source $DOTFILES/config/nvim/startup/misc.vim
" source $DOTFILES/config/nvim/startup/options.vim
" source $DOTFILES/config/nvim/startup/syntastic_config.vim
" source $DOTFILES/config/nvim/startup/tab_titles.vim
" source $DOTFILES/config/nvim/startup/tabname.vim
" source $DOTFILES/config/nvim/startup/terminal_settings.vim
" source $DOTFILES/config/nvim/startup/tmp_stuff.vim
" source $DOTFILES/config/nvim/startup/windowStuff.vim

" source $DOTFILES/config/nvim/startup/fzf.vim
" source $DOTFILES/config/nvim/startup/vimwiki.vim

hi Normal guibg=NONE ctermbg=NONE
