-- Settings are ordered as in :options exept for 0 that is my own grouping.

-- 0 backup, view, undo, swap {{{
if vim.env.USER == 'root' then
  vim.opt.shada = 'NONE'
  vim.opt.swapfile = false
  vim.opt.undofile = false
else
  vim.opt.backup = true
  vim.opt.swapfile = true
  vim.opt.undofile = true
end

vim.opt.backup = false
vim.opt.writebackup = false
--}}}

-- 1 important {{{
--}}}

-- 2 moving around, searching and patterns {{{
vim.opt.whichwrap = 'b,s,<,>,[,],~'  -- list of flags specifying which commands wrap to another line
                                     -- allow <BS>/<Space>/<Left>/<Right>, ~ to cross line boundaries
vim.opt.path = '.,**,/usr/include,,' -- list of directory names used for file searching (global or local to buffer)
vim.opt.startofline = false          -- many jump commands move the cursor to the first non-blank character of a line
vim.opt.ignorecase = true            -- ignore case when using a search pattern
vim.opt.smartcase = true             -- override 'ignorecase' when pattern has upper case characters
vim.opt.autochdir = false            -- change to directory of file in buffer
vim.opt.wrapscan = true              -- search commands wrap around the end of the buffer
vim.opt.incsearch = true             -- show match for partly typed search command
--}}}

-- 4 displaying text {{{
vim.opt.scrolloff = 8          -- number of screen lines to show around the cursor
vim.opt.wrap = true            -- long lines wrap (local to window)
vim.opt.linebreak = true       -- wrap long lines at a character in 'breakat' (local to window)
vim.opt.showbreak = ' ¬ '      -- string to put before wrapped screen lines
vim.opt.sidescrolloff = 5      -- minimal number of columns to keep left and right of the cursor

vim.opt.fillchars = ''         -- characters to use for the status line, folds and filler lines
               .. 'eob: '      -- suppress ~ at EndOfBuffer

vim.opt.lazyredraw = true      -- don't redraw while executing macros
vim.opt.list = true            -- show listchars

vim.opt.listchars = ""         -- list of strings used for list mode
             --.. 'eol:¶'
               .. 'extends:»,'
               .. 'nbsp:÷,'
               .. 'precedes:«,'
               .. 'tab:¦»,'
               .. 'trail:°,'

vim.opt.number = true          -- show the line number for each line (local to window)
vim.opt.relativenumber = true  -- show the relative line number for each line (local to window)
vim.opt.conceallevel = 0       -- controls whether concealable text is hidden (local to window)
--}}}

-- 5 syntax, highlighting and spelling {{{
vim.opt.synmaxcol = 1000       -- maximum column to look for syntax items (local to buffer)
vim.opt.hlsearch = true        -- highlight all matches for the last used search pattern
vim.opt.termguicolors = true   -- use GUI colors for the terminal
vim.opt.cursorline = true      -- highlight the screen line of the cursor (local to window)
vim.opt.colorcolumn = '81'     -- colorcolumn  columns to highlight (local to window)
vim.opt.spelllang = 'en_us,sv' -- list of accepted languages (local to buffer)
--}}}

-- 6 multiple windows {{{
vim.opt.laststatus = 2         -- when to use a status line for the last window
vim.opt.hidden = true          -- hidden  don't unload a buffer when no longer shown in a window
vim.opt.switchbuf = 'useopen'  -- try to reuse windows/tabs when switching buffers
vim.opt.splitbelow = true      -- a new window is put below the current one
vim.opt.splitright = true      -- a new window is put right of the current one
--}}}

-- 7 multiple tab pages {{{
vim.opt.showtabline = 1        -- 0, 1 or 2; when to use a tab pages line
--}}}

-- 8 terminal {{{
vim.opt.title = true           -- show info in the window title
--}}}

-- 11 messages and info {{{
--     shortmess  list of flags to make messages shorter (default filnxtToOF)
vim.opt.shortmess = ''
               .. 'A'       -- ignore annoying swapfile messages
               .. 'I'       -- no splash screen
               .. 'O'       -- file-read message overwrites previous
               .. 'T'       -- truncate non-file messages in middle
             --.. 'W'       -- don't echo "[w]"/"[written]" when writing
               .. 'a'       -- use abbreviations in messages eg. `[RO]` instead of `[readonly]`
               .. 'c'       -- don't give [ins-completion-menu] messages
               .. 'o'       -- overwrite file-written messages
               .. 't'       -- truncate file messages at start

vim.opt.ruler = true        -- show cursor position below each window
--}}}

