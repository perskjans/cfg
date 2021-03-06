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

"    0 #000000    1 #800000    2 #008000    3 #808000    4 #000080    5 #800080    6 #008080    7 #c0c0c0
"    8 #808080    9 #ff0000   10 #00ff00   11 #ffff00   12 #0000ff   13 #ff00ff   14 #00ffff   15 #ffffff
"
"   16 #000000   17 #00005f   18 #000087   19 #0000af   20 #0000df   21 #0000ff
"   22 #005f00   23 #005f5f   24 #005f87   25 #005faf   26 #005fdf   27 #005fff
"   28 #008700   29 #00875f   30 #008787   31 #0087af   32 #0087df   33 #0087ff
"   34 #00af00   35 #00af5f   36 #00af87   37 #00afaf   38 #00afdf   39 #00afff
"   40 #00df00   41 #00df5f   42 #00df87   43 #00dfaf   44 #00dfdf   45 #00dfff
"   46 #00ff00   47 #00ff5f   48 #00ff87   49 #00ffaf   50 #00ffdf   51 #00ffff
"   52 #5f0000   53 #5f005f   54 #5f0087   55 #5f00af   56 #5f00df   57 #5f00ff
"   58 #5f5f00   59 #5f5f5f   60 #5f5f87   61 #5f5faf   62 #5f5fdf   63 #5f5fff
"   64 #5f8700   65 #5f875f   66 #5f8787   67 #5f87af   68 #5f87df   69 #5f87ff
"   70 #5faf00   71 #5faf5f   72 #5faf87   73 #5fafaf   74 #5fafdf   75 #5fafff
"   76 #5fdf00   77 #5fdf5f   78 #5fdf87   79 #5fdfaf   80 #5fdfdf   81 #5fdfff
"   82 #5fff00   83 #5fff5f   84 #5fff87   85 #5fffaf   86 #5fffdf   87 #5fffff
"   88 #870000   89 #87005f   90 #870087   91 #8700af   92 #8700df   93 #8700ff
"   94 #875f00   95 #875f5f   96 #875f87   97 #875faf   98 #875fdf   99 #875fff
"  100 #878700  101 #87875f  102 #878787  103 #8787af  104 #8787df  105 #8787ff
"  106 #87af00  107 #87af5f  108 #87af87  109 #87afaf  110 #87afdf  111 #87afff
"  112 #87df00  113 #87df5f  114 #87df87  115 #87dfaf  116 #87dfdf  117 #87dfff
"  118 #87ff00  119 #87ff5f  120 #87ff87  121 #87ffaf  122 #87ffdf  123 #87ffff
"  124 #af0000  125 #af005f  126 #af0087  127 #af00af  128 #af00df  129 #af00ff
"  130 #af5f00  131 #af5f5f  132 #af5f87  133 #af5faf  134 #af5fdf  135 #af5fff
"  136 #af8700  137 #af875f  138 #af8787  139 #af87af  140 #af87df  141 #af87ff
"  142 #afaf00  143 #afaf5f  144 #afaf87  145 #afafaf  146 #afafdf  147 #afafff
"  148 #afdf00  149 #afdf5f  150 #afdf87  151 #afdfaf  152 #afdfdf  153 #afdfff
"  154 #afff00  155 #afff5f  156 #afff87  157 #afffaf  158 #afffdf  159 #afffff
"  160 #df0000  161 #df005f  162 #df0087  163 #df00af  164 #df00df  165 #df00ff
"  166 #df5f00  167 #df5f5f  168 #df5f87  169 #df5faf  170 #df5fdf  171 #df5fff
"  172 #df8700  173 #df875f  174 #df8787  175 #df87af  176 #df87df  177 #df87ff
"  178 #dfaf00  179 #dfaf5f  180 #dfaf87  181 #dfafaf  182 #dfafdf  183 #dfafff
"  184 #dfdf00  185 #dfdf5f  186 #dfdf87  187 #dfdfaf  188 #dfdfdf  189 #dfdfff
"  190 #dfff00  191 #dfff5f  192 #dfff87  193 #dfffaf  194 #dfffdf  195 #dfffff
"  196 #ff0000  197 #ff005f  198 #ff0087  199 #ff00af  200 #ff00df  201 #ff00ff
"  202 #ff5f00  203 #ff5f5f  204 #ff5f87  205 #ff5faf  206 #ff5fdf  207 #ff5fff
"  208 #ff8700  209 #ff875f  210 #ff8787  211 #ff87af  212 #ff87df  213 #ff87ff
"  214 #ffaf00  215 #ffaf5f  216 #ffaf87  217 #ffafaf  218 #ffafdf  219 #ffafff
"  220 #ffdf00  221 #ffdf5f  222 #ffdf87  223 #ffdfaf  224 #ffdfdf  225 #ffdfff
"  226 #ffff00  227 #ffff5f  228 #ffff87  229 #ffffaf  230 #ffffdf  231 #ffffff
"
"  232 #080808  233 #121212  234 #1c1c1c  235 #262626  236 #303030  237 #3a3a3a
"  238 #444444  239 #4e4e4e  240 #585858  241 #606060  242 #666666  243 #767676
"  244 #808080  245 #8a8a8a  246 #949494  247 #9e9e9e  248 #a8a8a8  249 #b2b2b2
"  250 #bcbcbc  251 #c6c6c6  252 #d0d0d0  253 #dadada  254 #e4e4e4  255 #eeeeee

