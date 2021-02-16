#!/bin/bash

cfgroot=$(dirname $(realpath $0))
cd $cfgroot/configdir/nvim/pack/plugins/start

repos=(
    #easymotion/vim-easymotion
    #embear/vim-foldsearch
    #guns/xterm-color-table.vim
    #leafgarland/typescript-vim
    #msanders/snipmate.vim
    #neoclide/coc.nvim
    #neovim/nvim-lspconfig
    #pangloss/vim-javascript
    #rhysd/vim-clang-format
    #richsoni/vim-ecliptic
    #tpope/vim-commentary
    #tpope/vim-surround
    #tpope/vim-vinegar
    #vim-syntastic/syntastic
    dense-analysis/ale
    Dreiparrent/vim-json
    airblade/vim-gitgutter
    #andviro/flake8-vim
    frazrepo/vim-rainbow
    junegunn/fzf
    junegunn/fzf.vim
    #lilydjwg/colorizer
    mcchrish/nnn.vim
    rrethy/vim-hexokinase
    scrooloose/nerdtree
    tpope/vim-fugitive
    vim-airline/vim-airline
    vim-scripts/AutoComplPop
    xuyuanp/nerdtree-git-plugin
    yggdroot/indentline
)

for repo in ${repos[*]}
do
    name=${repo#*/}
    if [ $(echo "$repo" | grep -c "^http") -eq 0 ]; then
        repo="https://github.com/$repo"
    fi
    if [ ! -d $name ]; then
        p_gitutils clone "$repo --recursive"

        if [ $? ]; then
            cd "$name"
            [ -f [mM]akefile ] && make
            cd - >/dev/null
        fi
        echo
    fi
done