-- 13 editing text {{{
--vim.opt.textwidth = 79               -- line length above which to break a line (local to buffer)
vim.opt.wrapmargin = 5                 -- margin from the right in which to break a line (local to buffer)
vim.opt.backspace = 'indent,eol,start' -- backspace  specifies what <BS>, CTRL-W, etc. can do in Insert mode

vim.opt.formatoptions = ''           -- list of flags that tell how automatic formatting works (local to buffer)
                      .. '1'           -- Don't break a line after a one-letter word.  It's broken before it instead (if possible).
                      .. '2'           -- When formatting text, use the indent of the second line of a paragraph for the rest of the paragraph, instead of the indent of the first line.
                      .. 'B'           -- When joining lines, don't insert a space between two multi-byte characters.  Overruled by the 'M' flag.
                      .. 'M'           -- When joining lines, don't insert a space before or after a multi-byte character.  Overrules the 'B' flag.
                      .. 'b'           -- Like 'v', but only auto-wrap if you enter a blank at or before the wrap margin.
                    --.. 'c'           -- Auto-wrap comments using textwidth, inserting the current comment leader automatically.
                      .. 'j'           -- remove comment leader when joining comment lines
                      .. 'l'           -- Long lines are not broken in insert mode: When a line was longer than 'textwidth' when the insert command started, Vim does not automatically format it.
                    --.. 'm'           -- Also break at a multi-byte character above 255. This is useful for Asian text where every character is a word on its own.
                      .. 'n'           -- smart auto-indenting inside numbered lists
                    --.. 'o'           -- Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
                      .. 'p'           -- Don't break lines at single spaces that follow periods.
                      .. 'q'           -- Allow formatting of comments with 'gq'. Note that formatting will not change blank lines or lines containing only the comment leader. A new paragraph starts after such a line, or when the comment leader changes.
                      .. 'r'           -- Automatically insert the current comment leader after hitting <Enter> in Insert mode.
                    --.. 't'           -- Auto-wrap text using textwidth
                      .. 'w'           -- Trailing white space indicates a paragraph continues in the next line. A line that ends in a non-white character ends a paragraph.

vim.opt.complete = '.,w,b,u,U,t,i,d'   -- specifies how Insert mode completion works for CTRL-N and CTRL-P (local to buffer)

vim.opt.completeopt = 'menuone,preview,noinsert,noselect' -- whether to use a popup menu for Insert mode completion
vim.opt.pumheight = 20                  -- pumheight  maximum height of the popup menu
vim.opt.pumwidth = 100                  -- pumheight  maximum width of the popup menu
vim.opt.infercase = false               -- adjust case of a keyword completion match (local to buffer)
vim.opt.joinspaces = false              -- use two spaces after '.', '?', '!' when joining a line.
--}}}

-- 14 tabs and indenting {{{
vim.opt.tabstop = 4         -- number of spaces a <Tab> in the text stands for (local to buffer)
vim.opt.shiftwidth = 4      -- number of spaces used for each step of (auto)indent (local to buffer)
vim.opt.softtabstop = -1    -- if non-zero, number of spaces to insert for a <Tab>. If negative use shiftwidth (local to buffer)
vim.opt.shiftround = true   -- round to 'shiftwidth' for "<<" and ">>"
vim.opt.expandtab = true    -- expand <Tab> to spaces in Insert mode (local to buffer)
vim.opt.autoindent = true   -- automatically set the indent of a new line (local to buffer)
vim.opt.smartindent = true  -- do clever autoindenting (local to buffer)
--}}}

-- 15 folding {{{

vim.opt.foldlevelstart = 99    --  value for 'foldlevel' when starting to edit a file
vim.opt.foldmethod = 'marker'  -- indent, manual, marker, syntax
vim.opt.foldnestmax = 4        -- maximum fold depth for when 'foldmethod' is "indent" or "syntax" (local to window)
--}}}

-- 18 reading and writing files {{{
vim.opt.modelines = 5                                -- number of lines to check for modelines
vim.opt.fileformat = 'unix'                          -- end-of-line format: "dos", "unix" or "mac" (local to buffer)
vim.opt.fileformats  = 'unix,mac,dos'                -- list of file formats to look for when editing a file (local to buffer)
vim.opt.backupskip = '/tmp/*,/private/tmp/*'         -- patterns that specify for which files a backup is not made
vim.opt.backupdir = '$XDG_DATA_HOME/nvim/backup/,.'  -- list of directories to put backup files in
vim.opt.autowrite = true                             -- automatically write a file when leaving a modified buffer
vim.opt.autoread = true                              -- automatically read a file when it was modified outside of Vim (global or local to buffer)
--}}}

-- 20 command line editing {{{
vim.opt.wildmode = 'longest,full'
vim.opt.wildignore = ''                                  -- list of patterns to ignore files for file name completion
                .. '/tmp/*,*.bak,*.so,*.swp,*.zip,'      -- MacOSX/Linux
                .. '*\\tmp\\*,'                          -- Windows
                .. '.hg,.git,.svn,.fossil,'              -- Version control
                .. '*.aux,*.out,*.toc,'                  -- LaTeX intermediate files
                .. '*.jpg,*.bmp,*.gif,*.png,*.jpeg,'     -- binary images
                .. '*.o,*.obj,*.exe,*.dll,*.manifest,'   -- compiled object files
                .. '*.spl,'                              -- compiled spelling word lists
                .. '*.DS_Store,'                         -- OSX bullshit
                .. '*.luac,'                             -- Lua byte code
                .. 'migrations,'                         -- Django migrations
                .. '__pycache__,*__pycache__/*,*.pyc,'   -- Python byte code
                .. '*.orig,'                             -- Merge resolution files
                .. 'bin,'                                -- files in bin folder
                .. 'nbproject,'                          -- Netbeans project folder
                .. 'external,'                           -- folders for external dependecies
--}}}

-- 23 language specific {{{
vim.o.iskeyword = vim.o.iskeyword   -- specifies the characters in a keyword (local to buffer)
                .. ',-'          -- treat dash separated words as a word text object
--}}}

-- 24 multi-byte characters {{{
vim.opt.fileencoding = "utf-8"      -- encoding for the current file (local to buffer)
--}}}

-- 25 various {{{
vim.opt.viewoptions = 'folds,cursor,curdir'
vim.opt.virtualedit = 'block'  -- when to use virtual editing: "block", "insert" and/or "all"
vim.opt.signcolumn = "yes"     -- whether to show the signcolumn (local to window)
vim.opt.foldnestmax = 4        -- maximum fold depth for when 'foldmethod' is "indent" or "syntax" (local to window)
vim.opt.pyxversion = 3         -- whether to use Python 2 or 3
--}}}