"hi clear
set t_Co=256
set background=dark
if exists("syntax_on")
  syntax reset
endif

hi Boolean          cterm=NONE    ctermfg=135     ctermbg=NONE   guifg=#af5fff   guibg=NONE
hi Character        cterm=NONE    ctermfg=90      ctermbg=NONE   guifg=#870087   guibg=NONE
hi ColorColumn      cterm=NONE    ctermfg=NONE    ctermbg=233    guifg=NONE      guibg=#121212
hi Comment          cterm=NONE    ctermfg=59      ctermbg=NONE   guifg=#5f5f5f   guibg=NONE
hi Conditional      cterm=NONE    ctermfg=20      ctermbg=NONE   guifg=#0000df   guibg=NONE
hi Constant         cterm=NONE    ctermfg=135     ctermbg=NONE   guifg=#af5fff   guibg=NONE
hi CursorColumn     cterm=NONE    ctermfg=NONE    ctermbg=233    guifg=NONE      guibg=#262626
hi Cursor           cterm=NONE    ctermfg=16      ctermbg=46     guifg=#000000   guibg=#00ff00
hi CursorLine       cterm=NONE    ctermfg=NONE    ctermbg=235    guifg=NONE      guibg=#262626
hi CursorLineNr     cterm=NONE    ctermfg=124     ctermbg=NONE   guifg=#af0000   guibg=NONE
hi Debug            cterm=NONE    ctermfg=225     ctermbg=NONE   guifg=#ff27ff   guibg=NONE
hi Define           cterm=NONE    ctermfg=21      ctermbg=NONE   guifg=#ff00ff   guibg=NONE
hi Delimiter        cterm=NONE    ctermfg=241     ctermbg=NONE   guifg=#606060   guibg=NONE
hi DiffAdd          cterm=NONE    ctermfg=NONE    ctermbg=22     guifg=#000000   guibg=#005f00
hi DiffChange       cterm=NONE    ctermfg=NONE    ctermbg=94     guifg=#000000   guibg=#875f00
hi DiffDelete       cterm=NONE    ctermfg=NONE    ctermbg=88     guifg=#000000   guibg=#870000
hi DiffText         cterm=NONE    ctermfg=NONE    ctermbg=102    guifg=#000000   guibg=#878787
hi Directory        cterm=NONE    ctermfg=30      ctermbg=NONE   guifg=#008080   guibg=NONE
hi Error            cterm=NONE    ctermfg=219     ctermbg=89     guifg=#ffafff   guibg=#87005f
hi Float            cterm=NONE    ctermfg=135     ctermbg=NONE   guifg=#af5fff   guibg=NONE
hi FoldColumn       cterm=NONE    ctermfg=67      ctermbg=16     guifg=#5f87af   guibg=#000000
hi Folded           cterm=NONE    ctermfg=67      ctermbg=16     guifg=#5f87af   guibg=#000000
hi Function         cterm=NONE    ctermfg=208     ctermbg=NONE   guifg=#ff8700   guibg=NONE
hi Identifier       cterm=NONE    ctermfg=208     ctermbg=NONE   guifg=#ff8700   guibg=NONE
hi Ignore           cterm=NONE    ctermfg=244     ctermbg=232    guifg=#808080   guibg=#080808
hi IncSearch        cterm=NONE    ctermfg=16      ctermbg=193    guifg=#d7ffaf   guibg=#000000
hi keyword          cterm=NONE    ctermfg=20      ctermbg=NONE   guifg=#0000df   guibg=NONE
hi Label            cterm=NONE    ctermfg=229     ctermbg=NONE   guifg=#ffffaf   guibg=NONE
hi LineNr           cterm=NONE    ctermfg=250     ctermbg=NONE   guifg=#bcbcbc   guibg=NONE
hi Macro            cterm=NONE    ctermfg=21      ctermbg=NONE   guifg=#ff00ff   guibg=NONE
hi MatchParen       cterm=NONE    ctermfg=16      ctermbg=91     guifg=#000000   guibg=#8700af
hi ModeMsg          cterm=NONE    ctermfg=229     ctermbg=NONE   guifg=#ffffaf   guibg=NONE
hi MoreMsg          cterm=NONE    ctermfg=229     ctermbg=NONE   guifg=#ffffaf   guibg=NONE
hi NonText          cterm=NONE    ctermfg=59      ctermbg=NONE   guifg=#005f87   guibg=NONE
hi Normal           cterm=NONE    ctermfg=130     ctermbg=16     guifg=#af5f00   guibg=#000000
hi Number           cterm=NONE    ctermfg=135     ctermbg=NONE   guifg=#af5fff   guibg=NONE
hi Operator         cterm=NONE    ctermfg=161     ctermbg=NONE   guifg=#d7005f   guibg=NONE
hi Pmenu            cterm=NONE    ctermfg=81      ctermbg=16     guifg=#5fd7ff   guibg=#000000
hi PmenuSbar        cterm=NONE    ctermfg=NONE    ctermbg=232    guifg=NONE      guibg=#080808
hi PmenuSel         cterm=NONE    ctermfg=255     ctermbg=242    guifg=#eeeeee   guibg=#666666
hi PmenuThumb       cterm=NONE    ctermfg=81      ctermbg=NONE   guifg=#5fd7ff   guibg=NONE
hi PreCondit        cterm=NONE    ctermfg=118     ctermbg=NONE   guifg=#87ff00   guibg=NONE
hi PreProc          cterm=NONE    ctermfg=89      ctermbg=NONE   guifg=#87005f   guibg=NONE
hi Question         cterm=NONE    ctermfg=81      ctermbg=NONE   guifg=#5fd7ff   guibg=NONE
hi Repeat           cterm=NONE    ctermfg=161     ctermbg=NONE   guifg=#d7005f   guibg=NONE
hi Search           cterm=NONE    ctermfg=16      ctermbg=193    guifg=#000000   guibg=#d7ffaf
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
hi Todo             cterm=NONE    ctermfg=255     ctermbg=196    guifg=#eeeeee   guibg=#ff0000
hi Type             cterm=NONE    ctermfg=28      ctermbg=NONE   guifg=#005f00   guibg=NONE
hi Typedef          cterm=NONE    ctermfg=226     ctermbg=NONE   guifg=#ffff00   guibg=NONE
hi Underlined       cterm=NONE    ctermfg=244     ctermbg=NONE   guifg=#808080   guibg=NONE
hi WarningMsg       cterm=NONE    ctermfg=255     ctermbg=238    guifg=#eeeeee   guibg=#444444
hi VertSplit        cterm=NONE    ctermfg=52      ctermbg=NONE   guifg=#5f0000   guibg=NONE
hi WildMenu         cterm=NONE    ctermfg=81      ctermbg=16     guifg=#5fd7ff   guibg=#000000
hi Visual           cterm=NONE    ctermfg=NONE    ctermbg=236    guifg=NONE      guibg=#303030
hi VisualNOS        cterm=NONE    ctermfg=NONE    ctermbg=236    guifg=NONE      guibg=#303030

