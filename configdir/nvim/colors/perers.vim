" Vim colorscheme file
" Maintainer:   Per Erskjans aka perskjans

" This is my custom syntax file to override the defaults provided with Vim.
" This file should be located in $HOME/.vim/colors/ or $HOME/vimfiles/colors.

" This file should automatically be sourced by $RUNTIMEPATH.

" NOTE(S):
" *(1)
" This color scheme is created for 256 color terminals only. This may change
" in the future.
"
" *(2)
" The color definitions assumes and is intended for a black or dark background.

" *(3)
" This file is specifically in Unix style EOL format so that I can simply
" copy this file between Windows and Unix systems.  VIM can source files in
" with the UNIX EOL format (only <NL> instead of <CR><NR> for DOS) in any
" operating system if the 'fileformats' is not empty and there is no <CR>
" just before the <NL> on the first line.  See ':help :source_crnl' and
" ':help fileformats'.

"
" Support for 256-color terminal
"

hi clear
set t_Co=256
set background=dark
if exists("syntax_on")
  syntax reset
endif


hi Boolean          cterm=NONE    ctermfg=135     ctermbg=NONE   guifg=#af5fff   guibg=NONE
hi Character        cterm=NONE    ctermfg=5       ctermbg=NONE   guifg=#800080   guibg=NONE
hi ColorColumn      cterm=NONE    ctermfg=NONE    ctermbg=235    guifg=NONE      guibg=#262626
hi Comment          cterm=NONE    ctermfg=59      ctermbg=NONE   guifg=#5f5f5f   guibg=NONE
hi Conditional      cterm=NONE    ctermfg=20      ctermbg=NONE   guifg=#0000df   guibg=NONE
hi Constant         cterm=NONE    ctermfg=135     ctermbg=NONE   guifg=#af5fff   guibg=NONE
hi CursorColumn     cterm=NONE    ctermfg=NONE    ctermbg=234    guifg=NONE      guibg=#1c1c1c
hi Cursor           cterm=NONE    ctermfg=0       ctermbg=10     guifg=#000000   guibg=#00ff00
hi CursorLine       cterm=NONE    ctermfg=NONE    ctermbg=235    guifg=NONE      guibg=#262626
hi CursorLineNr     cterm=NONE    ctermfg=124     ctermbg=NONE   guifg=#af0000   guibg=NONE
hi Debug            cterm=NONE    ctermfg=225     ctermbg=NONE   guifg=#ff27ff   guibg=NONE
hi Define           cterm=NONE    ctermfg=13      ctermbg=NONE   guifg=#ff00ff   guibg=NONE
hi Delimiter        cterm=NONE    ctermfg=241     ctermbg=NONE   guifg=#606060   guibg=NONE
hi DiffAdd          cterm=NONE    ctermfg=NONE    ctermbg=22     guifg=NONE      guibg=#005f00
hi DiffChange       cterm=NONE    ctermfg=NONE    ctermbg=94     guifg=NONE      guibg=#875f00
hi DiffDelete       cterm=NONE    ctermfg=NONE    ctermbg=88     guifg=NONE      guibg=#870000
hi DiffText         cterm=NONE    ctermfg=NONE    ctermbg=102    guifg=NONE      guibg=#878787
hi Directory        cterm=NONE    ctermfg=6       ctermbg=NONE   guifg=#008080   guibg=NONE
hi Error            cterm=NONE    ctermfg=219     ctermbg=89     guifg=#ffafff   guibg=#87005f
hi Float            cterm=NONE    ctermfg=135     ctermbg=NONE   guifg=#af5fff   guibg=NONE
hi FoldColumn       cterm=NONE    ctermfg=67      ctermbg=0      guifg=#5f87af   guibg=#000000
hi Folded           cterm=NONE    ctermfg=67      ctermbg=0      guifg=#5f87af   guibg=#000000
hi Function         cterm=NONE    ctermfg=208     ctermbg=NONE   guifg=#ff8700   guibg=NONE
hi Identifier       cterm=NONE    ctermfg=208     ctermbg=NONE   guifg=#ff8700   guibg=NONE
hi Ignore           cterm=NONE    ctermfg=8       ctermbg=232    guifg=#808080   guibg=#080808
hi IncSearch        cterm=NONE    ctermfg=193     ctermbg=0      guifg=#d7ffaf   guibg=#000000
hi keyword          cterm=NONE    ctermfg=20      ctermbg=NONE   guifg=#0000df   guibg=NONE
hi Label            cterm=NONE    ctermfg=229     ctermbg=NONE   guifg=#ffffaf   guibg=NONE
hi LineNr           cterm=NONE    ctermfg=250     ctermbg=NONE   guifg=#bcbcbc   guibg=NONE
hi Macro            cterm=NONE    ctermfg=13      ctermbg=NONE   guifg=#ff00ff   guibg=NONE
hi MatchParen       cterm=NONE    ctermfg=0       ctermbg=198    guifg=#000000   guibg=#ff0087
hi ModeMsg          cterm=NONE    ctermfg=229     ctermbg=NONE   guifg=#ffffaf   guibg=NONE
hi MoreMsg          cterm=NONE    ctermfg=229     ctermbg=NONE   guifg=#ffffaf   guibg=NONE
hi NonText          cterm=NONE    ctermfg=59      ctermbg=NONE   guifg=#5f5f5f   guibg=NONE
hi Normal           cterm=NONE    ctermfg=130     ctermbg=0      guifg=#af5f00   guibg=#000000
hi Number           cterm=NONE    ctermfg=135     ctermbg=NONE   guifg=#af5fff   guibg=NONE
hi Operator         cterm=NONE    ctermfg=161     ctermbg=NONE   guifg=#d7005f   guibg=NONE
hi Pmenu            cterm=NONE    ctermfg=81      ctermbg=0      guifg=#5fd7ff   guibg=#000000
hi PmenuSbar        cterm=NONE    ctermfg=NONE    ctermbg=232    guifg=NONE      guibg=#080808
hi PmenuSel         cterm=NONE    ctermfg=255     ctermbg=242    guifg=#eeeeee   guibg=#666666
hi PmenuThumb       cterm=NONE    ctermfg=81      ctermbg=NONE   guifg=#5fd7ff   guibg=NONE
hi PreCondit        cterm=NONE    ctermfg=118     ctermbg=NONE   guifg=#87ff00   guibg=NONE
hi PreProc          cterm=NONE    ctermfg=89      ctermbg=NONE   guifg=#87005f   guibg=NONE
hi Question         cterm=NONE    ctermfg=81      ctermbg=NONE   guifg=#5fd7ff   guibg=NONE
hi Repeat           cterm=NONE    ctermfg=161     ctermbg=NONE   guifg=#d7005f   guibg=NONE
hi Search           cterm=NONE    ctermfg=0       ctermbg=222    guifg=#000000   guibg=#ffd787
hi SignColumn       cterm=NONE    ctermfg=118     ctermbg=235    guifg=#87ff00   guibg=#262626
hi SpecialChar      cterm=NONE    ctermfg=161     ctermbg=NONE   guifg=#d7005f   guibg=NONE
hi SpecialComment   cterm=NONE    ctermfg=245     ctermbg=NONE   guifg=#8a8a8a   guibg=NONE
hi Special          cterm=NONE    ctermfg=74      ctermbg=NONE   guifg=#5fafd7   guibg=NONE
hi Statement        cterm=NONE    ctermfg=3       ctermbg=NONE   guifg=#808000   guibg=NONE
hi SpecialKey       cterm=NONE    ctermfg=81      ctermbg=NONE   guifg=#5fd7ff   guibg=NONE
hi StorageClass     cterm=NONE    ctermfg=208     ctermbg=NONE   guifg=#ff8700   guibg=NONE
hi String           cterm=NONE    ctermfg=34      ctermbg=NONE   guifg=#00af00   guibg=NONE
hi Structure        cterm=NONE    ctermfg=63      ctermbg=NONE   guifg=#5f5fff   guibg=NONE
hi Tag              cterm=NONE    ctermfg=161     ctermbg=NONE   guifg=#d7005f   guibg=NONE
hi Title            cterm=NONE    ctermfg=190     ctermbg=NONE   guifg=#d7ff00   guibg=NONE
hi Todo             cterm=NONE    ctermfg=15      ctermbg=9      guifg=#ffffff   guibg=#ff0000
hi Type             cterm=NONE    ctermfg=2       ctermbg=NONE   guifg=#008000   guibg=NONE
hi Typedef          cterm=NONE    ctermfg=11      ctermbg=NONE   guifg=#ffff00   guibg=NONE
hi Underlined       cterm=NONE    ctermfg=8       ctermbg=NONE   guifg=#808080   guibg=NONE
hi WarningMsg       cterm=NONE    ctermfg=15      ctermbg=238    guifg=#ffffff   guibg=#444444
hi VertSplit        cterm=NONE    ctermfg=52      ctermbg=NONE   guifg=#5f0000   guibg=NONE
hi WildMenu         cterm=NONE    ctermfg=81      ctermbg=0      guifg=#5fd7ff   guibg=#000000
hi Visual           cterm=NONE    ctermfg=NONE    ctermbg=236    guifg=NONE      guibg=#303030
hi VisualNOS        cterm=NONE    ctermfg=NONE    ctermbg=236    guifg=NONE      guibg=#303030

