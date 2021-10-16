scriptencoding utf-8

if !has('nvim')
    echo "This config is only for nvim"
    exit
endif


if !exists('SCRATCHFILE')
    let $SCRATCHFILE = $XDG_CACHE_HOME . "/nvim/scratch.txt"     " Scratchfile for tmp usage
endif

let g:tty = $TTY
let g:myplugindir = $XDG_DATA_HOME . "/nvim/site/pack/plugins/start/"
let g:myplugins = systemlist('ls ' . g:myplugindir)


" SETTINGS ===
    " Settings are ordered as in :options exept for 0 that is my own grouping.

    " 0 backup, view, undo, swap

        if exists('$SUDO_USER')        " don't create root-owned files
            set nobackup
            set nowritebackup
            set shada=
            set shadafile=NONE
            set noundofile
            set noswapfile
        else
            set backupdir=$XDG_DATA_HOME/nvim/backup/,.
            set backupskip=/tmp/*,/private/tmp/*"
            set undofile
            set swapfile
        endif

    " 1 important
        "pastetoggle    key sequence to toggle paste mode
            set pt=<F11>   " key sequence to toggle paste mode

    " 2 moving around, searching and patterns
        "whichwrap      list of flags specifying which commands wrap to another line (local to window)
            set ww=b,s,<,>,[,],~         " allow <BS>/<Space>/<Left>/<Right>, ~ to cross line boundaries (local to window)
        "startofline    many jump commands move the cursor to the first non-blank character of a line
            set nosol
        "path   list of directory names used for file searching (global or local to buffer)
            set pa^=.,**
        "autochdir  change to directory of file in buffer
            set noacd
        "wrapscan   search commands wrap around the end of the buffer
            set ws
        "incsearch	show match for partly typed search command
            set is
        "magic	change the way backslashes are used in search patterns
            set magic
        "regexpengine	select the default regexp engine used
        "   set re=0
        "ignorecase	ignore case when using a search pattern
            set ic
        "smartcase	override 'ignorecase' when pattern has upper case characters
            set scs

    " 4 displaying text
        "scrolloff	number of screen lines to show around the cursor
            set so=8
        "wrap	long lines wrap (local to window)
            set nowrap
        "linebreak	wrap long lines at a character in 'breakat' (local to window)
            set lbr
        "breakindent	preserve indentation in wrapped text (local to window)
        "   set nobri	bri
        "showbreak	string to put before wrapped screen lines
            let &showbreak=' ¬ '
        "sidescrolloff	minimal number of columns to keep left and right of the cursor
            set siso=5
        "display	include "lastline" to show the last line even if it doesn't fit include "uhex" to show unprintable characters as a hex number
        "   set dy=lastline,msgsep
        "fillchars	characters to use for the status line, folds and filler lines
           set fcs=
        "   set fcs=diff:∙        " BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
        "   set fcs+=fold:·       " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
        "   set fcs+=vert:┃       " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
           set fcs+=eob:\        " suppress ~ at EndOfBuffer
        "lazyredraw	don't redraw while executing macros
            set lz
        "list	show <Tab> as ^I and end-of-line as $ (local to window)
            set list
        "listchars	list of strings used for list mode
            " Sometimes I'm on an environment with iso local so I don't use
            " utf-8 characters for this
            set listchars=tab:¦»
            set listchars+=extends:»
            set listchars+=precedes:«
            set listchars+=trail:°
            set listchars+=nbsp:÷
            "set listchars+=eol:¶
        "number	show the line number for each line (local to window)
            set nu
        "relativenumber	show the relative line number for each line (local to window)
            set rnu

    " 5 syntax, highlighting and spelling
        "background	"dark" or "light"; the background color brightness
            set bg=dark
        "filetype	type of file; triggers the FileType event when set (local to buffer)
        "   set ft=
        "syntax	name of syntax highlighting used (local to buffer)
            syntax enable
        "synmaxcol	maximum column to look for syntax items (local to buffer)
            set smc=1000
        "hlsearch	highlight all matches for the last used search pattern
            set hls
        "termguicolors	use GUI colors for the terminal
            set tgc
        "cursorcolumn	highlight the screen column of the cursor (local to window)
        "   set nocuc	cuc
        "cursorline	highlight the screen line of the cursor (local to window)
            set cul
        "colorcolumn	columns to highlight (local to window)
            set cc=81
        "spelllang	list of accepted languages (local to buffer)
           set spl=en_us,sv

    " 6 multiple windows
        "laststatus	0, 1 or 2; when to use a status line for the last window
            set ls=2
        "hidden	don't unload a buffer when no longer shown in a window
            set hid
        "switchbuf	"useopen" and/or "split"; which window to use when jumping to a buffer
            set swb=useopen  "try to reuse windows/tabs when switching buffers
        "splitbelow	a new window is put below the current one
            set sb
        "splitright	a new window is put right of the current one
            set spr

    " 7 multiple tab pages
        "showtabline	0, 1 or 2; when to use a tab pages line
           set stal=1

    " 8 terminal
        "title	show info in the window title
            set title   "Show filename in titlebar of window

    "11 messages and info
        "shortmess	list of flags to make messages shorter
        "   set shm=filnxFAIOTWacot
            set shortmess+=A    " ignore annoying swapfile messages
            set shortmess+=I    " no splash screen
            set shortmess+=O    " file-read message overwrites previous
            set shortmess+=T    " truncate non-file messages in middle
            "set shortmess+=W    " don't echo "[w]"/"[written]" when writing
            set shortmess+=a    " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
            set shortmess+=c    " don't give [ins-completion-menu] messages
            set shortmess+=o    " overwrite file-written messages
            set shortmess+=t    " truncate file messages at start

        "ruler	show cursor position below each window
            set ru

    "13 editing text
        "textwidth	line length above which to break a line (local to buffer)
        "   set tw=0
        "wrapmargin	margin from the right in which to break a line (local to buffer)
           set wm=5
        "backspace	specifies what <BS>, CTRL-W, etc. can do in Insert mode
           set bs=indent,eol,start
        "formatoptions	list of flags that tell how automatic formatting works (local to buffer)
        "   set fo=jcroql
            set formatoptions=1     " Don't break a line after a one-letter word.  It's broken before it instead (if possible).
            set formatoptions+=2    " When formatting text, use the indent of the second line of a paragraph for the rest of the paragraph, instead of the indent of the first line.
            "set formatoptions+=B    " When joining lines, don't insert a space between two multi-byte characters.  Overruled by the 'M' flag.
            set formatoptions+=M    " When joining lines, don't insert a space before or after a multi-byte character.  Overrules the 'B' flag.
            set formatoptions+=b    " Like 'v', but only auto-wrap if you enter a blank at or before the wrap margin.
            "set formatoptions+=c    " Auto-wrap comments using textwidth, inserting the current comment leader automatically.
            set formatoptions+=j    " remove comment leader when joining comment lines
            set formatoptions+=l    " Long lines are not broken in insert mode: When a line was longer than 'textwidth' when the insert command started, Vim does not automatically format it.
            "set formatoptions+=m   " Also break at a multi-byte character above 255. This is useful for Asian text where every character is a word on its own.
            set formatoptions+=n    " smart auto-indenting inside numbered lists
            "set formatoptions+=o    " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
            set formatoptions+=p    " Don't break lines at single spaces that follow periods.
            set formatoptions+=q    " Allow formatting of comments with 'gq'. Note that formatting will not change blank lines or lines containing only the comment leader. A new paragraph starts after such a line, or when the comment leader changes.
            set formatoptions+=r    " Automatically insert the current comment leader after hitting <Enter> in Insert mode.
            "set formatoptions+=t    " Auto-wrap text using textwidth
            set formatoptions+=w    " Trailing white space indicates a paragraph continues in the next line. A line that ends in a non-white character ends a paragraph.
        "complete	specifies how Insert mode completion works for CTRL-N and CTRL-P (local to buffer)
            set cpt=.,w,b,u,U,t,i,d
        "completeopt	whether to use a popup menu for Insert mode completion
            set cot=menuone,noselect,preview
        "pumheight	maximum height of the popup menu
           set ph=15
        "infercase	adjust case of a keyword completion match (local to buffer)
            set inf     "Adjust completions to match case
        "joinspaces	use two spaces after '.', '?', '!' when joining a line
            set nojs

    "14 tabs and indenting
        "tabstop	number of spaces a <Tab> in the text stands for (local to buffer)
           set ts=2
        "shiftwidth	number of spaces used for each step of (auto)indent (local to buffer)
            set sw=2
        "softtabstop	if non-zero, number of spaces to insert for a <Tab> (local to buffer)
            set sts=-1  " use 'shiftwidth'
        "shiftround	round to 'shiftwidth' for "<<" and ">>"
            set sr  " Always indent/outdent to nearest tabstop
        "expandtab	expand <Tab> to spaces in Insert mode (local to buffer)
            set et
        "autoindent	automatically set the indent of a new line (local to buffer)
            set ai
        "smartindent	do clever autoindenting (local to buffer)
            set si

    "15 folding
        "foldenable	set to display all folds open (local to window)
            set nofen
        "foldlevelstart	value for 'foldlevel' when starting to edit a file
            set fdls=99     " start unfolded
        "foldmethod	folding type: "manual", "indent", "expr", "marker" or "syntax" (local to window)
            set fdm=marker
        "foldnestmax	maximum fold depth for when 'foldmethod' is "indent" or "syntax" (local to window)
            set fdn=4

    "18 reading and writing files
        "modelines	number of lines to check for modelines
            set mls=5
        "fileformat	end-of-line format: "dos", "unix" or "mac" (local to buffer)
            set ff=unix
        "fileformats	list of file formats to look for when editing a file (local to buffer)
           set ffs=unix,mac,dos
        "autowrite	automatically write a file when leaving a modified buffer
            set aw
        "autoread	automatically read a file when it was modified outside of Vim (global or local to buffer)
            set ar

    "20 command line editing
        "wildmode	specifies how command line completion works
            set wim=list:longest,full   "Show list of completions and complete as much as possible, then iterate full completions
        "wildignore	list of patterns to ignore files for file name completion
            set wildignore+=/tmp/*,*.so,*.swp,*.zip           " MacOSX/Linux
            set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.bak  " Windows
            set wildignore+=.hg,.git,.svn,*.fossil             " Version control
            set wildignore+=*.aux,*.out,*.toc                  " LaTeX intermediate files
            set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg     " binary images
            set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest   " compiled object files
            set wildignore+=*.spl                              " compiled spelling word lists
            set wildignore+=*.DS_Store                         " OSX bullshit
            set wildignore+=*.luac                             " Lua byte code
            set wildignore+=migrations                         " Django migrations
            set wildignore+=__pycache__,*__pycache__/*,*.pyc               " Python byte code
            set wildignore+=*.orig                             " Merge resolution files
            set wildignore+=bin                                " files in bin folder
            set wildignore+=nbproject                          " Netbeans project folder
            set wildignore+=external                           " folders for external dependecies

    "23 language specific
        "iskeyword	specifies the characters in a keyword (local to buffer)
           set isk+=-

    "24 multi-byte characters
        "fileencoding	character encoding for the current file (local to buffer)
            set fenc=utf-8

    "25 various
        "virtualedit	when to use virtual editing: "block", "insert" and/or "all"
            set ve=block    " allow cursor to move where there is no text in visual block mode
        "signcolumn	whether to show the signcolumn (local to window)
           set scl=yes
        "pyxversion	whether to use Python 2 or 3
        "   set pyx=0


" Set leader keys. Must be set before loading plugins.
" Default <leader> is \ (backslash)
    let mapleader="\<space>"
    let maplocalleader="\\"


" PLUGINS ==
    for plugin in g:myplugins
        if plugin == 'flake8-vim'
            let g:PyFlakeOnWrite = 1
            let g:PyFlakeCheckers = 'pep8'
            let g:PyFlakeAggressive = 0
            let g:PyFlakeDisabledMessages = 'E262,E265,E402,E501,E722'

        elseif plugin == 'ale'
            let g:ale_linters = {'python': ['flake8']}
            let g:ale_fixers = {'python': ['black']}

        elseif plugin == 'fzf.vim'
            nnoremap <leader>f :Files<cr>
            nnoremap <leader>b :Buffers<cr>

        elseif plugin == 'indentline'
            let g:indentLine_char = '|'
            let g:indentLine_noConcealCursor=""

        elseif plugin == 'jedi-vim'
            let g:jedi#goto_command = "<leader>ld"
            let g:jedi#goto_assignments_command = "<leader>la"
            let g:jedi#goto_stubs_command = "<leader>ls"
            let g:jedi#goto_definitions_command = ""
            let g:jedi#docuentation_command = "K"
            let g:jedi#usages_command = "<leader>lu"
            let g:jedi#completions_command = "<C-n>"
            let g:jedi#rename_command = "<leader>lr"

            let g:jedi#auto_vim_configuration = 0
            let g:jedi#use_splits_not_buffers = 'winwidth'

        elseif plugin == 'nerdtree'
            nnoremap <leader>et :NERDTreeToggle<cr>

            let g:NERDTreeBookmarksFile = $VIMTMP . '/tmp/NERDTreeBookmarks'
            let g:NERDTreeDirArrowExpandable = '+'
            let g:NERDTreeDirArrowCollapsible = '-'
            let NERDTreeHijackNetrw=1
            "let NERDTreeRespectWildIgnore=1
            autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

        elseif plugin == 'nnn.vim'
            " Show dotfiles
            let g:nnn#command = 'nnn -H'

        elseif plugin == 'nvim-colorizer.lua'
            lua require'colorizer'.setup()

        elseif plugin == 'vim-airline'
            let g:airline#extensions#tabline#enabled = 1

        elseif plugin == 'vim-closetag'
            let g:closetag_filetypes = 'html,xhtml,phtml,xml'

        elseif plugin == 'vim-json'
            let g:vim_json_syntax_conceal = 0
            let g:vim_json_syntax_concealcursor = 0

        elseif plugin == 'vim-rainbow'
            let g:rainbow_active = 1

        endif
    endfor

    " netrw config
        let g:netrw_home=$VIMTMP
        "let g:netrw_banner=1 " Disable annoying banner
        let g:netrw_browser_split=4 " Open in prior window
        let g:netrw_altv=1 " Open splits to the right
        let g:netrw_liststyle=3 " Tree view
        let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'


" MAPPINGS ===
    " Command mode
        " Add sudo to write
        cnoremap w!! w !sudo tee % >/dev/null

    " Visual mode
        " Quick way to exit insert mode
        vnoremap tn <ESC>

        " Make BS/DEL work as expected in visual modes (i.e. delete the selected text).
        vmap <BS> x

    " Leader mappings
        " Leader
            " Switch to last used buffer in the window
            nnoremap <leader><leader> <C-^>

            nnoremap <leader>o :e .<cr>

            " search and replace
            nnoremap <leader>r :%s```cg<Left><Left><Left><Left>

            " Redraw screen and update synax sync
            nnoremap <leader>u :syntax sync fromstart<cr>:redraw<cr>

            " Reload config
            nnoremap <silent> <leader>0 :so $MYVIMRC<cr>

        " Localleader
            " Toggle search highlight
            nnoremap <silent> <localleader>h :set hlsearch! hlsearch?<CR>

            " Show help for <cword> under cursor.
            nnoremap <localleader>sh :execute 'h ' . expand('<cword>') . ' '<cr>

            " Show help for <cWORD> under cursor.
            nnoremap <localleader>hh :execute 'h ' . expand('<cWORD>') . ' '<cr>

            " Cycle number mode
            nnoremap <silent> <localleader>n :call perers#functions#cycle_numbering()<CR>

            " Sort lines
            vnoremap <localleader>s :sort<cr>

            " Wrap
            nnoremap <localleader>w :set wrap!<cr> :set wrap?<cr>

            " Toggle [i]nvisible characters
            nnoremap <localleader>l :set list!<cr> :set list?<cr>

            " Remove trailing whitespace...
            nnoremap <silent> <localleader>x mz :call perers#functions#trim_trailing_whitespace()<CR>`z

            " Sync clipboard over ssh
            nnoremap <silent> <localleader>y :call perers#osc52#SendViaOSC52()<CR>

            " Open scratch file
            nnoremap <localleader>z :e $SCRATCHFILE<cr>

            " Close netrw buffers
            nnoremap <silent> <localleader>o :call perers#functions#close_explorer_buffers()<cr>

            " Indent/outdent current block...
            nnoremap <localleader>%% $>i}``
            nnoremap <localleader>$$ $<i}``

            " Panic Button
            nnoremap <localleader>' mzggg?G`z


    " Insert mode
        " Quick way to exit insert mode
        inoremap tn <ESC>

        " line down/up, to column where inserting started
            inoremap <S-Up> <C-g><Up>
            inoremap <S-Down> <C-g><Down>


        " Uppercase word mapping.
            "
            " This mapping allows you to press <c-u> in insert mode to convert
            " the current
            " word to uppercase.  It's handy when you're writing names of constants and
            " don't want to use Capslock.
            "
            " To use it you type the name of the constant in lowercase.  While your
            " cursor is at the end of the word, press <c-u> to uppercase it, and then
            " continue happily on your way:
            "
            "                            cursor
            "                            v
            "     max_connections_allowed|
            "     <c-u>
            "     MAX_CONNECTIONS_ALLOWED|
            "                            ^
            "                            cursor
            "
            " It works by exiting out of insert mode, recording the current cursor location
            " in the z mark, using gUiw to uppercase inside the current word, moving back to
            " the z mark, and entering insert mode again.
            "
            " Note that this will overwrite the contents of the z mark.  I never use it, but
            " if you do you'll probably want to use another mark.
            inoremap <C-U> <esc>mzgUiw`za

        " Default mappings from documentation
        " -----------------------------------------------------------------------
            " char        action in Insert mode
            " -----------------------------------------------------------------------
            " Standard mode
                " CTRL-@                    insert previously inserted text and stop insert
                " CTRL-A                    insert previously inserted text
                " CTRL-C                    quit insert mode, without checking for abbreviation, unless 'insertmode' set.
                " CTRL-D                    delete one shiftwidth of indent in the current line
                " CTRL-E                    insert the character which is below the cursor
                " CTRL-F                    not used (but by default it's in 'cinkeys' to re-indent the current line)
                " CTRL-G CTRL-J             line down, to column where inserting started
                " CTRL-G j                  line down, to column where inserting started
                " CTRL-G <Down>             line down, to column where inserting started
                " CTRL-G CTRL-K             line up, to column where inserting started
                " CTRL-G k                  line up, to column where inserting started
                " CTRL-G <Up>               line up, to column where inserting started
                " CTRL-G u                  start new undoable edit
                " CTRL-G U                  don't break undo with next cursor movement
                " <BS>                      delete character before the cursor
                " {char1}<BS>{char2}        enter digraph (only when 'digraph' option set)
                " CTRL-H                    same as <BS>
                " <Tab>                     insert a <Tab> character
                " CTRL-I                    same as <Tab>
                " <NL>                      same as <CR>
                " CTRL-J                    same as <CR>
                " CTRL-K {char1} {char2}    enter digraph
                " CTRL-L                    when 'insertmode' set: Leave Insert mode
                " <CR>                      begin new line
                " CTRL-M                    same as <CR>
                " CTRL-N                    find next match for keyword in front of the cursor
                " CTRL-O                    execute a single command and return to insert mode
                " CTRL-P                    find previous match for keyword in front of the cursor
                " CTRL-Q                    same as CTRL-V, unless used for terminal control flow
                " CTRL-R                    {0-9a-z"%#*:=} insert the contents of a register
                " CTRL-R CTRL-R             {0-9a-z"%#*:=} insert the contents of a register literally
                " CTRL-R CTRL-O             {0-9a-z"%#*:=} insert the contents of a register literally and don't auto-indent
                " CTRL-R CTRL-P             {0-9a-z"%#*:=} insert the contents of a register literally and fix indent.
                " CTRL-S                    (used for terminal control flow)
                " CTRL-T                    insert one shiftwidth of indent in current line
                " CTRL-U                    delete all entered characters in the current line
                " CTRL-V {char}             insert next non-digit literally
                " CTRL-V {number}           insert three digit decimal number as a single byte.
                " CTRL-W                    delete word before the cursor
                " CTRL-Y                    insert the character which is above the cursor
                " CTRL-Z                    when 'insertmode' set: suspend Vim
                " <Esc>                     end insert mode (unless 'insertmode' set)
                " CTRL-[                    same as <Esc>
                " CTRL-\ CTRL-N             go to Normal mode
                " CTRL-\ CTRL-G             go to mode specified with 'insertmode'
                " CTRL-\ a - z              reserved for extensions
                " CTRL-\ others             not used
                " CTRL-]                    trigger abbreviation
                " CTRL-^                    toggle use of |:lmap| mappings
                " CTRL-_                    When 'allowrevins' set: change language (Hebrew)
                "
                "         <Space> to '~'    not used, except '0' and '^' followed by CTRL-D
                "
                " 0 CTRL-D                  delete all indent in the current line
                " ^ CTRL-D                  delete all indent in the current line, restore it in the next line
                " <Del>                     delete character under the cursor
                "
                "         Meta characters (0x80 to 0xff, 128 to 255) not used
                "

                " <Left>                    cursor one character left
                " <S-Left>                  cursor one word left
                " <C-Left>                  cursor one word left
                " <Right>                   cursor one character right
                " <S-Right>                 cursor one word right
                " <C-Right>                 cursor one word right
                " <Up>                      cursor one line up
                " <S-Up>                    same as <PageUp>
                " <Down>                    cursor one line down
                " <S-Down>                  same as <PageDown>
                " <Home>                    cursor to start of line
                " <C-Home>                  cursor to start of file
                " <End>                     cursor past end of line
                " <C-End>                   cursor past end of file
                " <PageUp>                  one screenful backward
                " <PageDown>                one screenful forward
                " <F1>                      same as <Help>
                " <Help>                    stop insert mode and display help window
                " <Insert>                  toggle Insert/Replace mode
                " <LeftMouse>               cursor at mouse click
                " <ScrollWheelDown>         move window three lines down
                " <S-ScrollWheelDown>       move window one page down
                " <ScrollWheelUp>           move window three lines up
                " <S-ScrollWheelUp>         move window one page up
                " <ScrollWheelLeft>         move window six columns left
                " <S-ScrollWheelLeft>       move window one page left
                " <ScrollWheelRight>        move window six columns right
                " <S-ScrollWheelRight>      move window one page right

            " commands in CTRL-X submode    *i_CTRL-X_index*
                "
                " CTRL-X CTRL-D             complete defined identifiers
                " CTRL-X CTRL-E             scroll up
                " CTRL-X CTRL-F             complete file names
                " CTRL-X CTRL-I             complete identifiers
                " CTRL-X CTRL-K             complete identifiers from dictionary
                " CTRL-X CTRL-L             complete whole lines
                " CTRL-X CTRL-N             next completion
                " CTRL-X CTRL-O             omni completion
                " CTRL-X CTRL-P             previous completion
                " CTRL-X CTRL-S             spelling suggestions
                " CTRL-X CTRL-T             complete identifiers from thesaurus
                " CTRL-X CTRL-Y             scroll down
                " CTRL-X CTRL-U             complete with 'completefunc'
                " CTRL-X CTRL-V             complete like in : command line
                " CTRL-X CTRL-]             complete tags
                " CTRL-X s                  spelling suggestions

            " commands in completion mode (see |popupmenu-keys|)
                "
                " CTRL-E                    stop completion and go back to original text
                " CTRL-Y                    accept selected match and stop completion
                " CTRL-L                    insert one character from the current match
                " <CR>                      insert currently selected match
                " <BS>                      delete one character and redo search
                " CTRL-H                    same as <BS>
                " <Up>                      select the previous match
                " <Down>                    select the next match
                " <PageUp>                  select a match several entries back
                " <PageDown>                select a match several entries forward
                " other                     stop completion and insert the typed character

    " Normal mode
         " save, exit
            nnoremap ®  :w<cr>
            nnoremap ú :q<cr>
            nnoremap « :x<cr>

         " Close current buffer
            nnoremap ß :bn<CR>:bd#<CR>

        " Open $MYVIMRC
            nnoremap <F3> :e $MYVIMRC<CR>

          " No Q
            nnoremap Q gq

        " open cmd find
            nnoremap Ó :find

        " Move between open buffers
            nnoremap th :bp<CR>
            nnoremap tt :bn<CR>

        " Movement
            nnoremap <A-e> gkzz
            nnoremap <A-n> gjzz
            nnoremap k gk
            nnoremap j gj
            nnoremap é 5gjzz
            nnoremap ñ 5gkzz

            nnoremap <C-e> <C-e>M    " Scroll up
            nnoremap <C-n> <C-y>M    " Scroll down
            nnoremap <C-y> <C-n>     " Line down

        " Splits/windows actions
            nnoremap <up> <C-w>k
            nnoremap <down> <C-w>j
            nnoremap <left> <C-w>h
            nnoremap <right> <C-w>l

        " Resize window
            nnoremap <silent> ¡ :vertical resize +2<cr>
            nnoremap <silent> º :vertical resize -2<cr>
            nnoremap <silent> ª :resize +2<cr>
            nnoremap <silent> ¢ :resize -2<cr>
            nnoremap <silent> € :wincmd =<cr>

        " Show open buffers
            nnoremap <F4> :buffers<CR>:b

        " Reload current buffer
            nnoremap <F5> :e<cr>

        " Make zO recursively open whatever fold we're in, even if it's partially open.
            nnoremap za zo
            nnoremap zo za
            nnoremap zO zczO

        " Visual Block mode is far more useful that Visual mode (so swap the commands).
            nnoremap v <C-v>
            nnoremap <C-v> v

        " Select the entire file...
            nnoremap vaa VGo1G

        " Run make
            nnoremap <silent> <F7>  :make!<cr><cr><cr>:cw<cr><cr>

        " Quickfix
            nnoremap <silent> å :call perers#functions#toggle_quickfix_list()<cr>
            nnoremap <silent> ä :cp<cr>
            nnoremap <silent> ö :cn<cr>
            nnoremap <silent> ¶ :cc<cr>

        " Locallist
            nnoremap <silent> Å :call perers#functions#toggle_location_list()<cr>
            nnoremap <silent> Ä :lprevious<cr>
            nnoremap <silent> Ö :lnext<cr>
            nnoremap <silent> ° :ll<cr>

        " Insert blank lines before, after
            nnoremap í mzO<ESC>`z
            nnoremap Í mzo<Esc>`z

        " Reselect last-pasted text
            nnoremap gp `[v`]

        " Keep the cursor_in place while joining lines
            nnoremap J mzJ`z

        " Split line (sister to [J]oin lines)
            " The normal use of S is covered by cc, so don't worry about shadowing it.
            nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w


        " Zip Right
            "
            " Moves the character under the cursor to the end of the line.  Handy when you
            " have something like:
            "
            "     foo
            "
            " And you want to wrap it in a method call, so you type:
            "
            "     println()foo
            "
            " Once you hit escape your cursor is on the closing paren, so you can 'zip' it
            " over to the right with this mapping.
            "
            " This should preserve your last yank/delete as well.
            nnoremap zl x$p


        " Folding
            nnoremap zo za
            nnoremap za zo


" AUTO COMMANDS ===
    augroup misc_group
        au FocusLost * :silent! wall " Save when losing focus
        au VimResized * :wincmd = " Resize splits when the window is resized
        augroup END

    augroup number_mode
        au!
        au WinEnter * :setlocal relativenumber
        au WinLeave,FocusLost * :setlocal number norelativenumber
        au InsertEnter * :setlocal number
        au InsertLeave * :setlocal relativenumber
        augroup END

    " Open Quickfix window automatically after running :make
    augroup OpenQuickfixWindowAfterMake
        au!
        au QuickFixCmdPost [^l]* nested cwindow
        au QuickFixCmdPost    l* nested lwindow
        au FileType qf wincmd J
        augroup END

    augroup visible_trailing_whitespace
        au!
        au InsertEnter * :set list!
        au InsertLeave * :set list!
        augroup END

    augroup visible_naughtiness
        au!
        au BufEnter  *       set list
        au BufEnter  *.log   set nolist
        au BufEnter  *.txt   set nolist
        au BufEnter  *.vp*   set nolist
        au BufEnter  *       if !&modifiable
        au BufEnter  *           set nolist
        au BufEnter  *       endif
        augroup END

    augroup save_load_folds_leaving_buffer
        au!
        au BufWinLeave *,*.* silent! mkview
        au BufWinEnter *,*.* silent! loadview
        augroup end

    augroup show_cursorline
        au!
        au WinLeave,InsertEnter * set nocursorline
        au WinEnter,InsertLeave * set cursorline
        augroup END

    augroup show_cursorline
        au!
        au WinLeave,InsertEnter * set nocursorline
        au WinEnter,InsertLeave * set cursorline
        augroup END

    augroup vim_reload_config
        au!
        au BufWritePost $MYVIMRC so %
        augroup END

    augroup applications_reload_on_config_change
        au!
        au BufWritePost */herbstluftwm/* silent !herbstclient reload
        au BufWritePost */sxhkdrc silent execute '!killall sxhkd; sxhkd &'
        augroup END

" SET COLORSCHEME
    color perers
