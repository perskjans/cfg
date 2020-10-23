scriptencoding utf-8

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
else
    let $VIMDIR = $XDG_CONFIG_HOME . '/nvim'
    let $VIMTMP = $XDG_CACHE_HOME . '/nvim'
    let $MYVIMRC = $VIMDIR . '/init.vim'
endif

if !exists('$SUDO_USER')
    silent execute "!mkdir -m 777 -p " . shellescape(expand($VIMTMP)) . "/{swap,undo,backup,view}"
endif

if !exists('SCRATCHFILE')
    let $SCRATCHFILE = $VIMTMP . "/scratch.txt"     " Scratchfile for tmp usage
endif

let $PLUGINSDIR = $VIMDIR . "/pack/plugins/start"

set runtimepath^=$VIMDIR
set runtimepath+=$VIMDIR/after

if v:progname == 'vi'
    set noloadplugins
else
    set nocompatible        " No compatibility with Vi
endif

" PLUGINS ===
    if &loadplugins
        " This file contains all plugin handling and setting of key mapping for
        " pluggins. All other key mappings are set in the mappings_*.vim files.

        " Call plug#begin()
        " alternatively, pass a path where plug should install plugins
        call plug#begin($PLUGINSDIR)

        Plug 'vim-airline/vim-airline'
            let g:airline#extensions#tabline#enabled = 1

        "Plug 'guns/xterm-color-table.vim'

        Plug 'mcchrish/nnn.vim'
            " Show dotfiles
            let g:nnn#command = 'nnn -H'

        "Plug 'embear/vim-foldsearch'

        "Plug 'neoclide/coc.nvim', {'branch': 'release'}

        Plug 'vim-scripts/AutoComplPop'

        "Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
        "    let g:Hexokinase_highlighters = ['backgroundfull']
        "    let g:Hexokinase_optInPatterns = 'full_hex,triple_hex,rgb,rgba,hsl,hsla,colour_names'

        Plug 'lilydjwg/colorizer'

        "Plug 'yggdroot/indentline'
            let g:indentLine_char = '|'
            let g:indentLine_noConcealCursor=""

        "Plug 'easymotion/vim-easymotion'

        "Plug 'pangloss/vim-javascript'

        "Plug 'leafgarland/typescript-vim'

        Plug 'Dreiparrent/vim-json'
            let g:vim_json_syntax_conceal = 0
            let g:vim_json_syntax_concealcursor = 0

        Plug 'frazrepo/vim-rainbow'
            let g:rainbow_active = 1

        Plug 'airblade/vim-gitgutter'

        "Plug 'ctrlpvim/ctrlp.vim'
        "    let g:ctrlp_map = '<leader>f'
        "    let g:ctrlp_cmd = 'CtrlPMixed'
        "    let g:ctrlp_clear_cache_on_exit = 0
        "    let g:ctrlp_working_path_mode = 'rw'
        "    let g:ctrlp_show_hidden = 1

        Plug 'xuyuanp/nerdtree-git-plugin'

        "Plug 'scrooloose/syntastic'

        Plug 'scrooloose/nerdtree'
            nnoremap þ :NERDTreeToggle<cr>
            let g:NERDTreeBookmarksFile = $VIMTMP . '/tmp/NERDTreeBookmarks'
            let g:NERDTreeDirArrowExpandable = '+'
            let g:NERDTreeDirArrowCollapsible = '-'
            let NERDTreeHijackNetrw=1
            autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

        "Plug 'tpope/vim-vinegar'
            let g:netrw_home=$VIMTMP
            "let g:netrw_banner=1 " Disable annoying banner
            let g:netrw_browser_split=4 " Open in prior window
            let g:netrw_altv=1 " Open splits to the right
            let g:netrw_liststyle=3 " Tree view
            "let g:netrw_list_hide=netrw_gitignore#Hide()
            "let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'

        Plug 'tpope/vim-fugitive'

        "Plug 'tpope/vim-commentary'

        "Plug 'tpope/vim-surround'

        "Plug 'richsoni/vim-ecliptic'

        "Plug 'msanders/snipmate.vim'

        "Plug 'rhysd/vim-clang-format'

        Plug 'andviro/flake8-vim'
            let g:PyFlakeOnWrite = 1
            let g:PyFlakeCheckers = 'pep8'
            let g:PyFlakeAggressive = 0
            let g:PyFlakeDisabledMessages = 'E262,E265,E402,E501'

        ""Plug 'klen/python-mode'
        "    "map <Leader>g :call RopeGotoDefinition()<CR>
        "    "let ropevim_enable_shortcuts = 1
        "    "let g:pymode_rope_goto_def_newwin = 'vnew'
        "    "let g:pymode_rope_extended_complete = 1
        "    "let g:pymode_breakpoint = 1
        "    "let g:pymode_sytax = 1
        "    "let g:pymode_sytax_builtin_objs = 1
        "    "let g:pymode_sytax_builtin_funcs = 1
        "    "map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>


        "All of your Plugins must be added before the following line
        call plug#end()            " required
        endif

    " For future use
        "if &loadplugins
        "  if has('packages')
        "    packadd! applescript.vim
        "    packadd! base16-vim
        "    packadd! command-t
        "    packadd! corpus
        "    packadd! deoplete-lsp
        "    packadd! ferret
        "    packadd! loupe
        "    packadd! neco-ghc
        "
        "    if has('nvim')
        "      packadd! nvim-lspconfig
        "    endif
        "
        "    packadd! pinnacle
        "    packadd! replay
        "    packadd! scalpel
        "    packadd! tcomment_vim
        "    packadd! terminus
        "    packadd! typescript-vim
        "    packadd! ultisnips
        "    packadd! vcs-jump
        "    packadd! vim-ansible-yaml
        "    packadd! vim-clipper
        "    packadd! vim-dirvish
        "    packadd! vim-dispatch
        "    packadd! vim-docvim
        "    packadd! vim-easydir
        "    packadd! vim-eunuch
        "    packadd! vim-fugitive
        "    packadd! vim-git
        "    packadd! vim-javascript
        "    packadd! vim-json
        "    packadd! vim-jsx
        "    packadd! vim-lion
        "    packadd! vim-markdown
        "    packadd! vim-operator-user
        "    packadd! vim-projectionist
        "    packadd! vim-reason-plus
        "    packadd! vim-repeat
        "    packadd! vim-signature
        "    packadd! vim-slime
        "    packadd! vim-soy
        "    packadd! vim-speeddating
        "    packadd! vim-surround
        "    packadd! vim-textobj-comment
        "    packadd! vim-textobj-rubyblock
        "    packadd! vim-textobj-user
        "    packadd! vim-zsh
        "  else
        "    source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim
        "    call pathogen#infect('pack/bundle/opt/{}')
        "  endif
        "endif


