-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)

local options = require('perers.language_servers.common_config')

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local binary_path = PERERS_LSP_DIR .. "/groovy/groovy-language-server-all.jar"

require'lspconfig'.groovyls.setup{
    cmd = { "java", "-jar", binary_path },
}
