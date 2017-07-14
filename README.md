# DOTFILES

- how to setup computer for using this dotfiles

1. install homebrew
2. install a better version of zsh: `brew install zsh`
3. make better zsh version your custom shell: 

    ```
    Go to the Users & Groups pane of the System Preferences 

    -> Select the User -> Click the lock to make changes (bottom left corner) 

    -> right click the current user select Advanced options... 

    -> Select the Login Shell: /usr/local/Cellar/zsh/5.3.1_1/bin/zsh and OK
    ```

    or wherever is your better version of zsh installed
4. install [zgen](https://github.com/tarjoilija/zgen): `git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"`
5. install [fzf](https://github.com/junegunn/fzf): `brew install fzf && /usr/local/opt/fzf/install`
6. install nvm using homebrew: `brew install nvm`
7. install [the-silver-searcher aka ag](https://github.com/ggreer/the_silver_searcher): `brew install the_silver_searcher`
8. symlink all `.symlink` files to your home folder `ln -s PATH_TO_SOURCE_FILE.symlink ~/.FILE_NAME`
9. apply macos defaults: `sh ~/.dotfiles/macos/defaults`
10. install rouge (I'll go ahead and suggest sudoing this, there must be a better way though): `sudo gem install rouge` 
11. install [karabiner-elements](https://github.com/tekezo/Karabiner-Elements/blob/master/usage/README.md)
12. install mysql for mru ( most recently used - vim plugin ): `brew install mysql`


- to push to github (https with two factor authentication) you will need to use a token instead of your password. [Instructions here](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/)

## README todo

------------------------------

- powerfonts for nerdtree
- change rouge to output with base16 

