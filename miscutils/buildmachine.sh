#!/bin/bash
function beforeStart(){
    su root
    chown builduser /home/builduser/.yarnrc
    chgrp builduser /home/builduser/.yarnrc
    su builduser
}

function prepVim(){
    [[ -d /tmp/dotfiles ]] && rm -rf /tmp/dotfiles
    git clone --depth 1 git@github.com:sudavid4/dotfiles.git /tmp/dotfiles
    export DOTFILES='/tmp/dotfiles'
    curl -fLo $DOTFILES/config/nvim/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    alias vim='vim -u $DOTFILES/config/nvim/init_for_ssh.vim'
}

function cloneRepo(){
    cd /tmp
    export REPO=editor-plugins
    if [[ ! -d /tmp/$REPO ]]; then
        git clone --depth 1 --no-single-branch git@github.com:wix-private/$REPO.git
    fi
    cd /tmp/"$REPO"
    export BUILD_VCS_NUMBER=$(git show-ref HEAD -s)
    export IS_BUILD_AGENT=true
}
function deleteRepo(){
    cd /tmp
    rm -rf $REPO
}
function runBuild(){
    /opt/bin/npmBuild.sh
}

beforeStart
cloneRepo
prepVim
runBuild