if has("spell")
    hi SpellBad     cterm=NONE    ctermfg=NONE    ctermbg=52     guifg=NONE      guibg=#5f0000
    hi SpellCap     cterm=NONE    ctermfg=NONE    ctermbg=17     guifg=NONE      guibg=#00005f
    hi SpellLocal   cterm=NONE    ctermfg=NONE    ctermbg=17     guifg=NONE      guibg=#00005f
    hi SpellRare    cterm=NONE    ctermfg=NONE    ctermbg=NONE   guifg=NONE      guibg=NONE
endif

"hi link EndOfBuffer ColorColumn

" StatusLine related
    hi StatusLine       cterm=NONE    ctermfg=238     ctermbg=253    guifg=#444444   guibg=#dadada
    hi StatusLineNC     cterm=NONE    ctermfg=8       ctermbg=232    guifg=#808080   guibg=#080808

    highlight User1     cterm=None    ctermfg=NONE    ctermbg=52     guifg=NONE      guibg=#5f0000
    highlight User2     cterm=None    ctermfg=blue    ctermbg=red    guifg=blue      guibg=red
    highlight User3     cterm=None    ctermfg=green   ctermbg=blue   guifg=green     guibg=blue
    highlight User4     cterm=None    ctermfg=red     ctermbg=green  guifg=red       guibg=green
    highlight User5     cterm=None    ctermfg=blue    ctermbg=red    guifg=blue      guibg=red
    highlight User6     cterm=None    ctermfg=green   ctermbg=blue   guifg=green     guibg=blue
    highlight User7     cterm=None    ctermfg=red     ctermbg=green  guifg=red       guibg=green
    highlight User8     cterm=None    ctermfg=blue    ctermbg=red    guifg=blue      guibg=red
    highlight User9     cterm=None    ctermfg=green   ctermbg=blue   guifg=green     guibg=blue



