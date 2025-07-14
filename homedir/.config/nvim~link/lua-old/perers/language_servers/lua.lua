-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)

local options = require('perers.language_servers.common_config')

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
--local binary_path = PERERS_LSP_DIR .. "/bin/lua-language-server"
local binary_path = "lua-language-server"

require'lspconfig'.sumneko_lua.setup {
  cmd = {binary_path},
  on_attach = options.common_on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}
