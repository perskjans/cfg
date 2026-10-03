-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--require("config.options")

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking text',
    group = vim.api.nvim_create_augroup('Yank Highlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})

vim.cmd.colorscheme "perers"
--vim.cmd('colorscheme perers')
local mapkey = vim.api.nvim_set_keymap
local noremap_silent = { noremap = true, silent = true }
local noremap = { noremap = true }

vim.diagnostic.config({ virtual_text = true })


vim.pack.add({
    {src = "https://github.com/kyazdani42/nvim-tree.lua"},
    {src = "https://github.com/norcalli/nvim-colorizer.lua"},
})


require("nvim-tree").setup({
    renderer = {
        icons = {
            web_devicons = {
                file = {
                    enable = false,
                    color = true,
                },
                folder = {
                    enable = false,
                    color = true,
                },
            },
            symlink_arrow = " ➛ ",
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = true,
                modified = true,
                diagnostics = true,
                bookmarks = false,
            },
            glyphs = {
                default = "",
                symlink = "",
                bookmark = "󰆤",
                modified = "●",
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    -- filters = {
    --     dotfiles = true,
    -- },
})
vim.lsp.enable({'lua_ls', 'ty', 'ruff'})

-- vim.lsp.config('*', {
--     on_attach = function (client, bufnr)
--                     local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--                     local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
--
--                     buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--                     -- Mappings.
--                     local opts = { noremap=true, silent=true }
--                     buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--                     buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
--                     buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
--                     buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--                     buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--                     buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--                     buf_set_keymap('n', '<leader>la', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)
--                     buf_set_keymap('v', '<leader>la', '<cmd>lua require("lspsaga.codeaction").range_code_action()<CR>', opts)
--                     buf_set_keymap('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--                     buf_set_keymap('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--                     buf_set_keymap('n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--                     buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--                     buf_set_keymap('n', '<leader>lr', '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
--                     buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--                     buf_set_keymap('n', '<leader>ls', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--                     buf_set_keymap('n', 'Ä', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--                     buf_set_keymap('n', 'Ö', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--                     buf_set_keymap('n', '<leader>lq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
--
--                     -- Set some keybinds conditional on server capabilities
--                     if client.resolved_capabilities.document_formatting then
--                         buf_set_keymap("n", "<F12>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--                     end
--                     if client.resolved_capabilities.document_range_formatting then
--                         buf_set_keymap("v", "<F12>", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
--                     end
--
--                     -- Set autocommands conditional on server_capabilities
--                     if client.resolved_capabilities.document_highlight then
--                         vim.api.nvim_exec([[
--                         augroup lsp_document_highlight
--                             autocmd! * <buffer>
--                             autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--                             autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--                         augroup END
--                         ]], false)
--                     end
--                     --if _G.packer_plugins["lsp_signature.nvim"].loaded == true then
--                     --  require'lsp_signature'.on_attach()
--                     --end
--                 end
-- })

-- Switch to last used buffer in the window
mapkey('n', '<leader><leader>', '<C-^>', noremap_silent)

-- search and replace
mapkey('n', '<leader>r', ':%s```cg<Left><Left><Left><Left>', noremap)

-- fuzzy finder
mapkey('n', '<leader>fb', ':Telescope buffers<CR>', noremap_silent)
mapkey('n', '<leader>fe', ':Telescope file_browser<CR>', noremap_silent)
mapkey('n', '<leader>ff', ':Telescope find_files<CR>', noremap_silent)
mapkey('n', '<leader>fh', ':Telescope help_tags<CR>', noremap_silent)
mapkey('n', '<leader>fl', ':Telescope live_grep<CR>', noremap_silent)
mapkey('n', '<leader>fs', ':Telescope grep_string<CR>', noremap_silent)
mapkey('n', '<leader>ft', ':Telescope treesitter<CR>', noremap_silent)
mapkey('n', '<leader>fgg', ':Telescope git_files<CR>', noremap_silent)
mapkey('n', '<leader>fgb', ':lua require("perers.utils").git_branches()<CR>', noremap_silent)
mapkey('n', '<leader>fgc', ':Telescope git_commits<CR>', noremap_silent)
mapkey('n', '<leader>fcc', ':lua require("telescope.builtin").find_files({ prompt_title = "< CONFIG >", cwd = vim.env.XDG_CONFIG_HOME })<CR>', noremap_silent)
mapkey('n', '<leader>fcn', ':lua require("telescope.builtin").find_files({ prompt_title = "< NVIM CONFIG >", cwd = PERERS_CONFIG_DIR })<CR>', noremap_silent)
mapkey('n', '<leader>fd', ':lua require("telescope.builtin").find_files({ prompt_title = "< NVIM DATA >", cwd = PERERS_DATA_DIR })<CR>', noremap_silent)

-- Redraw screen and update synax sync
mapkey('n', '<leader>u', ':redraw<cr>:syntax sync fromstart<cr>', noremap)

-- Remove trailing whitespace...
mapkey('n', '<localleader>x', 'mz :%s/\\s\\+$//ge<CR>`z', noremap_silent)


-- NORMAL MODE {{{
-- Save and quit
mapkey('n', '®', ':w<CR>', noremap_silent)
mapkey('n', '!®', ':w!<CR>', noremap_silent)
mapkey('n', 'ú', ':q<CR>', noremap_silent)
mapkey('n', '!ú', ':q!<CR>', noremap_silent)
mapkey('n', '«', ':x<CR>', noremap_silent)
mapkey('n', '!«', ':x!<CR>', noremap_silent)

-- Close current buffer
mapkey('n', 'ß', ':bn<CR>:bd#<CR>', noremap)
mapkey('n', '!ß', ':bn<CR>:bd!#<CR>', noremap)


-- Scroll
mapkey('n', '<C-e>', '<C-e>', noremap_silent)
mapkey('n', '<C-n>', '<C-y>', noremap_silent)

-- Movements
mapkey('n', 'é', '5k', noremap_silent)
mapkey('n', 'ñ', '5j', noremap_silent)

-- Move between open buffers
mapkey('n', 'th', ':bp<CR>', noremap_silent)
mapkey('n', 'tt', ':bn<CR>', noremap_silent)

-- Move between windows
mapkey('n', '<UP>', '<C-w>k', noremap_silent)
mapkey('n', '<DOWN>', '<C-w>j', noremap_silent)
mapkey('n', '<LEFT>', '<C-w>h', noremap_silent)
mapkey('n', '<RIGHT>', '<C-w>l', noremap_silent)

-- Folds
mapkey('n', 'za', 'zo', noremap_silent)
mapkey('n', 'zo', 'za', noremap_silent)
-- Make zO recursively open whatever fold we're in, even if it's partially open.
mapkey('n', 'zO', 'zczo', noremap_silent)

-- No Q
mapkey('n', 'Q', 'gq', noremap_silent)

-- Open $MYVIMRC
mapkey('n', '<F3>', ':e $MYVIMRC<CR>',noremap_silent)

-- Show open buffers
mapkey('n', '<F4>', ':buffers<CR>:b', noremap)

-- Reload file
mapkey('n', '<F5>', ':e<CR>', noremap)

-- Visual Block mode is far more useful that Visual mode (so swap the commands).
mapkey('n', 'v', '<C-v>', noremap_silent)
mapkey('n', '<C-v>', 'v', noremap_silent)

-- Insert blank lines before, after
mapkey('n', 'Í', 'mzO<ESC>`z', noremap_silent)
mapkey('n', 'í', 'mzo<Esc>`z', noremap_silent)

-- Keep the cursor_in place while joining lines
mapkey('n', 'J', 'mzJ`z', noremap_silent)
mapkey('n', 'gJ', 'mzgJ`z', noremap_silent)

-- Split line (sister to [J]oin lines)
-- The normal use of S is covered by cc, so don't worry about shadowing it.
mapkey('n', 'S', 'i<cr><esc>^mzgk:silent! s/\v +$//<cr>:noh<cr>`z', noremap_silent)

-- using K for hoover in LSP so remap it to keep it's standars use.
mapkey('n', 'gK', 'K', noremap)

-- Resize window
mapkey('n', '<M-1>', ':vertical resize +2<CR>', noremap_silent)
mapkey('n', '<M-2>', ':vertical resize -2<CR>', noremap_silent)
mapkey('n', '<M-3>', ':resize +2<CR>', noremap_silent)
mapkey('n', '<M-4>', ':resize -2<CR>', noremap_silent)
mapkey('n', '<M-5>', ':wincmd = <CR>', noremap_silent)

-- Select the entire file...
mapkey('n', 'vaa', 'VGo1G', noremap_silent)

-- Run makepgr
mapkey('n', '<F7>', ':make!<cr><cr><cr>:cw<cr><cr>', noremap_silent)

-- Quickfix
mapkey('n', 'å', ':call perers#functions#toggle_quickfix_list()<cr>', noremap_silent)
mapkey('n', 'ä', ':cp<cr>', noremap_silent)
mapkey('n', 'ö', ':cn<cr>', noremap_silent)
mapkey('n', '¶', ':cc<cr>', noremap_silent)

-- Locallist
mapkey('n', 'Å', ':call perers#functions#toggle_location_list()<cr>', noremap_silent)
mapkey('n', 'Ä', ':lprevious<cr>', noremap_silent)
mapkey('n', 'Ö', ':lnext<cr>', noremap_silent)
mapkey('n', '°', ':ll<cr>', noremap_silent)
--}}}

-- INSERT MODE {{{
mapkey('i', 'tn', '<ESC>', noremap_silent)

--mapkey('i', '<C-e>', '<C-p>', noremap_silent)
--mapkey('i', '<C-p>', '<C-y>', noremap_silent)
--}}}

-- VISUAL MODE {{{
mapkey('v', 'tn', '<ESC>', noremap_silent)

-- Make BS work as expected in visual modes (i.e. delete the selected text)
mapkey('v', '<BS>', 'x', noremap_silent)
--}}}

-- COMMAND MODE {{{
-- Add sudo to write
mapkey('c', 'w!!', 'w !sudo tee % >/dev/null', noremap_silent)
--}}}

-- TERMINAL {{{
mapkey('t', 'tn', '<C-\\><C-n>', noremap_silent)
--}}}




-- SETTINGS {{{

-- Settings are ordered as in :options exept for 0 that is my own grouping.

-- 0 backup, view, undo, swap {{{
if vim.env.USER == 'root' then
  vim.opt.shada = 'NONE'
  vim.opt.swapfile = false
  vim.opt.undofile = false
else
  vim.opt.swapfile = true
  vim.opt.undofile = true
end
vim.opt.backup = false
vim.opt.writebackup = false
--}}}

-- 1 important {{{
-- vim.opt.pastetoggle = '<F11>'  -- key sequence to toggle paste mode
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


--}}}
