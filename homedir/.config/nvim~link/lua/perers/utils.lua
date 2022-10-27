
PI = function(arg)
    print(vim.inspect(arg))
end

local utils = {}

function utils.reload_file()
    if vim.bo.filetype == 'vim' then
        vim.cmd(':so %')
    end

    if vim.bo.filetype == 'lua' then
        vim.cmd("lua require('plenary.reload').reload_module('%')")
        vim.cmd('luafile %')
    end

end


function utils.reload_config()
    for module_name, _  in pairs(package.loaded) do
        --print(module_name)
        if string.find(module_name, '^perers') then
           package.loaded[module_name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
end


-- map(mode, key, lua function to call)
--
-- good place to look: telescope.actions (init.lua)
-- lua function to call:  (gets bufnr, not necessarily needed)
--   require('telescope.actions.state').get_selected_entry(bufnr)
--   Actions just take the bufnr and give out information
--   require('telescope.actions').close(bufnr)
--
--   check out telescope.actions for _all the available_ supported
--   actions.
--
--   :h telescope.setup ->
--   :h telescope.builtin ->
--   :h telescope.layout ->
--   :h telescope.actions
--

function utils.git_branches()
    local actions = require('telescope.actions')
    require("telescope.builtin").git_branches({
        attach_mappings = function(_, map)
            map('i', '<c-d>', actions.git_delete_branch)
            map('n', '<c-d>', actions.git_delete_branch)
            return true
        end
    })
end

return utils
