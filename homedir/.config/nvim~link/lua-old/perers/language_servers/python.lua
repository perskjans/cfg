-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)

local options = require('perers.language_servers.common_config')

require'lspconfig'.pyright.setup{
    on_attach = options.common_on_attach
}
