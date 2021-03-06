scriptencoding utf-8

if !has('nvim') && v:version < 802
    echo "This config is only for nvim and vim version >= 802!"
    exit
endif

" VIMINIT is exported in my shell profile so that I don't need to create
" symlinks if I use regular Vim.
"
" Also I use this at work, because in some cases I need to use /tmp/perers
" as a simulated home directory, and it is easy to use VIMINIT in those cases.
"
if exists('$VIMINIT')
    let $MYVIMRC = substitute($VIMINIT, '^source\ ', '', 'g')
    let $VIMDIR = substitute($MYVIMRC, '/init.vim', '', 'g')
    let $VIMTMP = substitute($VIMDIR, '.config/nvim', '.cache/nvim', 'g')
    let $VIMTMP = $VIMTMP . '/' . $USER

    set runtimepath^=$VIMDIR
    set runtimepath+=$VIMDIR/after
    set packpath^=$VIMDIR
    set packpath+=$VIMDIR/after
else
    let $VIMDIR = $XDG_CONFIG_HOME . '/nvim'
    let $VIMTMP = $XDG_CACHE_HOME . '/nvim'
    let $MYVIMRC = $VIMDIR . '/init.vim'
endif

if !has('nvim')
    let $VIMTMP = substitute($VIMTMP, 'nvim', 'vim', 'g')
endif

if !exists('$SUDO_USER')
    silent execute "!mkdir -m 777 -p " . shellescape(expand($VIMTMP)) . "/{swap,undo,backup,view}"
endif

if !exists('SCRATCHFILE')
    let $SCRATCHFILE = $VIMTMP . "/scratch.txt"     " Scratchfile for tmp usage
endif

let g:tty = $TTY
let g:myplugindir = $VIMDIR . "/pack/plugins/start/"


