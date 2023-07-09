

-- Add all language servers in a separate file so they can be 
-- both installed with Mason and configured with nvim-lspconfig
--
-- TODO: This is probably not a good idea since I might want to
-- do some custom configuration for each server in nvim-lspconfig.lua

return {
    "lua_ls",
    "clangd",
    "pyright",
}


