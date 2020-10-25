#!/bin/sh

cd $(git rev-parse --show-toplevel)

current_modules=$(git submodule status | sed 's|\s(.*$||; s|^.*/||')

    #'easymotion/vim-easymotion' \
    #'embear/vim-foldsearch' \
    #'guns/xterm-color-table.vim' \
    #'leafgarland/typescript-vim' \
    #'msanders/snipmate.vim' \
    #'neoclide/coc.nvim' \
    #'neovim/nvim-lspconfig' \
    #'pangloss/vim-javascript' \
    #'rhysd/vim-clang-format' \
    #'richsoni/vim-ecliptic' \
    #'tpope/vim-commentary' \
    #'tpope/vim-surround' \
    #'tpope/vim-vinegar' \
    #'vim-syntastic/syntastic' \
for repo in \
    'Dreiparrent/vim-json' \
    'airblade/vim-gitgutter' \
    'andviro/flake8-vim' \
    'frazrepo/vim-rainbow' \
    'lilydjwg/colorizer' \
    'mcchrish/nnn.vim' \
    'rrethy/vim-hexokinase' \
    'scrooloose/nerdtree' \
    'tpope/vim-fugitive' \
    'vim-airline/vim-airline' \
    'vim-scripts/AutoComplPop' \
    'xuyuanp/nerdtree-git-plugin' \
    'yggdroot/indentline'
do
    module=${repo#*/}
    if [ $(echo "$current_modules" | grep -c "^$module$") -eq 0 ]; then
        if [ $(echo "$repo" | grep -c "^http") -eq 0 ]; then
            repo="https://github.com/$repo"
        fi
        p_gitutils submoduleadd configdir/nvim/pack/plugins/opt $repo
        echo
    fi
done