" SETTINGS ===
    " Settings are ordered as in :options exept for 0 that is my own grouping.

    " 0 backup, view, undo, swap
        if has('viminfo') " ie. Vim.
            let s:viminfo='viminfo'
        elseif has('shada') " ie. Neovim.
            let s:viminfo='shada'
        endif

        if exists('s:viminfo')
            if exists('$SUDO_USER')        " don't create root-owned files
                set nobackup
                set nowritebackup
                set viminfo=
                execute 'set ' . s:viminfo . "="
            else
                set backup
                set undofile
                set backupskip=/tmp/*,/private/tmp/*"

                set directory=$VIMTMP/swap//
                set undodir=$VIMTMP/undo//
                set backupdir=$VIMTMP/backup//
                set viewdir=$VIMTMP/view//

                "                              +--Disable hlsearch while loading viminfo
                "                              | +--Remember marks for last 500 files
                "                              | |    +--Remember up to 10000 lines in each register
                "                              | |    |      +--Remember up to 1MB in each register
                "                              | |    |      |     +--Remember last 1000 search patterns
                "                              | |    |      |     |     +---Remember last 1000 commands
                "                              | |    |      |     |     |     +---Create viminfo file here
                "                              | |    |      |     |     |     |
                "                              | |    |      |     |     |     |
                "                              v v    v      v     v     v     v
                execute 'set ' . s:viminfo . "=h,'500,<10000,s1000,/1000,:1000,n" . $VIMTMP . "/" . s:viminfo
            endif
        endif

    " 1 important
        filetype plugin indent on
        "compatible     behave very Vi compatible (not advisable)
            set nocp        " (default for nvim)
        "cpoptions      list of flags to specify Vi compatibility
        "   set cpo=aABceFs_
        "insertmode    use Insert mode as the default mode
            set noim
        "paste          paste mode, insert typed text literally
            set nopaste
        "pastetoggle    key sequence to toggle paste mode
            set pt=<F12>   " key sequence to toggle paste mode

    " 2 moving around, searching and patterns
        "whichwrap      list of flags specifying which commands wrap to another line (local to window)
            set ww=b,s,<,>,[,],~         " allow <BS>/<Space>/<Left>/<Right>, ~ to cross line boundaries (local to window)
        "startofline    many jump commands move the cursor to the first non-blank character of a line
            set nosol
        "paragraphs nroff macro names that separate paragraphs
        "   set para=IPLPPPQPP\ TPHPLIPpLpItpplpipbp
        "sections   nroff macro names that separate sections
        "   set sect=SHNHH\ HUnhsh
        "path   list of directory names used for file searching (global or local to buffer)
            set pa=.,**
        "cdpath list of directory names used for :cd
        "   set cd=,,
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
        "casemap	what method to use for changing case of letters
        "   set cmp=internal,keepascii
        "maxmempattern	maximum amount of memory in Kbyte used for pattern matching
        "   set mmp=1000
        "define	pattern for a macro definition line (global or local to buffer)
        "   set def=^\\s*#\\s*define
        "include	pattern for an include-file line (local to buffer)
        "   set inc=^\\s*#\\s*include
        "includeexpr	expression used to transform an include line to a file name (local to buffer)
        "   set inex=

    " 3 tags
        "tagbsearch	use binary searching in tags files
        "   set tbs	notbs
        "taglength	number of significant characters in a tag name or zero
        "   set tl=0
        "tags	list of file names to search for tags (global or local to buffer)
        "   set tag=./tags;,tags
        "tagcase	how to handle case when searching in tags files: "followic" to follow 'ignorecase', "ignore" or "match" (global or local to buffer)
        "   set tc=followic
        "tagrelative	file names in a tags file are relative to the tags file
        "   set tr	notr
        "tagstack	a :tag command will use the tagstack
        "   set tgst	notgst
        "showfulltag	when completing tags in Insert mode show more info
        "   set nosft	sft
        "cscopeprg	command for executing cscope
        "   set csprg=cscope
        "cscopetag	use cscope for tag commands
        "   set nocst	cst
        "cscopetagorder	0 or 1; the order in which ":cstag" performs a search
        "   set csto=0
        "cscopeverbose	give messages when adding a cscope database
        "   set csverb	nocsverb
        "cscopepathcomp	how many components of the path to show
        "   set cspc=0
        "cscopequickfix	when to open a quickfix window for cscope
        "   set csqf=
        "cscoperelative	file names in a cscope file are relative to that file
        "   set nocsre	csre

    " 4 displaying text
        "scroll	number of lines to scroll for CTRL-U and CTRL-D (local to window)
        "   set scr=17
        "scrolloff	number of screen lines to show around the cursor
            set so=5
        "wrap	long lines wrap (local to window)
            set wrap
        "linebreak	wrap long lines at a character in 'breakat' (local to window)
            set lbr
        "breakindent	preserve indentation in wrapped text (local to window)
        "   set nobri	bri
        "breakindentopt	adjust breakindent behaviour (local to window)
        "   set briopt=
        "breakat	which characters might cause a line break
        "   set brk=\ \	!@*-+;:,./?
        "showbreak	string to put before wrapped screen lines
            let &showbreak=' ¬ '
        "sidescroll	minimal number of columns to scroll horizontally
        "   set ss=0
        "sidescrolloff	minimal number of columns to keep left and right of the cursor
            set siso=5
        "display	include "lastline" to show the last line even if it doesn't fit include "uhex" to show unprintable characters as a hex number
        "   set dy=lastline,msgsep
        "fillchars	characters to use for the status line, folds and filler lines
        "   set fcs=
        "   set fcs=diff:∙        " BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
        "   set fcs+=fold:·       " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
        "   set fcs+=vert:┃       " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
        "   set fcs+=eob:\        " suppress ~ at EndOfBuffer
        "cmdheight	number of lines used for the command-line
        "   set ch=1
        "columns	width of the display
        "   set co=273
        "lines	number of lines in the display
        "   set lines=73
        "window	number of lines to scroll for CTRL-F and CTRL-B
        "   set window=72
        "lazyredraw	don't redraw while executing macros
            set lz
        "redrawtime	timeout for 'hlsearch' and :match highlighting in msec
        "   set rdt=2000
        "writedelay	delay in msec for each char written to the display (for debugging)
        "   set wd=0
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
        "numberwidth	number of columns to use for the line number (local to window)
        "   set nuw=4
        "conceallevel	controls whether concealable text is hidden (local to window)
        "   set cole=0
        "concealcursor	modes in which text in the cursor line can be concealed (local to window)
            set cocu=

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
        "spell	highlight spelling mistakes (local to window)
        "   set nospell	spell
        "spelllang	list of accepted languages (local to buffer)
        "   set spl=en
        "spellfile	file that "zg" adds good words to (local to buffer)
            set spf=$VIMDIR/custom-dictionary.utf-8.add,$VIMDIR/local-dictionary.utf-8.add
        "spellcapcheck	pattern to locate the end of a sentence (local to buffer)
        "   set spc=[.?!]\\_[\\])'\"\	\ ]\\+
        "spellsuggest	methods used to suggest corrections
        "   set sps=best
        "mkspellmem	amount of memory used by :mkspell before compressing
        "   set msm=460000,2000,500

    " 6 multiple windows
        "laststatus	0, 1 or 2; when to use a status line for the last window
            set ls=2
        "statusline	alternate format to be used for a status line
        "   set stl=
        "equalalways	make all windows the same size when adding/removing windows
        "   set ea	noea
        "eadirection	in which direction 'equalalways' works: "ver", "hor" or "both"
        "   set ead=both
        "winheight	minimal number of lines used for the current window
        "   set wh=1
        "winminheight	minimal number of lines used for any window
        "   set wmh=1
        "winfixheight	keep the height of the window (local to window)
        "   set nowfh	wfh
        "winfixwidth	keep the width of the window (local to window)
        "   set nowfw	wfw
        "winwidth	minimal number of columns used for the current window
        "   set wiw=20
        "winminwidth	minimal number of columns used for any window
        "   set wmw=1
        "helpheight	initial height of the help window
        "   set hh=20
        "previewheight	default height for the preview window
        "   set pvh=12
        "previewwindow	identifies the preview window (local to window)
        "   set nopvw	pvw
        "hidden	don't unload a buffer when no longer shown in a window
            set hid
        "switchbuf	"useopen" and/or "split"; which window to use when jumping to a buffer
            set swb=usetab  "try to reuse windows/tabs when switching buffers
        "splitbelow	a new window is put below the current one
            set sb
        "splitright	a new window is put right of the current one
            set spr
        "scrollbind	this window scrolls together with other bound windows (local to window)
        "   set noscb	scb
        "scrollopt	"ver", "hor" and/or "jump"; list of options for 'scrollbind'
        "   set sbo=ver,jump
        "cursorbind	this window's cursor moves together with other bound windows (local to window)
        "   set nocrb	crb

    " 7 multiple tab pages
        "showtabline	0, 1 or 2; when to use a tab pages line
        "   set stal=1
        "tabpagemax	maximum number of tab pages to open for -p and "tab all"
        "   set tpm=50
        "tabline	custom tab pages line
        "   set tal=

    " 8 terminal
        "scrolljump	minimal number of lines to scroll at a time
        "   set sj=1
        "title	show info in the window title
            set title   "Show filename in titlebar of window
        "titlelen	percentage of 'columns' used for the window title
        "   set titlelen=85
        "titlestring	when not empty, string to be used for the window title
        "   set titlestring=
        "titleold	string to restore the title to when exiting Vim
        "   set titleold=
        "icon	set the text of the icon for this window
        "   set noicon	icon
        "iconstring	when not empty, text for the icon of this window
        "   set iconstring=

    " 9 using the mouse
        "mouse	list of flags for using the mouse
        "   set mouse=
        "mousemodel	"extend", "popup" or "popup_setpos"; what the right mouse button is used for
        "   set mousem=extend
        "mousetime	maximum time in msec to recognize a double-click
        "   set mouset=500

    "10 printing
        "printoptions	list of items that control the format of :hardcopy output
        "   set popt=
        "printdevice	name of the printer to be used for :hardcopy
        "   set pdev=
        "printexpr	expression used to print the PostScript file for :hardcopy
        "   set pexpr=system(['lpr']\ +\ (empty(&printdevice)?[]:['-P',\ &printdevice])\ +\ [v:fname_in]).\ delete(v:fname_in)+\ v:shell_error
        "printfont	name of the font to be used for :hardcopy
        "   set pfn=courier
        "printheader	format of the header used for :hardcopy
        "   set pheader=%<%f%h%m%=Page\ %N
        "printencoding	encoding used to print the PostScript file for :hardcopy
        "   set penc=
        "printmbcharset	the CJK character set to be used for CJK output from :hardcopy
        "   set pmbcs=
        "printmbfont	list of font names to be used for CJK output from :hardcopy
        "   set pmbfn=

    "11 messages and info
        "terse	add 's' flag in 'shortmess' (don't show search message)
        "   set noterse	terse
        "shortmess	list of flags to make messages shorter
        "   set shm=filnxFAIOTWacot
            set shortmess+=A    " ignore annoying swapfile messages
            set shortmess+=I    " no splash screen
            set shortmess+=O    " file-read message overwrites previous
            set shortmess+=T    " truncate non-file messages in middle
            set shortmess+=W    " don't echo "[w]"/"[written]" when writing
            set shortmess+=a    " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
            set shortmess+=c    " completion messages
            set shortmess+=o    " overwrite file-written messages
            set shortmess+=t    " truncate file messages at start
        "showcmd	show (partial) command keys in the status line
        "   set sc	nosc
        "showmode	display the current mode in the status line
            set smd
        "ruler	show cursor position below each window
            set ru
        "rulerformat	alternate format to be used for the ruler
        "   set ruf=
        "report	threshold for reporting number of changed lines
        "   set report=2
        "verbose	the higher the more messages are given
        "   set vbs=0
        "verbosefile	file to write messages in
        "   set vfile=
        "more	pause listings when the screen is full
        "   set more	nomore
        "confirm	start a dialog when a command fails
        "   set nocf	cf
        "errorbells	ring the bell for error messages
        "   set noeb	eb
        "visualbell	use a visual bell instead of beeping
        "   set vb	novb
        "belloff	do not ring the bell for these reasons
            set belloff=all
        "helplang	list of preferred languages for finding help
        "   set hlg=en

    "12 selecting text
        "selection	"old", "inclusive" or "exclusive"; how selecting text behaves
        "   set sel=inclusive
        "selectmode	"mouse", "key" and/or "cmd"; when to start Select mode instead of Visual mode
        "   set slm=
        "clipboard	"unnamed" to use the * register like unnamed register "autoselect" to always put selected text on the clipboard
        "   set cb=
        "keymodel	"startsel" and/or "stopsel"; what special keys can do
        "   set km=

    "13 editing text
        "undolevels	maximum number of changes that can be undone (global or local to buffer)
        "   set ul=1000
        "undofile	automatically save and restore undo history
        "   set in section 0
        "undodir	list of directories for undo files
        "   set in section 0
        "undoreload	maximum number lines to save for undo on a buffer reload
        "   set ur=10000
        "modified	changes have been made and not written to a file (local to buffer)
        "   set nomod	mod
        "readonly	buffer is not to be written (local to buffer)
        "   set noro	ro
        "modifiable	changes to the text are not possible (local to buffer)
        "   set ma	noma
        "textwidth	line length above which to break a line (local to buffer)
        "   set tw=0
        "wrapmargin	margin from the right in which to break a line (local to buffer)
        "   set wm=0
        "backspace	specifies what <BS>, CTRL-W, etc. can do in Insert mode
           set bs=indent,eol,start
        "comments	definition of what comment lines look like (local to buffer)
        "   set com=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"
        "formatoptions	list of flags that tell how automatic formatting works (local to buffer)
        "   set fo=jcroql
            set formatoptions=1     " Don't break a line after a one-letter word.  It's broken before it instead (if possible).
            set formatoptions+=2    " When formatting text, use the indent of the second line of a paragraph for the rest of the paragraph, instead of the indent of the first line.
            set formatoptions+=B    " When joining lines, don't insert a space between two multi-byte characters.  Overruled by the 'M' flag.
            set formatoptions+=M    " When joining lines, don't insert a space before or after a multi-byte character.  Overrules the 'B' flag.
            set formatoptions+=b    " Like 'v', but only auto-wrap if you enter a blank at or before the wrap margin.
            "set formatoptions+=c    " Auto-wrap comments using textwidth, inserting the current comment leader automatically.
            set formatoptions+=j    " remove comment leader when joining comment lines
            set formatoptions+=l    " Long lines are not broken in insert mode: When a line was longer than 'textwidth' when the insert command started, Vim does not automatically format it.
            "set formatoptions+=m   " Also break at a multi-byte character above 255. This is useful for Asian text where every character is a word on its own.
            set formatoptions+=n    " smart auto-indenting inside numbered lists
            set formatoptions+=o    " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
            set formatoptions+=p    " Don't break lines at single spaces that follow periods.
            set formatoptions+=q    " Allow formatting of comments with 'gq'. Note that formatting will not change blank lines or lines containing only the comment leader. A new paragraph starts after such a line, or when the comment leader changes.
            set formatoptions+=r    " Automatically insert the current comment leader after hitting <Enter> in Insert mode.
            "set formatoptions+=t    " Auto-wrap text using textwidth
            set formatoptions+=w    " Trailing white space indicates a paragraph continues in the next line. A line that ends in a non-white character ends a paragraph.
        "formatlistpat	pattern to recognize a numbered list (local to buffer)
        "   set flp=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
        "formatexpr	expression used for "gq" to format lines (local to buffer)
        "   set fex=
        "complete	specifies how Insert mode completion works for CTRL-N and CTRL-P (local to buffer)
            set cpt=.,w,b,u,t
        "completeopt	whether to use a popup menu for Insert mode completion
            set cot=menuone,longest,preview
        "pumheight	maximum height of the popup menu
        "   set ph=0
        "completefunc	user defined function for Insert mode completion (local to buffer)
        "   set cfu=
        "omnifunc	function for filetype-specific Insert mode completion (local to buffer)
        "   set ofu=
        "dictionary	list of dictionary files for keyword completion (global or local to buffer)
            set dict=/usr/share/dict/words
        "thesaurus	list of thesaurus files for keyword completion (global or local to buffer)
        "   set tsr=
        "infercase	adjust case of a keyword completion match (local to buffer)
            set inf     "Adjust completions to match case
        "digraph	enable entering digraphs with c1 <BS> c2
        "   set nodg	dg
        "tildeop	the "~" command behaves like an operator
        "   set notop	top
        "operatorfunc	function called for the"g@"  operator
        "   set opfunc=
        "showmatch	when inserting a bracket, briefly jump to its match
        "   set nosm	sm
        "matchtime	tenth of a second to show a match for 'showmatch'
        "   set mat=3
        "matchpairs	list of pairs that match for the "%" command (local to buffer)
        "   set mps=(:),{:},[:]
        "joinspaces	use two spaces after '.', '?', '!' when joining a line
            set nojs
        "nrformats	"alpha", "octal" and/or "hex"; number formats recognized for CTRL-A and CTRL-X commands (local to buffer)
        "   set nf=bin,hex

    "14 tabs and indenting
        "tabstop	number of spaces a <Tab> in the text stands for (local to buffer)
        "   set ts=8
        "shiftwidth	number of spaces used for each step of (auto)indent (local to buffer)
            set sw=4
        "smarttab	a <Tab> in an indent inserts 'shiftwidth' spaces
        "   set sta	nosta
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
        "cindent	enable specific indenting for C code (local to buffer)
        "   set nocin	cin
        "cinoptions	options for C-indenting (local to buffer)
        "   set cino=
        "cinkeys	keys that trigger C-indenting in Insert mode (local to buffer)
        "   set cink=0{,0},0),0],:,0#,!^F,o,O,e
        "cinwords	list of words that cause more C-indent (local to buffer)
        "   set cinw=if,else,while,do,for,switch
        "indentexpr	expression used to obtain the indent of a line (local to buffer)
        "   set inde=
        "indentkeys	keys that trigger indenting with 'indentexpr' in Insert mode (local to buffer)
        "   set indk=0{,0},0),0],:,0#,!^F,o,O,e,=end,=else,=cat,=fina,=END,0\\,0=\"\\\
        "copyindent	copy whitespace for indenting from previous line (local to buffer)
        "   set noci	ci
        "preserveindent	preserve kind of whitespace when changing indent (local to buffer)
        "   set nopi	pi
        "lisp	enable lisp mode (local to buffer)
        "   set nolisp	lisp

    "15 folding
        let g:FoldMethod = 0
        "foldenable	set to display all folds open (local to window)
            set nofen
        "foldlevel	folds with a level higher than this number will be closed (local to window)
            set fdl=0
        "foldlevelstart	value for 'foldlevel' when starting to edit a file
            set fdls=99     " start unfolded
        "foldcolumn	width of the column used to indicate folds (local to window)
            set fdc=0
        "foldtext	expression used to display the text of a closed fold (local to window)
        "   set fdt=foldtext()
        "foldclose	set to "all" to close a fold when the cursor leaves it
        "   set fcl=
        "foldopen	specifies for which commands a fold will be opened
        "   set fdo=block,hor,mark,percent,quickfix,search,tag,undo
        "foldminlines	minimum number of screen lines for a fold to be closed (local to window)
        "   set fml=1
        "commentstring	template for comments; used to put the marker in
        "   set cms=\"%s
        "foldmethod	folding type: "manual", "indent", "expr", "marker" or "syntax" (local to window)
            set fdm=indent  " not as cool as syntax, but faster
        "foldexpr	expression used when 'foldmethod' is "expr" (local to window)
        "   set fde=0
        "foldignore	used to ignore lines when 'foldmethod' is "indent" (local to window)
            set fdi=
        "foldmarker	markers used when 'foldmethod' is "marker" (local to window)
            set fmr={{{,}}}
        "foldnestmax	maximum fold depth for when 'foldmethod' is "indent" or "syntax" (local to window)
            set fdn=4

    "16 diff mode
        "diff	use diff mode for the current window (local to window)
        "   set nodiff	diff
        "diffopt	options for using diff mode
        "   set dip=internal,filler
        "diffexpr	expression used to obtain a diff file
        "   set dex=
        "patchexpr	expression used to patch a file
        "   set pex=

    "17 mapping
        "maxmapdepth	maximum depth of mapping
        "   set mmd=1000
        "remap	recognize mappings in mapped keys
        "   set remap	noremap
        "timeout	allow timing out halfway into a mapping
        "   set to	noto
        "ttimeout	allow timing out halfway into a key code
        "   set ttimeout	nottimeout
        "timeoutlen	time in msec for 'timeout'
        "   set tm=1000
        "ttimeoutlen	time in msec for 'ttimeout'
        "   set ttm=50

    "18 reading and writing files
        "modeline	enable using settings from modelines when reading a file (local to buffer)
        "   set ml	noml
        "modelineexpr	allow setting expression options from a modeline
        "   set nomle	mle
        "modelines	number of lines to check for modelines
            set mls=5
        "binary	binary file editing (local to buffer)
        "   set nobin	bin
        "endofline	last line in the file has an end-of-line (local to buffer)
        "   set eol	noeol
        "fixendofline	fixes missing end-of-line at end of text file (local to buffer)
        "   set fixeol	nofixeol
        "bomb	prepend a Byte Order Mark to the file (local to buffer)
        "   set nobomb	bomb
        "fileformat	end-of-line format: "dos", "unix" or "mac" (local to buffer)
        "   set ff=unix
        "fileformats	list of file formats to look for when editing a file (local to buffer)
        "   set ffs=unix,mac,dos
        "write	writing files is allowed
        "   set write	nowrite
        "writebackup	write a backup file before overwriting a file
        "   set wb	nowb
        "backup	keep a backup after overwriting a file
        "   set in section 0
        "backupskip	patterns that specify for which files a backup is not made
        "   set in section 0
        "backupcopy	whether to make the backup as a copy or rename the existing file (global or local to buffer)
        "   set bkc=auto
        "backupdir	list of directories to put backup files in
        "   set in section 0
        "backupext	file name extension for the backup file
        "   set bex=~
        "autowrite	automatically write a file when leaving a modified buffer
            set aw
        "autowriteall	as 'autowrite', but works with more commands
        "   set noawa	awa
        "writeany	always write without asking for confirmation
        "   set nowa	wa
        "autoread	automatically read a file when it was modified outside of Vim (global or local to buffer)
            set ar
        "patchmode	keep oldest version of a file; specifies file name extension
        "   set pm=
        "fsync	forcibly sync the file to disk after writing it
        "   set nofs	fs

    "19 the swap file
        "directory	list of directories for the swap file
        "   set in section 0
        "swapfile	use a swap file for this buffer (local to buffer)
            set noswf
        "updatecount	number of characters typed to cause a swap file update
        "   set uc=80
        "updatetime	time in msec after which the swap file will be updated
        "   set ut=2000

    "20 command line editing
        "history	how many command lines are remembered
        "   set hi=10000
        "wildchar	key that triggers command-line expansion
        "   set wc=9
        "wildcharm	like 'wildchar' but can also be used in a mapping
        "   set wcm=0
        "wildmode	specifies how command line completion works
            set wim=list:longest,full   "Show list of completions and complete as much as possible, then iterate full completions
        "suffixes	list of file name extensions that have a lower priority
        "   set su=.bak,~,.o,.h,.info,.swp,.obj
        "suffixesadd	list of file name extensions added when searching for a file (local to buffer)
        "   set sua=
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
        "fileignorecase	ignore case when using file names
        "   set nofic	fic
        "wildignorecase	ignore case when completing file names
        "   set nowic	wic
        "wildmenu	command-line completion shows a list of matches
        "   set wmnu	nowmnu
        "cedit	key used to open the command-line window
        "   set cedit=
        "cmdwinheight	height of the command-line window
        "   set cwh=7

    "21 executing external commands
        "shell	name of the shell program used for external commands
            set sh=/bin/bash
        "shellquote	character(s) to enclose a shell command in
        "   set shq=
        "shellxquote	like 'shellquote' but include the redirection
        "   set sxq=
        "shellxescape	characters to escape when 'shellxquote' is (
        "   set sxe=
        "shellcmdflag	argument for 'shell' to execute a command
        "   set shcf=-c
        "shellredir	used to redirect command output to a file
        "   set srr=>%s\ 2>&1
        "shelltemp	use a temp file for shell commands instead of using a pipe
        "   set stmp	nostmp
        "equalprg	program used for "=" command (global or local to buffer)
        "   set ep=
        "formatprg	program used to format lines with "gq" command
        "   set fp=
        "keywordprg	program used for the "K" command
        "   set kp=:help
        "warn	warn when using a shell command and a buffer has changes
        "   set warn	nowarn

    "22 running make and jumping to errors
        "errorfile	name of the file that contains error messages
        "   set ef=errors.err
        "errorformat	list of formats for error messages (global or local to buffer)
        "   set efm=%*[^\"]\"%f\"%*\\D%l:\ %m,\"%f\"%*\\D%l:\ %m,%-G%f:%l:\ (Each\ undeclared\ identifier\ is\ reported\ only\ once,%-G%f:%l:\ for\ each\ function\ it\ appears\ in.),%-GIn\ file\ included\ from\ %f:%l:%c:,%-GIn\ file\ included\ from\ %f:%l:%c\\,,%-GIn\ file\ included\ from\ %f:%l:%c,%-GIn\ file\ included\ from\ %f:%l,%-G%*[\ ]from\ %f:%l:%c,%-G%*[\ ]from\ %f:%l:,%-G%*[\ ]from\ %f:%l\\,,%-G%*[\ ]from\ %f:%l,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,\"%f\"\\,\ line\ %l%*\\D%c%*[^\ ]\ %m,%D%*\\a[%*\\d]:\ Entering\ directory\ %*[`']%f',%X%*\\a[%*\\d]:\ Leaving\ directory\ %*[`']%f',%D%*\\a:\ Entering\ directory\ %*[`']%f',%X%*\\a:\ Leaving\ directory\ %*[`']%f',%DMaking\ %*\\a\ in\ %f,%f\|%l\|\ %m
        "makeprg	program used for the ":make" command (global or local to buffer)
        "   set mp=make
        "shellpipe	string used to put the output of ":make" in the error file
        "   set sp=2>&1\|\ tee
        "makeef	name of the errorfile for the 'makeprg' command
        "   set mef=
        "grepprg	program used for the ":grep" command (global or local to buffer)
        "   set gp=grep\ -n\ $*\ /dev/null
        "grepformat	list of formats for output of 'grepprg'
        "   set gfm=%f:%l:%m,%f:%l%m,%f\ \ %l%m
        "makeencoding	encoding of the ":make" and ":grep" output (global or local to buffer)
        "   set menc=

    "23 language specific
        "isfname	specifies the characters in a file name
        "   set isf=@,48-57,/,.,-,_,+,,,#,$,%,~,=
        "isident	specifies the characters in an identifier
        "   set isi=@,48-57,_,192-255
        "iskeyword	specifies the characters in a keyword (local to buffer)
        "   set isk=@,48-57,_,192-255,#
        "isprint	specifies printable characters
        "   set isp=@,161-255
        "quoteescape	specifies escape characters in a string (local to buffer)
        "   set qe=\\
        "rightleft	display the buffer right-to-left (local to window)
        "   set norl	rl
        "rightleftcmd	when to edit the command-line right-to-left (local to window)
        "   set rlc=search
        "revins	insert characters backwards
        "   set nori	ri
        "allowrevins	allow CTRL-_ in Insert and Command-line mode to toggle 'revins'
        "   set noari	ari
        "aleph	the ASCII code for the first letter of the Hebrew alphabet
        "   set al=224
        "hkmap	use Hebrew keyboard mapping
        "   set nohk	hk
        "hkmapp	use phonetic Hebrew keyboard mapping
        "   set nohkp	hkp
        "arabic	prepare for editing Arabic text (local to window)
        "   set noarab	arab
        "arabicshape	perform shaping of Arabic characters
        "   set arshape	noarshape
        "termbidi	terminal will perform bidi handling
        "   set notbidi	tbidi
        "keymap	name of a keyboard mapping
        "   set kmp=
        "langmap	list of characters that are translated in Normal mode
        "   set lmap=
        "langremap	apply 'langmap' to mapped characters
        "   set nolrm	lrm
        "iminsert	in Insert mode: 1: use :lmap; 2: use IM; 0: neither (local to window)
        "   set imi=0
        "imsearch	entering a search pattern: 1: use :lmap; 2: use IM; 0: neither (local to window)
        "   set ims=-1

    "24 multi-byte characters
        "encoding	character encoding used in Vim: "latin1", "utf-8" "euc-jp", "big5", etc.
            set enc=utf-8
        "fileencoding	character encoding for the current file (local to buffer)
            set fenc=utf-8
        "fileencodings	automatically detected character encodings
            set fencs=ucs-bom,utf-8,default,latin1
        "charconvert	expression used for character encoding conversion
        "   set ccv=
        "delcombine	delete combining (composing) characters on their own
        "   set nodeco	deco
        "maxcombine	maximum number of combining (composing) characters displayed
        "   set mco=6
        "ambiwidth	width of ambiguous width characters
        "   set ambw=single
        "emoji	emoji characters are full width
            set noemo

    "25 various
        "virtualedit	when to use virtual editing: "block", "insert" and/or "all"
            set ve=block    " allow cursor to move where there is no text in visual block mode
        "eventignore	list of autocommand events which are to be ignored
        "   set ei=
        "loadplugins	load plugin scripts when starting up
            set lpl
        "exrc	enable reading .vimrc/.exrc/.gvimrc in the current directory
        "   set noex	ex
        "secure	safer working with script files in the current directory
        "   set nosecure	secure
        "gdefault	use the 'g' flag for ":substitute"
        "   set nogd	gd
        "maxfuncdepth	maximum depth of function calls
        "   set mfd=100
        "sessionoptions	list of words that specifies what to put in a session file
        "   set ssop=blank,buffers,curdir,folds,help,tabpages,winsize
        "viewoptions	list of words that specifies what to save for :mkview
        "   set vop=folds,options,cursor,curdir
        "viewdir	directory where to store files with :mkview
        "   set in section 0
        "viminfo	list that specifies what to write in the ShaDa file
        "   set in section 0
        "bufhidden	what happens with a buffer when it's no longer in a window (local to buffer)
        "   set bh=
        "buftype	"", "nofile", "nowrite" or "quickfix": type of buffer (local to buffer)
        "   set bt=
        "buflisted	whether the buffer shows up in the buffer list (local to buffer)
        "   set bl	nobl
        "debug	set to "msg" to see all error messages
        "   set debug=
        "signcolumn	whether to show the signcolumn (local to window)
        "   set scl=auto
        "pyxversion	whether to use Python 2 or 3
        "   set pyx=0


" MAPPINGS ===
    " Command mode
        " Add sudo to write
        cnoremap w!! w !sudo tee % >/dev/null

    " Visual mode
        " Make BS/DEL work as expected in visual modes (i.e. delete the selected text).
        vmap <BS> x

    " Leader mappings
        " Set leader keys. Default <leader> is \ (backslash)
            let mapleader="\<space>"
            let maplocalleader="\\"

        " Leader
            " Plugin mappings

            " save, exit
            nnoremap <leader>w :w<cr>
            nnoremap <leader>ww :w!<cr>
            nnoremap <leader>q :q<cr>
            nnoremap <leader>qq :q!<cr>

            " Switch to last used buffer in the window
            nnoremap <leader><leader> <C-^>

            " Show help for <cword> under cursor.
            nnoremap <leader>sh :execute 'h ' . expand('<cword>') . ' '<cr>

            " Show help for <cWORD> under cursor.
            nnoremap <leader>hh :execute 'h ' . expand('<cWORD>') . ' '<cr>

            nnoremap <leader>o :e .<cr>

            " search and replace
            nnoremap <leader>r :%s```cg<Left><Left><Left><Left>

            " Close current buffer
            nnoremap <leader>B :bn<CR>:bd#<CR>

            " Redraw screen and update synax sync
            nnoremap <leader>u :syntax sync fromstart<cr>:redraw<cr>

            " Reload config
            nnoremap <silent> <leader>0 :so $MYVIMRC<cr>

            " Insert blank lines before, after
                nnoremap <leader><cr> mzO<ESC>`z
                nnoremap <leader><cr><cr> mzo<Esc>`z

        " Localleader
            " Toggle search highlight
            nnoremap <silent> <localleader>h :set hlsearch! hlsearch?<CR>

            " Cycle number mode
            nnoremap <silent> <localleader>n :call perers#functions#cycle_numbering()<CR>

            " Sort lines
            vnoremap <localleader>s :!sort<cr>

            " Wrap
            nnoremap <localleader>w :set wrap!<cr> :set wrap?<cr>

            " Toggle [i]nvisible characters
            nnoremap <localleader>i :set list!<cr> :set list?<cr>

            " Remove trailing whitespace...
            nnoremap <silent> <localleader>x mz :call perers#functions#trim_trailing_whitespace()<CR>`z

            " Sync clipboard over ssh
            nnoremap <silent> <localleader>y :call perers#osc52#SendViaOSC52()<CR>

            " Open scratch file
            nnoremap <localleader>z :e $SCRATCHFILE<cr>

            " Close netrw buffers
            nnoremap <silent> <localleader>o :call perers#functions#close_explorer_buffers()<cr>

    " Insert mode
        " Quick way to exit insert mode
        inoremap tn <ESC>

        " cursor one word left/right
            inoremap á <S-LEFT>
            inoremap í <S-RIGHT>

        " line down/up, to column where inserting started
            inoremap ó <C-g><Down>
            inoremap é <C-g><Up>

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
        " Open $MYVIMRC
            nnoremap <F3> :e $MYVIMRC<CR>

        " Open file exlorer
            nnoremap ó :e .<cr>

        " Next/previous match for t/f
            nnoremap _ ,
            nnoremap - ;

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
            " AltGr L
            nnoremap ø <C-w>
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
            nnoremap zO zczO

        " Indent/outdent current block...
            nmap %% $>i}``
            nmap $$ $<i}``

        " Visual Block mode is far more useful that Visual mode (so swap the commands).
            nnoremap v <C-v>
            nnoremap <C-v> v

        " Select the entire file...
            nnoremap vaa VGo1G

        " Run make
            nnoremap <silent> <F7>  :make!<cr><cr><cr>:cw<cr><cr>

        " Quickfix
            nnoremap <silent> å :cp<cr>
            nnoremap <silent> ä :cp<cr>
            nnoremap <silent> ö :cn<cr>
            nnoremap <silent> ¶ :call perers#functions#toggle_quickfix_list()<cr>

        " Locallist
            nnoremap <silent> Å :ll<cr>
            nnoremap <silent> Ä :lprevious<cr>
            nnoremap <silent> Ö :lnext<cr>
            nnoremap <silent> ° :call perers#functions#toggle_location_list()<cr>

        " Include/define jump
            nnoremap í :execute 'ij ' . expand('<cword>') . ' '<cr>
            nnoremap Í :execute 'dj ' . expand('<cword>') . ' '<cr>

        " Reselect last-pasted text
            nnoremap gp `[v`]


        " Panic Button
        "   nnoremap <F12> mzggg?G`z

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
            nnoremap á za
            nnoremap µ zm
            nnoremap ® zr


" PLUGINS ==
    " Load plugins
    packloadall!

    let g:myplugins = split(substitute(glob(g:myplugindir . '*'), g:myplugindir, '', 'g'))

    " Plugin config
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

        elseif plugin == 'nerdtree'
            nnoremap <leader>t :NERDTreeToggle<cr>

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
        au BufWritePost init.vim so %
        augroup END

    augroup applications_reload_on_config_change
        au!
        au BufWritePost */herbstluftwm/* silent !herbstclient reload
        au BufWritePost */sxhkdrc silent execute '!killall sxhkd; sxhkd &'
        augroup END

" SET COLORSCHEME
    color perers