" SETTINGS ===
    " Backup, view, undo, swap
        if has('viminfo') " ie. Vim.
            let s:viminfo='viminfo'
        elseif has('shada') " ie. Neovim.
            let s:viminfo='shada'
        endif

        if exists('s:viminfo')
            if exists('$SUDO_USER')
                set nobackup                        " don't create root-owned files
                set nowritebackup                   " don't create root-owned files
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

                "                              +--Disable hlsearch while loading 
                "                              viminfo
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

        set noswapfile  " Never use swap files

    " Bell
        if exists('&belloff')
            set belloff=all                     " never ring the bell for any reason
        endif

    " Line endings
        set fileformats=unix,mac,dos        "Handle Mac and DOS line-endings but prefer Unix endings
        "

    " Indentation
        set autoindent     " Retain indentation on next line
        set smartindent    " Turn on autoindenting of blocks
        set tabstop=4      " Spaces per tab
        set shiftwidth=4   " Spaces per tab when indenting/outdenting
        set expandtab      " Convert all tabs that are typed into spaces
        set shiftround     " Always indent/outdent to nearest tabstop
        set smarttab       " <tab>/<BS> indent/dedent in leading whitespace

        if v:progname !=# 'vi'
            set softtabstop=-1  " use 'shiftwidth' for tab/bs at end of line
        endif

    " Visual setting
        set colorcolumn=81

        set synmaxcol=300                   " Don't try to highlight lines longer than 800 characters.

        set wrap                            " Wrap lines longer than window width
        set whichwrap=b,s,<,>,[,],~         " allow <BS>/<Space>/<Left>/<Right>, ~ to cross line boundaries

        set textwidth=80                    " automatically hard wrap at 80 columns

        set linebreak                       " wrap long lines at characters in 'breakat'

        set noemoji                         " don't assume all emoji are double width

        set nojoinspaces                    " don't autoinsert two spaces after '.', '?', '!' for join command

        set formatoptions=1     " Don't break a line after a one-letter word.  It's broken before it instead (if possible).
        set formatoptions+=2    " When formatting text, use the indent of the second line of a paragraph for the rest of the paragraph, instead of the indent of the first line.
        "set formatoptions+=B   " When joining lines, don't insert a space between two multi-byte characters.  Overruled by the 'M' flag.
        set formatoptions+=M    " When joining lines, don't insert a space before or after a multi-byte character.  Overrules the 'B' flag.
        set formatoptions+=a    " Automatic formatting of paragraphs. Every time text is inserted or deleted the paragraph will be reformatted. See (auto-format). When the 'c' flag is present this only happens for recognized comments.
        set formatoptions+=b    " Like 'v', but only auto-wrap if you enter a blank at or before the wrap margin.
        set formatoptions+=c    " Auto-wrap comments using textwidth, inserting the current comment leader automatically.
        set formatoptions+=j    " remove comment leader when joining comment lines
        set formatoptions+=l    " Long lines are not broken in insert mode: When a line was longer than 'textwidth' when the insert command started, Vim does not automatically format it.
        "set formatoptions+=m   " Also break at a multi-byte character above 255. This is useful for Asian text where every character is a word on its own.
        set formatoptions+=n    " smart auto-indenting inside numbered lists
        "set formatoptions+=o   " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
        set formatoptions+=p    " Don't break lines at single spaces that follow periods.
        set formatoptions+=q    " Allow formatting of comments with 'gq'. Note that formatting will not change blank lines or lines containing only the comment leader. A new paragraph starts after such a line, or when the comment leader changes.
        set formatoptions+=r    " Automatically insert the current comment leader after hitting <Enter> in Insert mode.
        set formatoptions+=w    " Trailing white space indicates a paragraph continues in the next line. A line that ends in a non-white character ends a paragraph.

        "set fillchars=diff:∙        " BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
        "set fillchars+=fold:·       " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
        "set fillchars+=vert:┃       " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
        "set fillchars+=eob:\        " suppress ~ at EndOfBuffer

    " Make naughty characters visible...
        set list                    " show whitespace

        "set showbreak=↪
        "set listchars=tab:▸-▸
        "set listchars+=extends:❯
        "set listchars+=precedes:❮
        "set listchars+=trail:«
        "set listchars+=nbsp:»

        let &showbreak=' ¬ '
        set listchars=tab:¦»
        set listchars+=extends:»
        set listchars+=precedes:«
        set listchars+=trail:°
        set listchars+=nbsp:÷
        "set listchars+=eol:¶

        "let &showbreak='↳ '         " DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
        "set listchars=nbsp:⦸        " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
        "set listchars+=tab:▷┅       " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
        "set listchars+=extends:»    " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
        "set listchars+=precedes:«   " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
        "set listchars+=trail:•      " BULLET (U+2022, UTF-8: E2 80 A2)

        syntax on

        if has('termguicolors')
             set termguicolors                   " use guifg/guibg instead of ctermfg/ctermbg in terminal
        endif

        set ruler
        set lazyredraw                        " don't bother updating screen during macro playback
        set cursorline                        " highlight current line
        set number                            " show line numbers in gutter
        set relativenumber                    " show relative numbers in gutter

    " Miscellaneous
        filetype plugin indent on

        set path+=**

        set switchbuf=usetab                  " try to reuse windows/tabs when switching buffers

        set scrolloff=5                       " start scrolling N lines before edge of viewport
        set sidescroll=0                      " sidescroll in jumps because terminals are slow
        set sidescrolloff=5                   " same as scrolloff, but for columns
        set shell=$SHELL                      " shell to use for `!`, `:!`, `system()` etc.

        set shortmess+=A                      " ignore annoying swapfile messages
        set shortmess+=I                      " no splash screen
        set shortmess+=O                      " file-read message overwrites previous
        set shortmess+=T                      " truncate non-file messages in middle
        set shortmess+=W                      " don't echo "[w]"/"[written]" when writing
        set shortmess+=a                      " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
        set shortmess+=c                      " completion messages
        set shortmess+=o                      " overwrite file-written messages
        set shortmess+=t                      " truncate file messages at start

        set showcmd
        set hidden                            " allows you to hide buffers with unsaved changes without being prompted
        set visualbell t_vb=                  " stop annoying beeping for non-error errors
        set ttyfast
        set backspace=indent,start,eol        " allow unrestricted backspacing in insert mode
        set history=1000
        set undoreload=10000

        set matchtime=3
        set splitbelow                      " open horizontal splits below current window
        set splitright                      " open vertical splits to the right of the current window
        set pastetoggle=<F2>
        "set clipboard=unnamedplus
        set noautochdir

        set notimeout
        set ttimeout
        set ttimeoutlen=10

        set complete=.,w,b,u,t
        set completeopt=menuone,longest,preview

        " Save when losing focus
        au FocusLost * :silent! wall

        " Resize splits when the window is resized
        au VimResized * :wincmd =

        "=====[ Setglobal relativenumber ]=====
        autocmd WinEnter * :setlocal relativenumber
        autocmd WinLeave,FocusLost * :setlocal number norelativenumber
        autocmd InsertEnter * :setlocal number
        autocmd InsertLeave * :setlocal relativenumber

        " Highlight VCS conflict markers
        match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

        " Open Quickfix window automatically after running :make
        augroup OpenQuickfixWindowAfterMake
            autocmd!
            autocmd QuickFixCmdPost [^l]* nested cwindow
            autocmd QuickFixCmdPost    l* nested lwindow
            autocmd FileType qf wincmd J
        augroup END


        "Square up visual selections...
        set virtualedit=block               " allow cursor to move where there is no text in visual block mode

        "=====[ Miscellaneous features (mainly options) ]=====================

        set title           "Show filename in titlebar of window
        set titleold=

        set nomore          "Don't page long listings

        set autowrite       "Save buffer automatically when changing files
        set autoread        "Always reload buffer when external changes detected


        set ignorecase          "Case insensitive search
        set smartcase           "Case sensitive search if word starts with upercase letter
        set infercase           "Adjust completions to match case

        set showmode            "Show mode change messages
        set modelines=5         " scan this many lines looking for modeline

        set updatecount=80      "Save buffer every 10 chars typed
        set updatetime=2000     "If this many milliseconds nothing is typed the swap file will be written to disk, see (crash-recovery). Also used for the (CursorHold) autocommand event.


        " Keycodes and maps timeout in 3/10 sec...
        set timeout timeoutlen=300 ttimeoutlen=300


        " Spelling
        "
        " There are three dictionaries I use for spellchecking:
        "
        "   /usr/share/dict/words
        "   Basic stuff.
        "
        "   ~/.vim/custom-dictionary.utf-8.add
        "   Custom words (like my name).  This is in my (version-controlled) dotfiles.
        "
        "   ~/.vim-local-dictionary.utf-8.add
        "   More custom words.  This is *not* version controlled, so I can stick
        "   work stuff in here without leaking internal names and shit.
        "
        " I also remap zG to add to the local dict (vanilla zG is useless anyway).
        set dictionary=/usr/share/dict/words
        "set spellfile=~/.vim/custom-dictionary.utf-8.add,~/.vim/local-dictionary.utf-8.add
        nnoremap zG 2zg

    " Wildmenu completion
        set wildmenu                        " show options as list when switching buffers etc
        set wildmode=list:longest,full      "Show list of completions and complete as much as possible, then iterate full completions

        set wildignore+=*/tmp/*,*.so,*.swp,*.zip           " MacOSX/Linux
        set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.bak  " Windows
        set wildignore+=.hg,.git,.svn,*.fossil             " Version control
        set wildignore+=*.aux,*.out,*.toc                  " LaTeX intermediate files
        set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg     " binary images
        set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest   " compiled object files
        set wildignore+=*.spl                              " compiled spelling word lists
        set wildignore+=*.DS_Store                         " OSX bullshit
        set wildignore+=*.luac                             " Lua byte code
        set wildignore+=migrations                         " Django migrations
        set wildignore+=*.pyc                              " Python byte code
        set wildignore+=*.orig                             " Merge resolution files
        set wildignore+=bin                                " files in bin folder
        set wildignore+=nbproject                          " Netbeans project folder
        set wildignore+=external                           " folders for external dependecies

    " Statusline
        set laststatus=2                      " always show status line
        "

    " Foldin settings
        set foldmethod=indent               " not as cool as syntax, but faster
        set foldlevelstart=99               " start unfolded
        set foldnestmax=4
        let g:FoldMethod = 0


" ABBREVIATIONS ===
    "=====[ Correct common mistypings in-the-fly ]=======================
    iab     flase  false
    iab    retrun  return
    iab     pritn  print
    iab       teh  the
    iab      liek  like
    iab        ;t  't
    iab      moer  more
    iab  previosu  previous


" MAPPINGS ===
    " Command mode
        cnoremap fn find

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
            nnoremap <leader>b :bd<CR>

            " Redraw screen and update synax sync
            nnoremap <leader>u :syntax sync fromstart<cr>:redraw!<cr>

            " Clear mappings and reload config
            nnoremap <silent> <leader>0 :mapclear<cr>:imapclear<cr>:so $MYVIMRC<cr>

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


        " Move between open buffers
            nnoremap th :bp<CR>
            nnoremap tt :bn<CR>

        " Movement
            nnoremap ä <C-u> " Half page up
            nnoremap Ä <C-b> " Full page up
            nnoremap ç <C-d> " Half page down
            nnoremap Ç <C-f> " Full page down

            nnoremap <A-e> gkzz
            nnoremap <A-n> gjzz
            nnoremap k gk
            nnoremap j gj
            nnoremap œ 5gk
            nnoremap ï 5gj
            nnoremap é {zz
            nnoremap ñ }zz

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
            nnoremap <silent> ¹ :vertical resize +2<cr>
            nnoremap <silent> ² :vertical resize -2<cr>
            nnoremap <silent> ³ :resize +2<cr>
            nnoremap <silent> ¤ :resize -2<cr>
            nnoremap <silent> € :wincmd =<cr>

        " Show open buffers
            nnoremap <F4> :buffers<CR>:b
            nnoremap í :buffers<CR>:b

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
            nnoremap <silent> <F8>  :cp<cr>
            nnoremap <silent> <F9>  :cn<cr>
            nnoremap <silent> <F10> :call perers#functions#toggle_quicktfix_window()<cr>


        " Reselect last-pasted text
            nnoremap gp `[v`]


        " Panic Button
            nnoremap <F12> mzggg?G`z

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


" AUTO COMMANDS ===
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
        au BufWinLeave *,*.* silent mkview
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
        au BufWritePost *vim/*.vim so $MYVIMRC
        augroup END

    augroup applications_reload_on_config_change
        au!
        au BufWritePost */herbstluftwm/* silent !herbstclient reload
        au BufWritePost */sxhkdrc silent execute '!pkill sxhkd; sxhkd &'
        augroup END

    augroup quickfix
        au!
        au BufReadPost quickfix let g:qfix_win = 1
        augroup END

color perers


"+++++++++++++++++++++++++++++++++++
    " set diffopt+=foldcolumn:0   " don't show fold column in diff view
    "
    " if exists('&inccommand')
    "     set inccommand=split    " live preview of :s results
    " endif
    "
    " set noshowcmd               " don't show extra info at end of command line
    "
    " set spellcapcheck=          " don't check for capital letters at start of sentence
    "
    " set swapsync=               " let OS sync swapfiles lazily
    "
    " set wildcharm=<C-z>          " substitute for 'wildchar' (<Tab>) in macros
