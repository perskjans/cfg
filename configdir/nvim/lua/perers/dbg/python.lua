require('dap-python').setup()
require('dap-python').test_runner = 'pytest'

local mapkey = vim.api.nvim_set_keymap
local noremap_silent = { noremap = true, silent = true }

mapkey('n', '<leader>drm', ":lua require('dap-python').test_method()<CR>", noremap_silent)
mapkey('n', '<leader>drc', ":lua require('dap-python').test_class()<CR>", noremap_silent)
mapkey('v', '<leader>drs', "<ESC>:lua require('dap-python').debug_selection()<CR>", noremap_silent)