if has("spell")
    hi SpellBad     cterm=NONE    ctermfg=NONE    ctermbg=52     guifg=NONE      guibg=#5f0000
    hi SpellCap     cterm=NONE    ctermfg=NONE    ctermbg=17     guifg=NONE      guibg=#00005f
    hi SpellLocal   cterm=NONE    ctermfg=NONE    ctermbg=17     guifg=NONE      guibg=#00005f
    hi SpellRare    cterm=NONE    ctermfg=NONE    ctermbg=NONE   guifg=NONE      guibg=NONE
endif

"hi link EndOfBuffer ColorColumn

"" StatusLine related
"    hi StatusLine       cterm=NONE    ctermfg=238     ctermbg=253    guifg=#444444   guibg=#dadada
"    hi StatusLineNC     cterm=NONE    ctermfg=244     ctermbg=232    guifg=#808080   guibg=#080808
"
"    highlight User1     cterm=None    ctermfg=NONE    ctermbg=52     guifg=NONE      guibg=#5f0000
"    highlight User2     cterm=None    ctermfg=blue    ctermbg=red    guifg=blue      guibg=red
"    highlight User3     cterm=None    ctermfg=green   ctermbg=blue   guifg=green     guibg=blue
"    highlight User4     cterm=None    ctermfg=red     ctermbg=green  guifg=red       guibg=green
"    highlight User5     cterm=None    ctermfg=blue    ctermbg=red    guifg=blue      guibg=red
"    highlight User6     cterm=None    ctermfg=green   ctermbg=blue   guifg=green     guibg=blue
"    highlight User7     cterm=None    ctermfg=red     ctermbg=green  guifg=red       guibg=green
"    highlight User8     cterm=None    ctermfg=blue    ctermbg=red    guifg=blue      guibg=red
"    highlight User9     cterm=None    ctermfg=green   ctermbg=blue   guifg=green     guibg=blue
