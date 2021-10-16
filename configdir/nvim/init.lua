

--==============================================================================
-- GLOBALS {{{

PERERS_CACHE_DIR =  vim.fn.stdpath('cache')
PERERS_CONFIG_DIR =  vim.fn.stdpath('config')
PERERS_DATA_DIR  =  vim.fn.stdpath('data')
PERERS_PLUGIN_DIRECTORY = string.format('%s/site/pack/packer/start/', PERERS_DATA_DIR)
PERERS_LOCAL_BIN = vim.env.XDG_DATA_HOME .. '/../bin'

-- Map leader keys before loading plugins and setting key mappings
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.opt.termguicolors = true
vim.cmd('colorscheme perers')
--}}}
--==============================================================================

--==============================================================================
-- FIRST RUN {{{
if  require('perers.first_load')() then
    return
end

--}}}
--==============================================================================

--==============================================================================
-- SETTINGS {{{

-- Settings are ordered as in :options exept for 0 that is my own grouping.

-- 0 backup, view, undo, swap {{{
if vim.env.USER == 'root' then
  vim.opt.backup = false
  vim.opt.shada = 'NONE'
  vim.opt.swapfile = false
  vim.opt.undofile = false
  vim.opt.writebackup = false
else
  vim.opt.swapfile = true
  vim.opt.undofile = true
  vim.opt.writebackup = true
end
--}}}

-- 1 important {{{
vim.opt.pastetoggle = '<F11>'  -- key sequence to toggle paste mode
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
vim.opt.wrap = false           -- long lines wrap (local to window)
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
vim.wo.t_Co = "256"            -- Support 256 colors
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
vim.opt.wildmode = 'list:longest,full'                   -- specifies how command line completion works
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
--==============================================================================

--==============================================================================
-- PLUGINS {{{

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

require('packer').startup(function(use)
    use {'wbthomason/packer.nvim'}

    -- Information
    -- use {'nanotee/nvim-lua-guide'}

    -- Quality of life improvements
    -- use {'norcalli/nvim_utils'}

    -- LSP
    use {"kabouzeid/nvim-lspinstall"}
    use {'neovim/nvim-lspconfig'}
    use {'glepnir/lspsaga.nvim'}
    -- use {'onsails/lspkind-nvim'}
    -- use {'kosayoda/nvim-lightbulb'}

    -- Debugging
    use {'mfussenegger/nvim-dap'}
    use {'mfussenegger/nvim-dap-python'}
    use {'nvim-telescope/telescope-dap.nvim'}
    use {'theHamsta/nvim-dap-virtual-text'}
    use {'rcarriga/nvim-dap-ui'}
    -- use {'mfussenegger/nvim-jdtls'}

    -- Autocomplete
    -- use {'ray-x/lsp_signature.nvim'}

    use {'hrsh7th/nvim-cmp'}
    use {'hrsh7th/cmp-buffer'}
    use {'hrsh7th/cmp-nvim-lsp'}
    use {'hrsh7th/cmp-path'}
    use {'hrsh7th/cmp-omni'}
    use {'f3fora/cmp-spell'}
    -- use {'hrsh7th/vim-vsnip'}
    -- use {'hrsh7th/vim-vsnip-integ'}
    -- use {'SirVer/ultisnips'}
    -- use {'norcalli/snippets.nvim'}

    -- Json
    --use {'gennaro-tedesco/nvim-jqx'}

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    -- use {'nvim-treesitter/playground'}
    -- use {'p00f/nvim-ts-rainbow'}

    -- Icons
     use {'kyazdani42/nvim-web-devicons'}
    -- use {'ryanoasis/vim-devicons'}

    -- Status Line and Bufferline
    -- use {'glepnir/galaxyline.nvim'}
    -- use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'}
    -- use {'romgrk/barbar.nvim'}

    -- Telescope
    use {'nvim-lua/popup.nvim'}
    use {'nvim-lua/plenary.nvim'}
    use {'nvim-telescope/telescope.nvim'}
    use {'nvim-telescope/telescope-media-files.nvim'}
    use {'nvim-telescope/telescope-fzy-native.nvim'}

    -- Explorer
    use {'kyazdani42/nvim-tree.lua'}

    -- Statusline
    use {'vim-airline/vim-airline'}

    -- Color
    use {'norcalli/nvim-colorizer.lua'}

    -- Misc
    use {'tpope/vim-commentary'}

    -- Git
    --use {'TimUntersberger/neogit'}
    use {'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    --use {'f-person/git-blame.nvim'}
    use {'tpope/vim-fugitive'}
    --use {'tpope/vim-rhubarb'}

    -- General Plugins
    use {"ellisonleao/glow.nvim"}
    --use {'windwp/nvim-autopairs'}
    --use {'kevinhwang91/nvim-bqf'}
    --use {'unblevable/quick-scope'}
    --use {'mhinz/vim-startify'}
    --use {'psliwka/vim-smoothie'}
    --use {'liuchengxu/vim-which-key'}
    --use {'voldikss/vim-floaterm'}
    --use {'phaazon/hop.nvim'}
end)


--}}}
--==============================================================================

--==============================================================================
-- KEY MAPPINGS {{{
local mapkey = vim.api.nvim_set_keymap
local noremap_silent = { noremap = true, silent = true }
local noremap = { noremap = true }

-- LEADER {{{
-- Language server
mapkey('n', '<leader>li', ':LspInfo<CR>', noremap_silent)

-- Switch to last used buffer in the window
mapkey('n', '<leader><leader>', '<C-^>', noremap_silent)

-- search and replace
mapkey('n', '<leader>r', ':%s```cg<Left><Left><Left><Left>', noremap)

-- explorer
--mapkey('n', '<leader>et', ':NvimTreeToggle<CR>', noremap_silent)
mapkey('n', '<leader>et', ':NvimTreeToggle<CR>', noremap_silent)


-- fuzzy finder
mapkey('n', '<leader>fb', ':Telescope buffers<CR>', noremap_silent)
mapkey('n', '<leader>fe', ':Telescope file_browser<CR>', noremap_silent)
mapkey('n', '<leader>ff', ':Telescope find_files<CR>', noremap_silent)
mapkey('n', '<leader>fh', ':Telescope help_tags<CR>', noremap_silent)
mapkey('n', '<leader>ft', ':Telescope treesitter<CR>', noremap_silent)
mapkey('n', '<leader>fgg', ':Telescope git_files<CR>', noremap_silent)
mapkey('n', '<leader>fgb', ':lua require("perers.utils").git_branches()<CR>', noremap_silent)
mapkey('n', '<leader>fgc', ':Telescope git_commits<CR>', noremap_silent)
mapkey('n', '<leader>fcc', ':lua require("telescope.builtin").find_files({ prompt_title = "< CONFIG >", cwd = vim.env.XDG_CONFIG_HOME })<CR>', noremap_silent)
mapkey('n', '<leader>fcn', ':lua require("telescope.builtin").find_files({ prompt_title = "< NVIM CONFIG >", cwd = PERERS_CONFIG_DIR })<CR>', noremap_silent)
mapkey('n', '<leader>fd', ':lua require("telescope.builtin").find_files({ prompt_title = "< NVIM DATA >", cwd = PERERS_DATA_DIR })<CR>', noremap_silent)

-- Redraw screen and update synax sync
mapkey('n', '<leader>u', ':redraw<cr>:syntax sync fromstart<cr>', noremap)
--}}}

-- LOCAL LEADER {{{

-- Reload config
mapkey('n', '<localleader>1', ':lua require("perers.utils").reload_config()<CR>', noremap)

-- Reload current config file
mapkey('n', '<localleader>2', ':lua require("perers.utils").reload_file()<CR>', noremap)

-- toggle options
mapkey('n', '<localleader>tc', ':ColorizerToggle<CR>', noremap_silent)
mapkey('n', '<localleader>th', ':set hlsearch!<CR>', noremap_silent)
mapkey('n', '<localleader>tl', ':set list!<CR>', noremap_silent)
mapkey('n', '<localleader>ts', ':set spell!<CR>', noremap_silent)
mapkey('n', '<localleader>tw', ':set wrap!<CR>', noremap_silent)

-- Cycle number mode
mapkey('n', '<localleader>n', ':call perers#functions#cycle_numbering()<CR>', noremap_silent)

-- Sort lines
mapkey('n', '<localleader>s', ':sort<CR>', noremap_silent)

-- Remove trailing whitespace...
mapkey('n', '<localleader>x', 'mz :%s/\\s\\+$//ge<CR>`z', noremap_silent)

-- Sync clipboard over ssh
mapkey('n', '<localleader>y', ':call perers#osc52#SendViaOSC52()<CR>', noremap_silent)

-- Open scratch file
mapkey('n', '<localleader>z', ':e' .. PERERS_CACHE_DIR .. '/scratch.txt<CR>', noremap_silent)
--}}}

-- NORMAL MODE {{{
-- Save and quit
mapkey('n', '®', ':w<CR>', noremap_silent)
mapkey('n', 'ú', ':q<CR>', noremap_silent)
mapkey('n', '«', ':x<CR>', noremap_silent)

-- Close current buffer
mapkey('n', 'ß', ':bn<CR>:bd#<CR>', noremap)

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

-- open cmd find
mapkey('n', 'Ó', ':find ', noremap)

-- Show open buffers
mapkey('n', '<F4>', ':buffers<CR>:b', noremap)

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
mapkey('n', '¹', ':vertical resize +2<CR>', noremap)
mapkey('n', '¹', ':vertical resize +2<CR>', noremap_silent)
mapkey('n', '²', ':vertical resize -2<CR>', noremap_silent)
mapkey('n', '³', ':resize +2<CR>', noremap_silent)
mapkey('n', '¤', ':resize -2<CR>', noremap_silent)
mapkey('n', '€', ':wincmd = <CR>', noremap_silent)

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

--}}}
--==============================================================================

--==============================================================================
-- PLUGIN CONFIG {{{
local available_plugins = vim.fn.systemlist('ls ' .. PERERS_PLUGIN_DIRECTORY)

for _, plugin in pairs(available_plugins) do
    -- nvim-tree {{{
    if plugin == "nvim-tree.lua" then
        local tree_cb = require'nvim-tree.config'.nvim_tree_callback
        require'nvim-tree'.setup {
            disable_netrw = false,
            view = {
                mappings = {
                    list = {{ key = "C", cb = tree_cb("cd") },}
                },
            },
        }

        vim.g.nvim_tree_icons = {
     default = "",
     symlink = "",
     git = {
       unstaged = "✗",
       staged = "✓",
       unmerged = "!",
       renamed = "➜",
       untracked = "★",
       deleted = "",
       ignored = "◌"
       },
     folder = {
       arrow_open = "▾",
       arrow_closed = "▸",
       default = "#",
       open = "*",
       empty = "$",
       empty_open = "¿",
       symlink = "",
       symlink_open = "",
       },
       lsp = {
         hint = "",
         info = "",
         warning = "",
         error = "",
       }
     }
    end -- }}}

    -- nvim-colorizer {{{
    if plugin == "nvim-colorizer.lua" then
        require'colorizer'.setup()
    end -- }}}

    -- nvim-cmp {{{
    if plugin == "nvim-cmp" then
        local cmp = require('cmp')
        cmp.setup({
            mapping = {

            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'omni' },
                { name = 'buffer' },
                { name = 'spell' },
            }
        })
    end -- }}}

    -- nvim-dap {{{
    if plugin == "nvim-dap" then
        require('perers.dbg')
    end -- }}}

    -- glow.nvim {{{
    if plugin == "glow.nvim" then
        vim.g.glow_binary_path = PERERS_LOCAL_BIN
    end -- }}}

    -- telescope {{{
    if plugin == "telescope" then
        local actions = require('telescope.actions')
        require('telescope').setup {
            defaults = {
                file_sorter = require('telescope.sorters').get_fzy_sorter,
                prompt_prefix = '> ',
                color_devicons = true,

                file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
                grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
                qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

                mappings = {
                    i = {
                        ["<C-x>"] = false,
                        ["<C-q>"] = actions.send_to_qflist,
                    },
                }
            },
            extensions = {
                fzy_native = {
                    override_generic_sorter = false,
                    override_file_sorter = true,
                }
            }
        }

        require('telescope').load_extension('fzy_native')
    end -- }}}
end

--}}}
--==============================================================================

--==============================================================================
-- LANGUAGE SERVERS {{{

local function setup_servers()
  local function requiref(module)
      require(module)
  end

  require'lspinstall'.setup()
  local options = require('perers.language_servers.common_config')
  local nvim_lsp = require('lspconfig')
  local servers = require'lspinstall'.installed_servers()

  for _, server in pairs(servers) do
      module = 'perers.language_servers.' .. server
      local res = pcall(requiref,module)
      if not(res) then
          nvim_lsp[server].setup { on_attach = options.common_on_attach }
      end
  end
end

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

setup_servers()

--}}}
--==============================================================================

--==============================================================================
-- AUTO COMMANDS {{{
vim.api.nvim_exec(
[[
    augroup misc_group
        au!
        au FocusLost * :silent! wall " Save when losing focus
        au VimResized * :wincmd = " Resize splits when the window is resized
    augroup END

    augroup yank_highlight
        au!
        au TextYankPost * lua vim.highlight.on_yank {on_visual = false}
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

    augroup applications_reload_on_config_change
        au!
        au BufWritePost */herbstluftwm/* silent !herbstclient reload
        au BufWritePost */sxhkdrc silent execute '!killall sxhkd; sxhkd &'
    augroup END
]], false)

--}}}
--==============================================================================

-- vim: foldmethod=marker foldlevelstart=1
