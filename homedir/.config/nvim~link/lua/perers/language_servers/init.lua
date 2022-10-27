local M = {}

function M.configure_lsp(lsp_name)
    require("mason").setup()

    local module = 'perers.language_servers.' .. lsp_name
    local res = pcall(requiref,module)
    if not(res) then
        local options = require('perers.language_servers.common_config')
        local nvim_lsp = require('lspconfig')
        nvim_lsp[lsp_name].setup { on_attach = options.common_on_attach }
    end
end

return M
