require('telescope').load_extension('dap')
require('perers.dbg.python')
require("dapui").setup()

-- nvim-dap-virtual-text. Show virtual text for current frame
vim.g.dap_virtual_text = true

local mapkey = vim.api.nvim_set_keymap
local noremap_silent = { noremap = true, silent = true }

mapkey('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>', noremap_silent)
mapkey('n', '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>', noremap_silent)
mapkey('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>', noremap_silent)
mapkey('n', '<leader>dso', '<cmd>lua require"dap".step_out()<CR>', noremap_silent)
mapkey('n', '<leader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>', noremap_silent)

mapkey('n', '<leader>dsc', '<cmd>lua require"dap.ui.variables".scopes()<CR>', noremap_silent)
mapkey('n', '<leader>dhh', '<cmd>lua require"dap.ui.variables".hover()<CR>', noremap_silent)
mapkey('v', '<leader>dhv', '<cmd>lua require"dap.ui.variables".visual_hover()<CR>', noremap_silent)

mapkey('n', '<leader>duh', '<cmd>lua require"dap.ui.widgets".hover()<CR>', noremap_silent)
mapkey('n', '<leader>duf', "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>", noremap_silent)

mapkey('n', '<leader>dsbr', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', noremap_silent)
mapkey('n', '<leader>dsbm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', noremap_silent)
mapkey('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>', noremap_silent)
mapkey('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>', noremap_silent)

-- UI
mapkey('n', '<leader>dui', '<cmd>lua require"dapui".toggle()<CR>', noremap_silent)


-- telescope-dap
mapkey('n', '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>', noremap_silent)
mapkey('n', '<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>', noremap_silent)
mapkey('n', '<leader>dlb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>', noremap_silent)
mapkey('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', noremap_silent)
mapkey('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>', noremap_silent)
