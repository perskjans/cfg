#!/bin/bash

cfgroot=$(dirname $(realpath $0))
editor=nvim
plugindir=$XDG_DATA_HOME/nvim/site/pack/plugins/start

if [[ "$1" != "" ]]; then
    editor=vim
    plugindir=$HOME/.vim/pack/plugins/start
fi

echo $editor
echo $plugindir

mkdir -p $plugindir
cd $plugindir

    #andviro/flake8-vim
    #easymotion/vim-easymotion
    #embear/vim-foldsearch
    #guns/xterm-color-table.vim
    #leafgarland/typescript-vim
    #msanders/snipmate.vim
    #neoclide/coc.nvim
    #neovim/nvim-lspconfig
    #pangloss/vim-javascript
    #preservim/tagbar
    #rhysd/vim-clang-format
    #richsoni/vim-ecliptic
    #tpope/vim-surround
    #tpope/vim-vinegar
    #rrethy/vim-hexokinase
    #vim-syntastic/syntastic

both=(
    alvan/vim-closetag
    davidhalter/jedi-vim
    dense-analysis/ale
    Dreiparrent/vim-json
    airblade/vim-gitgutter
    frazrepo/vim-rainbow
    junegunn/fzf
    junegunn/fzf.vim
    lepture/vim-jinja
    mcchrish/nnn.vim
    scrooloose/nerdtree
    tpope/vim-commentary
    tpope/vim-fugitive
    vim-airline/vim-airline
    vim-scripts/AutoComplPop
    xuyuanp/nerdtree-git-plugin
    yggdroot/indentline
)

nvim=(
    norcalli/nvim-colorizer.lua
)

vim=(
    lilydjwg/colorizer
)

function getrepo()
{
    name=${repo#*/}
    if [ $(echo "$repo" | grep -c "^http") -eq 0 ]; then
        repo="https://github.com/$repo"
    fi
    if [ ! -d $name ]; then
        p-gitutils clone "$repo --recursive"

        if [ $? ]; then
            cd "$name"
            [ -f [mM]akefile ] && make
            cd - >/dev/null
        fi
        echo
    fi
}

for repo in ${both[*]}
do
    getrepo "$repo"
done

if [[ $editor == nvim ]]; then
  for repo in ${nvim[*]}
  do
      getrepo "$repo"
  done
else
  for repo in ${vim[*]}
  do
      getrepo "$repo"
  done
fi
